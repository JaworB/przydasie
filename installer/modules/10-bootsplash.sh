# 10-bootsplash.sh — Plymouth (Twoje logo, bogusz-theme) na Limine+UKI
# archinstall juz postawil Limine + UKI (/boot/EFI/Linux/arch-linux.efi,
# /etc/kernel/cmdline, /etc/mkinitcpio.d/linux.preset) - dokladamy tylko
# plymouth (hook + cmdline + motyw), bez limine-snapper-sync (brak snappera
# na tym etapie, patrz plan).

run "Instalacja plymouth" sudo pacman -S --needed --noconfirm plymouth

if ! grep -Eq '^HOOKS=.*plymouth' /etc/mkinitcpio.conf; then
    run "Dodanie hooka plymouth" sudo sed -i '/^HOOKS=/s/base udev/base udev plymouth/' /etc/mkinitcpio.conf
fi

if ! grep -q 'splash' /etc/kernel/cmdline; then
    run "Dodanie quiet splash do cmdline" sudo sed -i 's/$/ quiet splash/' /etc/kernel/cmdline
fi

run "Przebudowa UKI (mkinitcpio -P)" sudo mkinitcpio -P

REPO_DIR="${REPO_DIR:-$HOME/repos/przydasie}"
if [ ! -d "$REPO_DIR/.git" ]; then
    run "Klonowanie przydasie" git clone --branch arch-installer --depth 1 https://github.com/JaworB/przydasie.git "$REPO_DIR"
fi

run "Instalacja motywu bogusz-theme" bash "$REPO_DIR/scripts/plymouth/bogusz-theme/install.sh"
