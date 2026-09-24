# 00-base.sh — pakiety bazowe: WM, TUI, edytor, Steam

BASE_PACKAGES=(
    base-devel git stow
    wireguard-tools nftables syslog-ng
    hyprland uwsm xdg-desktop-portal-hyprland waybar
    sddm
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

# Bez menedżera logowania system po boocie wraca do zwykłego TTY —
# uwsm/Hyprland same z siebie się nie uruchamiają. sddm pokazuje sesję
# "Hyprland (uwsm)" z /usr/share/wayland-sessions/hyprland-uwsm.desktop
# (dostarcza ją pakiet uwsm).
run "Włączenie sddm" sudo systemctl enable sddm
run "Ustawienie graphical.target jako domyślnego" sudo systemctl set-default graphical.target

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
