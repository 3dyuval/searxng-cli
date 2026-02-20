Output assets/04-scripting.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 600
Set LineHeight 1.2
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set CursorBlink false

# Pipe JSON to jq
Type "searxng -j 'rust crates' | jq '.[0]'"
Enter
Sleep 2.5s

# URLs into fzf (conceptual)
Type "searxng -o url 'graphite stacking' | fzf"
Enter
Sleep 2s

# Engine listing as JSON
Type "searxng -e -j | jq '.[:3]'"
Enter
Sleep 2s
