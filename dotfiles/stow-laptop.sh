#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR/laptop"

echo "==> Stowing laptop dotfiles..."

PACKAGES="hypr uwsm opencode scripts"

for pkg in $PACKAGES; do
  if [ -d "$pkg" ]; then
    echo "==> Stowing $pkg..."
    stow -v -t ~ $pkg
  fi
done

echo "==> Laptop dotfiles stowed!"
echo "==> Reload Hyprland: hyprctl reload"