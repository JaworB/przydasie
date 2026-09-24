# 20-hyprland.sh — Hyprland + uwsm + terminal. Bez wlasnego hyprland.conf
# (olewamy dotfiles/motyw na tym etapie) - Hyprland sam wygeneruje domyslny
# config przy pierwszym starcie, z bindem SUPER+Q -> kitty.

run "Instalacja Hyprland + uwsm + kitty" sudo pacman -S --needed --noconfirm \
    hyprland uwsm xdg-desktop-portal-hyprland kitty
