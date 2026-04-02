#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR/desktop"

echo "==> Stowing desktop dotfiles..."

PACKAGES="hypr uwsm waybar opencode coolercontrol scripts"

for pkg in $PACKAGES; do
  if [ -d "$pkg" ]; then
    echo "==> Stowing $pkg..."
    stow -v -t ~ $pkg
  fi
done

echo "==> Desktop dotfiles stowed!"
echo "==> Reload Hyprland: hyprctl reload"