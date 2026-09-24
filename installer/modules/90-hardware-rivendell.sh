# 90-hardware-rivendell.sh — DisplayLink (dock/monitor zewnętrzny), 1:1 z jawor-conf.

if [ "$(hostname)" != "rivendell" ]; then
    step "Pomijam (host != rivendell)"
    return 0 2>/dev/null || exit 0
fi

run "Instalacja dkms + linux-headers" sudo pacman -S --needed --noconfirm dkms linux-headers
run "Instalacja evdi-dkms + displaylink" yay -S --needed --noconfirm evdi-dkms displaylink
run "Enable displaylink" sudo systemctl enable --now displaylink.service

echo "Weryfikacja: hyprctl monitors — zewnętrzny monitor powinien się pojawić."
