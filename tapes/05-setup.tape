Output assets/05-setup.gif

Set Shell "bash"
Set FontSize 14
Set Width 900
Set Height 500
Set Padding 20
Set Theme "Catppuccin Mocha"

Type "# Version"
Enter
Sleep 500ms

Type "searxng -v"
Enter
Sleep 2s

Type "# Set instance URL"
Enter
Sleep 500ms

Type "export SEARXNG_URL=http://localhost:8855"
Enter
Sleep 2s

Type "# Link carapace completions"
Enter
Sleep 500ms

Type "ln -s /usr/share/searxng-cli/searxng.yaml ~/.config/carapace/specs/searxng.yaml"
Enter
Sleep 2s
