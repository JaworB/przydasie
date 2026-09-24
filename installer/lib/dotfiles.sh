#!/bin/bash
# Stow dotfiles wg roli hosta, z backupem konfliktu do <plik>.bak-<timestamp>.
# Wymaga: REPO_DIR, JAWOR_ROLE, oraz funkcji run()/log_init() z log.sh już
# załadowanych przez wywołującego.

stow_dotfiles() {
    local dotfiles_dir="$REPO_DIR/dotfiles/$JAWOR_ROLE"
    local pkg pkg_dir conflict

    if [ ! -d "$dotfiles_dir" ]; then
        fail "brak katalogu dotfiles dla roli '$JAWOR_ROLE': $dotfiles_dir"
        exit 1
    fi

    for pkg_dir in "$dotfiles_dir"/*/; do
        pkg="$(basename "$pkg_dir")"

        while IFS= read -r line; do
            conflict="${line#*: }"
            conflict="${conflict% since*}"
            # -e i -L razem łapią zwykły plik, poprawny symlink ORAZ obcy/
            # nieaktualny symlink (np. z innej kopii repo) — stow traktuje
            # każdy z nich jako "nie należący do stow" i przerywa całość.
            if [ -n "$conflict" ] && { [ -e "$HOME/$conflict" ] || [ -L "$HOME/$conflict" ]; }; then
                mv "$HOME/$conflict" "$HOME/$conflict.bak-$(date +%s)"
                echo "[$(date -Iseconds)] backup: $HOME/$conflict" >> "$JAWOR_LOG_FILE"
            fi
        done < <(stow -d "$dotfiles_dir" -t "$HOME" -n "$pkg" 2>&1 | grep "existing target" || true)

        run "stow $pkg" stow -d "$dotfiles_dir" -t "$HOME" -R "$pkg"
    done
}
