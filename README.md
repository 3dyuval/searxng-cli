# SearXNG shell with autocomplete

## Requirements

- SearXNG instance
- `curl`
- `xdg-open` (Linux) or `open` (macOS)
- [`carapace-spec`](https://github.com/carapace-sh/carapace-spec) (optional, for shell completions)

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SEARXNG_URL` | `http://localhost:8855` | SearXNG instance URL |
| `SEARXNG_CONFIG` | `/etc/searxng/settings.yml` | Path to settings (for engine completions)* |

*Engine completions are fetched from `$SEARXNG_URL/config` endpoint, falling back to parsing `$SEARXNG_CONFIG` if unavailable.

## Installation

```bash
source searxng.sh && searxng_install
```

## Usage

### Single engine

xng -e google paris # → !google paris

### Multiple engines (chainable)

xng -e google -e ddg paris # → !google !ddg paris

### Category + engine + language

xng -e wp -c images -l fr paris # → !wp !images :fr paris

### Just open browser

xng paris # opens browser

### CLI output

xng -o json paris # returns JSON
xng -o url paris  # prints the URL without fetching
