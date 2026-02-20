Output assets/02-search.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 600
Set LineHeight 1.2
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set CursorBlink false

# JSON search results
Type "searxng -o json 'neovim plugins' | head -30"
Enter
Sleep 3s

# Engine-specific search as URL
Type "searxng -e wikipedia -o url 'type theory'"
Enter
Sleep 2s

# Combined filters
Type "searxng -c images -l fr -o url 'paris'"
Enter
Sleep 2s
