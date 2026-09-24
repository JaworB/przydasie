# 10-dotfiles.sh — stow dotfiles wg roli + auto-sync przy starcie sesji.
# Zastępuje stow-desktop.sh/stow-laptop.sh (te zostają wycofane po walidacji).

stow_dotfiles

SYNC_BIN="$HOME/.local/bin/jawor-dotfiles-sync"
mkdir -p "$(dirname "$SYNC_BIN")"
cat > "$SYNC_BIN" <<EOF
#!/bin/bash
set -euo pipefail
export JAWOR_LOG_FILE="\$HOME/.local/state/dotfiles-sync.log"
export REPO_DIR="$REPO_DIR"
export JAWOR_ROLE="$JAWOR_ROLE"
mkdir -p "\$(dirname "\$JAWOR_LOG_FILE")"
source "$REPO_DIR/installer/lib/log.sh"
source "$REPO_DIR/installer/lib/dotfiles.sh"
log_init
run "git pull przydasie" git -C "\$REPO_DIR" pull --ff-only
stow_dotfiles
EOF
chmod +x "$SYNC_BIN"
ok "Zainstalowano $SYNC_BIN"

mkdir -p "$HOME/.config/systemd/user"
cat > "$HOME/.config/systemd/user/dotfiles-sync.service" <<EOF
[Unit]
Description=Sync dotfiles przydasie

[Service]
Type=oneshot
ExecStart=$SYNC_BIN
EOF

cat > "$HOME/.config/systemd/user/dotfiles-sync.timer" <<EOF
[Unit]
Description=Okresowy sync dotfiles

[Timer]
OnStartupSec=1min
OnUnitActiveSec=30min
Persistent=true

[Install]
WantedBy=timers.target
EOF

run "Włączenie timera dotfiles-sync" systemctl --user enable --now dotfiles-sync.timer
