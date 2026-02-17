# Maintainer: Yuval.D <yuvddd@pm.me>
pkgname=searxng-cli
pkgver=r11.c2bc8ed
pkgrel=1
pkgdesc="Shell wrapper for SearXNG with carapace completions"
arch=('any')
url="https://github.com/3dyuval/searxng-cli"
license=('MIT')
depends=('curl' 'jq' 'xdg-utils')
optdepends=('carapace-spec: shell completions')
source=("git+https://github.com/3dyuval/searxng-cli.git")
sha256sums=('SKIP')

pkgver() {
  cd "$srcdir/searxng-cli"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
  cd "$srcdir/searxng-cli"

  install -Dm755 searxng.sh "$pkgdir/usr/share/searxng-cli/searxng.sh"
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"

  # Install carapace spec with corrected path
  sed 's|~/proj/searxng.sh/searxng.sh|/usr/share/searxng-cli/searxng.sh|g' \
    searxng.yaml > "$pkgdir/usr/share/searxng-cli/searxng.yaml"
  chmod 644 "$pkgdir/usr/share/searxng-cli/searxng.yaml"

  # Install wrapper script
  install -dm755 "$pkgdir/usr/bin"
  cat > "$pkgdir/usr/bin/searxng" <<EOF
#!/bin/bash
SEARXNG_CLI_VERSION="$pkgver"
source /usr/share/searxng-cli/searxng.sh
_searxng "\$@"
EOF
  chmod 755 "$pkgdir/usr/bin/searxng"
}
