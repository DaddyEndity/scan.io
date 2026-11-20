
#!/usr/bin/env bash
set -euo pipefail

REPO="DaddyEndity/scan.io"
APP="scan.io"
INSTALL_DIR="$HOME/.local/bin"
BINARY="scan.io-linux-x64"

echo "[+] Installing scan.io..."

# Check architecture
ARCH="$(uname -m)"

if [[ "$ARCH" != "x86_64" ]]; then
    echo "[-] This release currently supports Linux x86_64 only."
    exit 1
fi

# Check dependencies
for cmd in curl sha256sum; do
    command -v "$cmd" >/dev/null || {
        echo "[-] Missing dependency: $cmd"
        exit 1
    }
done

# Create temporary directory
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

BASE_URL="https://github.com/$REPO/releases/latest/download"

echo "[+] Downloading application..."

curl -fL "$BASE_URL/$BINARY" -o "$TMP/$BINARY"
curl -fL "$BASE_URL/SHA256SUMS" -o "$TMP/SHA256SUMS"

# Verify download integrity
cd "$TMP"
grep -F "  $BINARY" SHA256SUMS | sha256sum -c -

# Install
mkdir -p "$INSTALL_DIR"
install -m 755 "$BINARY" "$INSTALL_DIR/$APP"

echo "[+] Installation complete!"
echo "[+] Run your application with: scan.io"
echo "[!] Ensure $INSTALL_DIR is in your PATH."
