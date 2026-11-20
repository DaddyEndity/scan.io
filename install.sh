
#!/usr/bin/env bash
set -euo pipefail

REPO="DaddyEndity/scan.io"
APP="scan.io"
BINARY="innit.sh"
INSTALL_DIR="$HOME/.local/bin"

echo ""
echo "  _____  ____    _    _   _   ___ "
echo " / ____|/ ___|  / \  | \ | | |_ _|"
echo " \___ \| |     / _ \ |  \| |  | | "
echo "  ___) | |___ / ___ \| |\  |  | | "
echo " |____/ \____/_/   \_\_| \_| |___|"
echo ""
echo "       Port Scanner Installer"
echo "--------------------------------"

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "[-] Linux required."
    exit 1
fi

command -v curl >/dev/null || {
    echo "[-] curl is required."
    exit 1
}

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

URL="https://raw.githubusercontent.com/$REPO/main/$BINARY"

echo "[+] Downloading scan.io..."

curl -fL --progress-bar "$URL" -o "$TMP/$BINARY"

echo "[+] Installing..."

mkdir -p "$INSTALL_DIR"
install -m 755 "$TMP/$BINARY" "$INSTALL_DIR/$APP"

echo ""
echo "--------------------------------"
echo "[+] Installation complete!"
echo ""
echo "[!] SECURITY WARNING"
echo "You are about to launch scan.io."
echo "Only scan systems you are authorized to test."
echo "--------------------------------"

if [[ -r /dev/tty ]]; then
    read -r -p "Launch scan.io now? [y/N]: " ANSWER </dev/tty

    if [[ "$ANSWER" =~ ^[Yy]$ ]]; then
        echo "[+] Launching scan.io..."
        exec "$INSTALL_DIR/$APP"
    fi
fi

echo "[+] Installed at: $INSTALL_DIR/$APP"
echo "[+] Run manually with: scan.io"
