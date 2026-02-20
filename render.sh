#!/bin/bash
# Render VHS tape files into assets/
# Usage: ./render.sh [--mp4] [tape-name...]
#
# Examples:
#   ./render.sh                    # render all tapes as gif
#   ./render.sh --mp4              # render all tapes as mp4
#   ./render.sh 01-intro           # render one tape
#   ./render.sh --mp4 01-intro 03-filtering

set -euo pipefail

FORMAT=gif
TAPES=()

for arg in "$@"; do
  case "$arg" in
    --mp4) FORMAT=mp4 ;;
    *)     TAPES+=("$arg") ;;
  esac
done

mkdir -p assets

# If no specific tapes given, render all
if [[ ${#TAPES[@]} -eq 0 ]]; then
  for tape in tapes/*.tape; do
    TAPES+=("$(basename "$tape" .tape)")
  done
fi

for name in "${TAPES[@]}"; do
  tape="tapes/${name}.tape"
  [[ -f "$tape" ]] || { echo "skip: $tape not found"; continue; }

  echo "rendering $name..."

  if [[ "$FORMAT" == "mp4" ]]; then
    sed "s|Output assets/.*|Output assets/${name}.mp4|" "$tape" > "/tmp/${name}.tape"
    vhs "/tmp/${name}.tape"
    rm -f "/tmp/${name}.tape"
  else
    vhs "$tape"
  fi
done

echo "done: assets/"
