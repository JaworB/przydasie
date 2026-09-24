#!/bin/bash
# Orkiestrator: wykrywa rolę hosta i odpala włączone moduły po kolei.
# Status na ekranie na bieżąco, pełny log w /var/log/jawor-install.log.
#
# Domyślnie odpala tylko MVP (sieć + bootsplash + Hyprland + seamless-login).
# WireGuard/firewall/rsyslog/hardware/dotfiles/Steam są odłożone na później —
# kod zostaje w modules/, tylko nie jest częścią domyślnego przebiegu.
# Nadpisz przez: ENABLED_MODULES="00-network.sh 40-rsyslog.sh" ./install.sh
set -euo pipefail

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export JAWOR_LOG_FILE="/var/log/jawor-install.log"
export REPO_DIR="$(cd "$INSTALLER_DIR/.." && pwd)"

DEFAULT_MODULES="00-network.sh 10-bootsplash.sh 20-hyprland.sh 30-seamless-login.sh"

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

for module_name in ${ENABLED_MODULES:-$DEFAULT_MODULES}; do
    module="$INSTALLER_DIR/modules/$module_name"
    if [ ! -f "$module" ]; then
        fail "Brak modułu: $module_name"
        exit 1
    fi
    step "Moduł: $module_name"
    source "$module"
done

step "Instalacja lokalna zakończona. Pełny log: $JAWOR_LOG_FILE"
echo "Zrób: sudo reboot — powinien odpalić się Plymouth, potem Hyprland, bez ekranu logowania."
