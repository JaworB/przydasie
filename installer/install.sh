#!/bin/bash
# Orkiestrator: wykrywa rolę hosta i odpala moduły po kolei.
# Status na ekranie na bieżąco, pełny log w /var/log/jawor-install.log.
set -euo pipefail

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export JAWOR_LOG_FILE="/var/log/jawor-install.log"
export REPO_DIR="$(cd "$INSTALLER_DIR/.." && pwd)"

source "$INSTALLER_DIR/lib/log.sh"
source "$INSTALLER_DIR/lib/role.sh"
source "$INSTALLER_DIR/lib/dotfiles.sh"

[ -f "$INSTALLER_DIR/local.env" ] && source "$INSTALLER_DIR/local.env"

log_init
export JAWOR_ROLE="${JAWOR_ROLE:-$(detect_role)}"
step "Rola hosta: $JAWOR_ROLE ($HOSTNAME)"

step "Uwierzytelnianie sudo (potrzebne przez całą instalację)"
sudo -v
( while true; do sleep 60; sudo -n true 2>/dev/null || exit; done ) &
SUDO_KEEPALIVE_PID=$!
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null' EXIT

for module in "$INSTALLER_DIR"/modules/*.sh; do
    step "Moduł: $(basename "$module")"
    source "$module"
done

step "Instalacja lokalna zakończona. Pełny log: $JAWOR_LOG_FILE"
cat <<EOF

Kolejny krok wykonaj OSOBNO, z sesji mającej dostęp do VPS i gondor:

  vps-join/join-host.sh $HOSTNAME <lan-ip-tego-hosta> <przydzielony-vpn-ip>

Dopiero to dołączy maszynę do WireGuard i zawęzi firewall do VPN-only SSH.
EOF
