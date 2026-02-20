Output assets/02-output-modes.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 600
Set LineHeight 1.2
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set CursorBlink false

# URL-only output
Type "searxng -o url 'neovim plugins'"
Enter
Sleep 2s

# JSON output
Type "searxng -j 'neovim plugins' | head -20"
Enter
Sleep 2.5s

# List output formats
Type "searxng -o"
Enter
Sleep 1.5s
