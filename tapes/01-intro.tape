Output assets/01-intro.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 600
Set LineHeight 1.2
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set CursorBlink false

# Show help
Type "searxng -h"
Enter
Sleep 3s

# Show version
Type "searxng -v"
Enter
Sleep 1.5s

# URL output (no network needed)
Type "searxng -o url 'arch linux wayland'"
Enter
Sleep 2s
