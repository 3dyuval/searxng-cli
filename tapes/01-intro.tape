Output assets/01-intro.gif

Set Shell "bash"
Set FontSize 18
Set Width 800
Set Height 450
Set Padding 20
Set Theme "Catppuccin Mocha"

Type "# Search the web from your terminal"
Enter
Sleep 1s

Type "searxng -o url 'what is searxng'"
Enter
Sleep 5s

Type "searxng -o json 'what is searxng' | jq '[.results[:5][] | {title: .title[:50], url: .url[:60]}]'"
Enter
Sleep 8s
