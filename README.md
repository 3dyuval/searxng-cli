<h1 align="center">searxng-cli</h1>

<p align="center">
  <strong>Search the web from your terminal.</strong>
  <br/>
  <i>Shell wrapper for <a href="https://github.com/searxng/searxng">SearXNG</a> with <a href="https://github.com/carapace-sh/carapace-spec">carapace</a> completions</i>
</p>

<hr />

<p align="center">
  <img src="assets/01-intro.gif" alt="Basic usage" width="700" />
</p>

## Install

### Manual (any Linux / macOS)

```bash
git clone https://github.com/3dyuval/searxng-cli.git
cd searxng-cli
sudo make install
```

To customize the prefix:

```bash
make install PREFIX=/usr/local DESTDIR=/tmp/staging
```

### Arch Linux (AUR)

```bash
cd packaging
makepkg -si
```

### Debian / Ubuntu

```bash
cd packaging
dpkg-buildpackage -us -uc
sudo dpkg -i ../searxng-cli_*.deb
```

### Fedora / RHEL

```bash
rpmbuild -ba packaging/searxng-cli.spec
```

### Homebrew

```bash
brew install --formula packaging/homebrew/searxng-cli.rb
```

### Nix

```bash
nix-build packaging/nix/default.nix
```

### Uninstall

```bash
sudo make uninstall
```

## Environment Variables

<table>
<tr><th>Variable</th><th>Default</th><th>Description</th></tr>
<tr><td><code>SEARXNG_URL</code></td><td><code>http://localhost:8855</code></td><td>SearXNG instance URL</td></tr>
<tr><td colspan="3"><ul>
<li><a href="https://docs.searxng.org/admin/installation.html">SearXNG Installation</a></li>
<li><a href="https://docs.searxng.org/dev/search_api.html">SearXNG Search API</a></li>
<li><a href="https://searx.space">Public Instances</a></li>
</ul></td></tr>
<tr><td><code>SEARXNG_CONFIG</code></td><td><code>/etc/searxng/settings.yml</code></td><td>Fallback for engine completions</td></tr>
<tr><td colspan="3"><ul>
<li><a href="https://docs.searxng.org/admin/settings/index.html">Settings Reference</a></li>
<li><a href="https://docs.searxng.org/admin/engines.html">Engine Configuration</a></li>
</ul></td></tr>
<tr><td><code>SEARXNG_DATADIR</code></td><td><code>/usr/share/searxng-cli</code></td><td>Data directory (yaml spec, script)</td></tr>
<tr><td colspan="3"><ul>
<li><a href="https://github.com/carapace-sh/carapace-spec">carapace-spec</a></li>
</ul></td></tr>
</table>

## Examples

### Search

<img src="assets/02-search.gif" alt="Search with JSON output and filters" width="700" />

```bash
searxng 'arch linux wayland'           # open in browser
searxng -o json 'neovim plugins'       # JSON output
searxng -o url 'neovim plugins'        # print URL only
searxng -e wikipedia -o url 'type theory'  # engine + URL
searxng -c images -l fr -o url 'paris' # combined filters
```

### Listing

<img src="assets/03-listing.gif" alt="Listing engines, categories, formats" width="700" />

Omit the query to list available values for a flag.

```bash
searxng -e                             # list engines
searxng -e -j | jq '.[:3]'            # engines as JSON
searxng -s                             # list shortcuts
searxng -c                             # list categories
searxng -l                             # list languages
searxng -o                             # list output formats
```

### Setup

<img src="assets/04-setup.gif" alt="Version, env, completions" width="700" />

```bash
searxng -v                             # show version
export SEARXNG_URL=http://localhost:8855
ln -s /usr/share/searxng-cli/searxng.yaml ~/.config/carapace/specs/searxng.yaml
```

## License

MIT
