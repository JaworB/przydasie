#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR/desktop"

echo "==> Stowing desktop dotfiles..."

# coolercontrol is intentionally excluded here: its config lives at
# /etc/coolercontrol/config.toml (not under $HOME), so the jawor-conf skill
# copies it directly instead of stowing it.
PACKAGES="hypr uwsm waybar opencode scripts chromium"

# Stow refuses to touch a target that already exists and isn't a symlink it
# created itself (e.g. Omarchy's default configs, or a leftover file from a
# previous install). Back any such targets up out of the way first so
# restoring dotfiles on an already-configured machine doesn't require manual
# cleanup.
backup_conflicts() {
  local pkg="$1"
  local rel target backup

  stow -n -v -t ~ "$pkg" 2>&1 \
    | grep -oE '(not owned by stow: .*$|over existing target .* since)' \
    | sed -E 's/^not owned by stow: //; s/^over existing target (.*) since$/\1/' \
    | while IFS= read -r rel; do
        target=~/"$rel"
        if [ -e "$target" ] || [ -L "$target" ]; then
          backup="${target}.bak-$(date +%Y%m%d%H%M%S)"
          echo "==> Backing up existing $target -> $backup"
          mv "$target" "$backup"
        fi
      done
}

for pkg in $PACKAGES; do
  if [ -d "$pkg" ]; then
    echo "==> Stowing $pkg..."
    backup_conflicts "$pkg"
    stow -v -t ~ "$pkg"
  fi
done

echo "==> Desktop dotfiles stowed!"
echo "==> Reload Hyprland: hyprctl reload"
