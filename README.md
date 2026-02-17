<h1 align="center">searxng-cli</h1>

<p align="center">
  <strong>Search the web from your terminal.</strong>
  <br/>
  <i>Shell wrapper for <a href="https://github.com/searxng/searxng">SearXNG</a> with <a href="https://github.com/carapace-sh/carapace-spec">carapace</a> completions</i>
</p>

<hr />

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
</table>

## Install

```bash
# Arch (AUR)
makepkg -si
```

## Examples

```bash
searxng paris                          # open in browser
searxng -o json paris                  # JSON output
searxng -o url paris                   # print URL only
searxng -e google paris                # engine by name
searxng -s g paris                     # engine by shortcut
searxng -s g -s images paris           # multiple engines
searxng -c images paris                # category
searxng -l fr paris                    # language
searxng -s g -c images -l fr paris     # combined
searxng -p 2 paris                     # page 2
searxng -s rsub 'linux/neovim'         # custom engine: subreddit search
```

## License

MIT
