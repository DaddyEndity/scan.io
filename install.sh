
#!/usr/bin/env bash
set -euo pipefail

REPO="DaddyEndity/scan.io"
APP="scan.io"
BINARY="innit.sh"
INSTALL_DIR="$HOME/.local/bin"

echo ""
echo "  scan.io installer"
echo "  -----------------"

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "[-] Linux is required."
    exit 1
fi

command -v curl >/dev/null || {
    echo "[-] curl is required."
    exit 1
}

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

URL="https://github.com/$REPO/releases/latest/download"

echo "[+] Downloading $BINARY..."

curl -fL --progress-bar "$URL/$BINARY" -o "$TMP/$BINARY"

echo "[+] Installing..."

mkdir -p "$INSTALL_DIR"
install -m 755 "$TMP/$BINARY" "$INSTALL_DIR/$APP"

echo ""
echo "[+] Installation successful!"
echo "[+] Run using: scan.io"
echo ""
