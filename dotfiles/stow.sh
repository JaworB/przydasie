#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "==> Dotfiles directory: $DOTFILES_DIR"

PACKAGES=$(ls -d */ 2>/dev/null | sed 's#/##')

if [ -z "$PACKAGES" ]; then
  echo "No packages found"
  exit 0
fi

for pkg in $PACKAGES; do
  if [ -d "$pkg" ]; then
    echo "==> Stowing $pkg..."
    stow -v -t ~ -d . $pkg
  fi
done

echo "==> Done!"
