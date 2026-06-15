#!/bin/bash
set -e

THEME_DIR="/usr/share/plymouth/themes/bogusz-theme"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v plymouth-set-default-theme &> /dev/null; then
    echo "Error: plymouth nie jest zainstalowany"
    exit 1
fi

echo "Instalowanie bogusz-theme..."
sudo mkdir -p "$THEME_DIR"
sudo cp "$SCRIPT_DIR"/* "$THEME_DIR/"

echo "Aktywowanie theme..."
sudo plymouth-set-default-theme bogusz-theme
sudo plymouth-set-default-theme --rebuild-initrd

echo "Done! Theme bogusz-theme aktywny."