# 00-base.sh — pakiety bazowe: WM, TUI, edytor, Steam

BASE_PACKAGES=(
    base-devel git stow
    wireguard-tools nftables syslog-ng
    hyprland uwsm xdg-desktop-portal-hyprland xdg-desktop-portal-gtk waybar
    sddm
    networkmanager wpa_supplicant
    bluez bluez-utils
    btop nvtop
    neovim
    alacritty
    # audio — bez tego system jest głuchy
    pipewire pipewire-pulse pipewire-alsa wireplumber
    # agent polkit — bez niego GUI-owe prośby o uprawnienia (montowanie
    # dysków, akcje NetworkManagera itd.) po cichu nie działają
    polkit polkit-gnome
    # sesja Hyprland: idle/lock, tło, notyfikacje, OSD głośności/jasności
    hypridle hyprlock swaybg mako swayosd
    # clipboard, screenshoty, jasność ekranu (kluczowe na laptopie), media keys
    wl-clipboard grim slurp brightnessctl playerctl
    # QT na Waylandzie + keyring (SSH/przeglądarka po cichu tego oczekują)
    qt5-wayland qt6-wayland gnome-keyring
    # czcionki — bez nich ikony w waybar/terminalu to puste kwadraty
    noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd
    # zarządzanie energią (laptop, ale nieszkodliwe też na desktopie)
    power-profiles-daemon
)

run "Odświeżenie baz pakietów" sudo pacman -Sy --noconfirm
run "Instalacja pakietów bazowych" sudo pacman -S --needed --noconfirm "${BASE_PACKAGES[@]}"
run "Włączenie NetworkManager" sudo systemctl enable --now NetworkManager
run "Włączenie Bluetooth" sudo systemctl enable --now bluetooth
run "Włączenie power-profiles-daemon" sudo systemctl enable --now power-profiles-daemon
run "Włączenie audio (pipewire/wireplumber, sesja usera)" systemctl --user enable --now pipewire pipewire-pulse wireplumber

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
