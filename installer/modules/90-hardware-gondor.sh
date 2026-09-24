# 90-hardware-gondor.sh — CoolerControl (fan PWM), 1:1 z jawor-conf.

if [ "$(hostname)" != "gondor" ]; then
    step "Pomijam (host != gondor)"
    return 0 2>/dev/null || exit 0
fi

run "Instalacja coolercontrol" yay -S --needed --noconfirm coolercontrold-bin coolercontrol-bin
run "Załadowanie nct6775" sudo modprobe nct6775
echo "nct6775" | sudo tee /etc/modules-load.d/nct6775.conf >/dev/null
run "Enable coolercontrold" sudo systemctl enable --now coolercontrold
run "Kopiowanie config.toml" sudo cp "$REPO_DIR/dotfiles/desktop/coolercontrol/config.toml" /etc/coolercontrol/config.toml
run "Restart coolercontrold" sudo systemctl restart coolercontrold

echo "Pamiętaj: w BIOS wyłącz Smart Fan Mode, ustaw PWM (nie DC)."
