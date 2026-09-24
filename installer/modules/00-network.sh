# 00-network.sh — NetworkManager, wylaczenie konfliktujacego systemd-networkd
# (na rivendell systemd-networkd-wait-online.service wisial w nieskonczonosc
# i blokowal graphical.target, mimo ze NetworkManager robil cala robote)

run "Instalacja networkmanager + wpa_supplicant" sudo pacman -S --needed --noconfirm networkmanager wpa_supplicant

if systemctl list-unit-files systemd-networkd.service >/dev/null 2>&1; then
    run "Wylaczenie systemd-networkd" sudo systemctl disable --now systemd-networkd.service
fi
if systemctl list-unit-files systemd-networkd-wait-online.service >/dev/null 2>&1; then
    run "Wylaczenie systemd-networkd-wait-online" sudo systemctl disable --now systemd-networkd-wait-online.service
fi

run "Wlaczenie NetworkManager" sudo systemctl enable --now NetworkManager
