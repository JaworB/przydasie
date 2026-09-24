#!/bin/bash
# Entrypoint pod `curl ... | bash`. Klonuje/aktualizuje przydasie na branchu
# arch-installer i uruchamia install.sh.
set -euo pipefail

REPO_URL="https://github.com/JaworB/przydasie.git"
BRANCH="arch-installer"
REPO_DIR="$HOME/repos/przydasie"

if ! command -v git >/dev/null; then
    sudo pacman -Sy --needed --noconfirm git
fi

if [ -d "$REPO_DIR/.git" ]; then
    git -C "$REPO_DIR" fetch origin "$BRANCH"
    git -C "$REPO_DIR" checkout "$BRANCH"
    git -C "$REPO_DIR" pull --ff-only origin "$BRANCH"
else
    mkdir -p "$HOME/repos"
    git clone --branch "$BRANCH" "$REPO_URL" "$REPO_DIR"
fi

exec "$REPO_DIR/installer/install.sh"
