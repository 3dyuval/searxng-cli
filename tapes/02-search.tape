Output assets/02-search.gif

Set Shell "bash"
Set FontSize 14
Set Width 900
Set Height 600
Set Padding 20
Set Theme "Catppuccin Mocha"

Type "# Output formats"
Enter
Sleep 500ms

Type "searxng -o url 'neovim plugins'"
Enter
Sleep 3s

Type "searxng -o json 'neovim plugins' | jq '.results[:2]'"
Enter
Sleep 4s

Type "# Engine + output"
Enter
Sleep 500ms

Type "searxng -e wikipedia -o url 'type theory'"
Enter
Sleep 3s

Type "# Combined filters"
Enter
Sleep 500ms

Type "searxng -c images -l fr -o url 'paris'"
Enter
Sleep 3s
