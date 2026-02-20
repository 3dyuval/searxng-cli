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

## Usage

```
searxng [flags] QUERY...
```

### Search

<img src="assets/02-search.gif" alt="Search with JSON output and filters" width="700" />

```bash
searxng 'arch linux wayland'                # open in browser
searxng -o url 'neovim plugins'             # print URL only
searxng -o json 'neovim plugins' | jq       # JSON to jq
searxng -e wikipedia -o url 'type theory'   # engine + URL
searxng -c images -l fr -o url 'paris'      # combined filters
```

<table>
<tr><th>Flag</th><th>Standalone (no query)</th><th>With query</th></tr>
<tr>
  <td rowspan="2"><code>-o</code>, <code>--output</code></td>
  <td><code>searxng -o</code> &mdash; list formats</td>
  <td><code>searxng -o url 'query'</code> &mdash; print URL</td>
</tr>
<tr>
  <td></td>
  <td><code>searxng -o json 'query'</code> &mdash; fetch JSON</td>
</tr>
<tr><td colspan="3"><code>url</code> <code>json</code> <code>html</code> <code>csv</code> <code>rss</code></td></tr>
</table>

### Engines &amp; Shortcuts

<img src="assets/03-listing.gif" alt="Listing engines, categories, formats" width="700" />

```bash
searxng -e                             # list engines
searxng -e -j | jq '.[:3]'            # engines as JSON
searxng -s                             # list shortcuts
searxng -e google 'query'             # search with engine
searxng -s g -c images 'query'        # shortcut + category
```

<table>
<tr><th>Flag</th><th>Standalone (no query)</th><th>With query</th></tr>
<tr>
  <td rowspan="2"><code>-e</code>, <code>--engine</code></td>
  <td><code>searxng -e</code> &mdash; list engines</td>
  <td><code>searxng -e google 'query'</code></td>
</tr>
<tr>
  <td><code>searxng -e -j</code> &mdash; as JSON</td>
  <td><code>searxng -e wikipedia -l fr 'query'</code></td>
</tr>
<tr>
  <td rowspan="2"><code>-s</code>, <code>--shortcut</code></td>
  <td><code>searxng -s</code> &mdash; list shortcuts</td>
  <td><code>searxng -s g 'query'</code></td>
</tr>
<tr>
  <td><code>searxng -s -j</code> &mdash; as JSON</td>
  <td><code>searxng -s g -c images 'query'</code></td>
</tr>
</table>

### Filtering

<img src="assets/04-filtering.gif" alt="Filtering by category, language, page" width="700" />

```bash
searxng -c images 'tiling wm'         # category
searxng -l fr 'paris'                  # language
searxng -p 2 'query'                   # page 2
searxng -c images -l ja -o url 'query' # combined
```

<table>
<tr><th>Flag</th><th>Standalone (no query)</th><th>With query</th></tr>
<tr>
  <td rowspan="2"><code>-c</code>, <code>--category</code></td>
  <td><code>searxng -c</code> &mdash; list categories</td>
  <td><code>searxng -c images 'query'</code></td>
</tr>
<tr>
  <td><code>searxng -c -j</code> &mdash; as JSON</td>
  <td><code>searxng -c videos -l de 'query'</code></td>
</tr>
<tr><td colspan="3"><code>general</code> <code>images</code> <code>videos</code> <code>news</code> <code>music</code> <code>files</code> <code>it</code> <code>science</code></td></tr>
<tr>
  <td rowspan="2"><code>-l</code>, <code>--lang</code></td>
  <td><code>searxng -l</code> &mdash; list languages</td>
  <td><code>searxng -l fr 'query'</code></td>
</tr>
<tr>
  <td><code>searxng -l -j</code> &mdash; as JSON</td>
  <td><code>searxng -l ja -o url 'query'</code></td>
</tr>
<tr><td colspan="3"><code>en</code> <code>de</code> <code>fr</code> <code>es</code> <code>it</code> <code>pt</code> <code>nl</code> <code>ru</code> <code>zh</code> <code>ja</code> <code>ko</code> <code>ar</code> ...</td></tr>
<tr>
  <td><code>-p</code>, <code>--page</code></td>
  <td>&mdash;</td>
  <td><code>searxng -p 2 'query'</code></td>
</tr>
</table>

### Modifiers

<table>
<tr><th>Flag</th><th>Description</th></tr>
<tr><td><code>-j</code>, <code>--json</code></td><td>JSON output &mdash; applies to both listing and search mode</td></tr>
<tr><td><code>-h</code>, <code>--help</code></td><td>Show help</td></tr>
<tr><td><code>-v</code>, <code>--version</code></td><td>Print version</td></tr>
</table>

### Setup

<img src="assets/05-setup.gif" alt="Version, env, completions" width="700" />

```bash
searxng -v                             # show version
export SEARXNG_URL=http://localhost:8855
ln -s /usr/share/searxng-cli/searxng.yaml ~/.config/carapace/specs/searxng.yaml
```

## License

MIT
