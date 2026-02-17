#!/bin/bash
# SearXNG helper functions and completions

SEARXNG_CONFIG="${SEARXNG_CONFIG:-/etc/searxng/settings.yml}"
SEARXNG_URL="${SEARXNG_URL:-http://localhost:8855}"
SEARXNG_DATADIR="${SEARXNG_DATADIR:-/usr/share/searxng-cli}"

# Extract enabled engines from settings.yml
searxng_engines() {
  awk '
        /^  - name:/ {
            if (name && disabled==0) print name
            name = substr($0, index($0, $3))
            disabled = 0
        }
        /disabled: true/ { disabled = 1 }
        END { if (name && disabled==0) print name }
    ' "$SEARXNG_CONFIG" | sort -u
}

# Get enabled engines from API (requires running instance)
searxng_engines_api() {
  curl -s "${SEARXNG_URL}/config" | jq -r '.engines[] | select(.enabled==true) | .name' | sort -u
}

# For carapace completions (API first, YAML fallback)
searxng_complete_engines() {
  local engines
  engines=$(searxng_engines_api 2>/dev/null)
  if [[ -z "$engines" ]]; then
    engines=$(searxng_engines)
  fi
  echo "$engines"
}

# Get shortcuts from API
searxng_complete_shortcuts() {
  curl -s "${SEARXNG_URL}/config" | jq -r '.engines[] | select(.enabled==true) | .shortcut' | sort -u
}

# Query function (called by /usr/bin/searxng wrapper)
_searxng() {
  local output="" bangs=() page="" lang=""
  local query=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
    -v | --version)
      echo "searxng-cli ${SEARXNG_CLI_VERSION:-dev}"
      return 0
      ;;
    -h | --help)
      local yaml="${SEARXNG_DATADIR}/searxng.yaml"
      [[ -f "$yaml" ]] || yaml="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/searxng.yaml"
      awk '
        /^description:/ { desc = substr($0, index($0,$2)) }
        /^flags:/ { flags=1; next }
        flags && /^[^ ]/ { flags=0 }
        flags && /^  / {
          gsub(/^  /, "")
          split($0, a, ":")
          flag = a[1]
          # extract short flag for usage line
          split(flag, f, ",")
          short = f[1]; gsub(/^ +| +$/, "", short)
          gsub(/=/, "", short)
          usage = usage " [" short "]"
        }
        /^env:/ { env=1; next }
        env && /^[^ ]/ { env=0 }
        env && /^  / { envlines = envlines $0 "\n" }
        END {
          print "usage: searxng" usage " QUERY...\n"
          print desc "\n"
          print "positional arguments:"
          print "  QUERY                 the search query\n"
        }
      ' "$yaml"
      echo "options:"
      awk '
        /^flags:/ { flags=1; next }
        flags && /^[^ ]/ { flags=0 }
        flags && /^  / { gsub(/^  /, "  "); print }
      ' "$yaml"
      echo ""
      echo "environment:"
      echo "  SEARXNG_URL: ${SEARXNG_URL}"
      echo ""
      echo "completions (requires carapace):"
      echo "  ln -s $yaml ~/.config/carapace/specs/searxng.yaml"
      return 0
      ;;
    -o | --output)
      output="$2"
      shift 2
      ;;
    -e | --engine)
      bangs+=("!$2")
      shift 2
      ;;
    -s | --shortcut)
      bangs+=("!$2")
      shift 2
      ;;
    -c | --category)
      bangs+=("!$2")
      shift 2
      ;;
    -p | --page)
      page="$2"
      shift 2
      ;;
    -l | --lang)
      lang=":$2"
      shift 2
      ;;
    *)
      query="$query $1"
      shift
      ;;
    esac
  done

  query="${query## }" # trim leading space

  # Build query with !bangs :lang prefixes
  local prefixes="${bangs[*]} ${lang}"
  prefixes="${prefixes## }"
  prefixes="${prefixes%% }"
  [[ -n "$prefixes" ]] && query="$prefixes $query"

  local url="${SEARXNG_URL}/search?q=$(echo "$query" | sed 's/ /+/g')"
  [[ -n "$output" && "$output" != "url" ]] && url="${url}&format=${output}"
  [[ -n "$page" ]] && url="${url}&pageno=${page}"

  if [[ "$output" == "url" ]]; then
    echo "$url"
  elif [[ -n "$output" ]]; then
    curl -s "$url"
  else
    xdg-open "$url"
  fi
}
