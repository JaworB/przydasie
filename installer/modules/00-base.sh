# 00-base.sh — pakiety bazowe: WM, TUI, edytor, Steam

BASE_PACKAGES=(
    base-devel git stow
    wireguard-tools nftables syslog-ng
    hyprland uwsm xdg-desktop-portal-hyprland waybar
    networkmanager
    bluez bluez-utils
    btop nvtop
    neovim
    alacritty
)

run "Odświeżenie baz pakietów" sudo pacman -Sy --noconfirm
run "Instalacja pakietów bazowych" sudo pacman -S --needed --noconfirm "${BASE_PACKAGES[@]}"
run "Włączenie NetworkManager" sudo systemctl enable --now NetworkManager
run "Włączenie Bluetooth" sudo systemctl enable --now bluetooth

if ! grep -q '^\[multilib\]' /etc/pacman.conf; then
    step "Włączanie repo [multilib] (wymagane dla Steam)"
    sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
    run "Odświeżenie baz po multilib" sudo pacman -Sy --noconfirm
fi
run "Instalacja Steam" sudo pacman -S --needed --noconfirm steam

if ! command -v yay >/dev/null; then
    step "Instalacja yay (AUR helper)"
    tmpdir="$(mktemp -d)"
    run "Klonowanie yay-bin" git clone https://aur.archlinux.org/yay-bin.git "$tmpdir/yay-bin"
    (cd "$tmpdir/yay-bin" && run "Budowanie yay-bin" makepkg -si --noconfirm)
    rm -rf "$tmpdir"
fi

run "Instalacja bluetuith (TUI Bluetooth)" yay -S --needed --noconfirm bluetuith
