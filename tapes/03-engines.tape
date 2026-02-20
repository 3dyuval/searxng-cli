Output assets/03-listing.gif

Set Shell "bash"
Set FontSize 14
Set Width 900
Set Height 600
Set Padding 20
Set Theme "Catppuccin Mocha"

Type "# List engines"
Enter
Sleep 500ms

Type "searxng -e | head -20"
Enter
Sleep 3s

Type "# Engines as JSON"
Enter
Sleep 500ms

Type "searxng -e -j | jq '.[:3]'"
Enter
Sleep 4s

Type "# List shortcuts"
Enter
Sleep 500ms

Type "searxng -s | head -20"
Enter
Sleep 3s

Type "# Search with engine"
Enter
Sleep 500ms

Type "searxng -e google -o json 'linux kernel' | jq '.results[:2]'"
Enter
Sleep 4s
