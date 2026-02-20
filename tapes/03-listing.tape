Output assets/03-listing.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 600
Set LineHeight 1.2
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set CursorBlink false

# List engines
Type "searxng -e | head -10"
Enter
Sleep 2s

# Engines as JSON
Type "searxng -e -j | jq '.[:3]'"
Enter
Sleep 2s

# List categories
Type "searxng -c"
Enter
Sleep 1.5s

# List output formats
Type "searxng -o"
Enter
Sleep 1.5s
