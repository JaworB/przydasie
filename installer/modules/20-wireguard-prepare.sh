# 20-wireguard-prepare.sh — TYLKO przygotowanie. Nie generuje kluczy, nie
# łączy z VPN — to robi vps-join/join-host.sh, uruchamiany osobno z VPS.

run "Instalacja wireguard-tools" sudo pacman -S --needed --noconfirm wireguard-tools

step "WireGuard nieskonfigurowany — kolejny krok to vps-join/join-host.sh z VPS"
