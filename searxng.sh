#!/bin/bash
# SearXNG helper functions and completions

SEARXNG_CONFIG="${SEARXNG_CONFIG:-/etc/searxng/settings.yml}"
SEARXNG_URL="${SEARXNG_URL:-http://localhost:8855}"

# Install xng wrapper
searxng_install() {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  # Create wrapper script
  mkdir -p ~/.local/bin
  cat >~/.local/bin/xng <<WRAPPER
#!/bin/bash
source "$script_dir/searxng.sh"
_xng "\$@"
WRAPPER
  chmod +x ~/.local/bin/xng
  echo "installed xng to ~/.local/bin/xng"
  echo ""
  echo "for completions (optional), install carapace-spec then add to your rc:"
  echo "  bash/zsh: source <(carapace-spec '$script_dir/searxng.yaml')"
  echo "  fish:     carapace-spec '$script_dir/searxng.yaml' | source"
}

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

# Query function (called by ~/.local/bin/xng wrapper)
_xng() {
  local output="" engines=() categories=() page="" lang=""
  local query=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
    -o | --output)
      output="$2"
      shift 2
      ;;
    -e | --engine)
      engines+=("!$2")
      shift 2
      ;;
    -c | --category)
      categories+=("!$2")
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

  # Build query with !engine !category :lang prefixes
  local prefixes="${engines[*]} ${categories[*]} ${lang}"
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
