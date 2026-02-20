Output assets/04-filtering.gif

Set Shell "bash"
Set FontSize 14
Set Width 900
Set Height 600
Set Padding 20
Set Theme "Catppuccin Mocha"

Type "# List categories"
Enter
Sleep 500ms

Type "searxng -c"
Enter
Sleep 2s

Type "# Category search"
Enter
Sleep 500ms

Type "searxng -c images -o url 'tiling wm'"
Enter
Sleep 3s

Type "# Language filter"
Enter
Sleep 500ms

Type "searxng -l fr -o json 'paris' | jq '.results[:2]'"
Enter
Sleep 4s

Type "# Combined filters"
Enter
Sleep 500ms

Type "searxng -c images -l ja -o url 'tokyo'"
Enter
Sleep 3s
