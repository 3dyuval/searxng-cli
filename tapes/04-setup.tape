Output assets/04-setup.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 600
Set LineHeight 1.2
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set CursorBlink false

# Show version
Type "searxng -v"
Enter
Sleep 1.5s

# Set custom instance
Type "export SEARXNG_URL=http://localhost:8855"
Enter
Sleep 1s

# Setup completions
Type "ln -s /usr/share/searxng-cli/searxng.yaml ~/.config/carapace/specs/searxng.yaml"
Enter
Sleep 1.5s

# List languages
Type "searxng -l"
Enter
Sleep 2s
