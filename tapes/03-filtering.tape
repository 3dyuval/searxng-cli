Output assets/03-filtering.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 600
Set LineHeight 1.2
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set CursorBlink false

# List available engines
Type "searxng -e | head -10"
Enter
Sleep 2s

# Search with specific engine
Type "searxng -e wikipedia 'type theory'"
Enter
Sleep 2.5s

# List categories
Type "searxng -c"
Enter
Sleep 1.5s

# Category search
Type "searxng -c images 'tiling window managers'"
Enter
Sleep 2.5s

# Language filter
Type "searxng -l ja -o url 'アーチリナックス'"
Enter
Sleep 2s
