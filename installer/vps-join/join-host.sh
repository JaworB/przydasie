#!/bin/bash
# Uruchamiane NA VPS (root). VPS nie ma bezpośredniej łączności z nową
# maszyną (prywatna sieć domowa) — config dostarczany jest przez SSH
# VPS -> gondor (VPN) -> nowy host (LAN).
#
# Generuje pełny config klienta (klucz prywatny+publiczny+psk), dopisuje
# peera do lokalnego wg0.conf, wgrywa config na nowy host, podnosi VPN,
# na końcu zawęża firewall nowego hosta do SSH-tylko-z-wg0.
#
# Użycie:
#   JAWOR_VPS_ENDPOINT=<publiczny-ip-lub-host>:<port> \
#     ./join-host.sh <hostname> <lan-ip-nowego-hosta> <vpn-ip>
#
# Przykład:
#   JAWOR_VPS_ENDPOINT=1.2.3.4:56510 ./join-host.sh rivendell 192.168.1.50 10.66.66.9
set -euo pipefail

HOSTNAME_NEW="${1:?podaj hostname nowej maszyny}"
LAN_IP="${2:?podaj adres IP nowej maszyny w sieci LAN}"
VPN_IP="${3:?podaj przydzielony adres VPN, np. 10.66.66.11}"
SERVER_ENDPOINT="${JAWOR_VPS_ENDPOINT:?ustaw JAWOR_VPS_ENDPOINT=<publiczny-ip>:<port>}"

WG_CONF="/etc/wireguard/wg0.conf"
WG_IFACE="wg0"
GONDOR_VPN_IP="10.66.66.8"
GONDOR_USER="jawor"
NEW_USER="jawor"

log() { echo "[join-host] $*"; }

log "Generowanie kluczy dla $HOSTNAME_NEW..."
PRIVATE_KEY="$(wg genkey)"
PUBLIC_KEY="$(echo "$PRIVATE_KEY" | wg pubkey)"
PSK="$(wg genpsk)"
SERVER_PUBLIC_KEY="$(wg show "$WG_IFACE" public-key)"

log "Dopisywanie peera do $WG_CONF..."
tee -a "$WG_CONF" >/dev/null <<EOF

### Client $HOSTNAME_NEW
[Peer]
PublicKey = $PUBLIC_KEY
PresharedKey = $PSK
AllowedIPs = $VPN_IP/32
EOF

log "Restart wg-quick@$WG_IFACE (krótka przerwa dla pozostałych peerów)..."
systemctl restart "wg-quick@$WG_IFACE"

log "Budowanie configu klienta..."
CLIENT_CONF="$(mktemp)"
trap 'rm -f "$CLIENT_CONF"' EXIT
cat > "$CLIENT_CONF" <<EOF
[Interface]
PrivateKey = $PRIVATE_KEY
Address = $VPN_IP/32
DNS = 10.66.66.1

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
PresharedKey = $PSK
Endpoint = $SERVER_ENDPOINT
AllowedIPs = 10.66.66.0/24
EOF

log "Dostarczanie configu na $HOSTNAME_NEW przez gondor..."
scp -o ProxyJump="$GONDOR_USER@$GONDOR_VPN_IP" "$CLIENT_CONF" \
    "$NEW_USER@$LAN_IP:/tmp/wg0.conf.new"

ssh -o ProxyJump="$GONDOR_USER@$GONDOR_VPN_IP" "$NEW_USER@$LAN_IP" bash <<'REMOTE'
set -euo pipefail
sudo install -o root -g root -m 600 /tmp/wg0.conf.new /etc/wireguard/wg0.conf
rm -f /tmp/wg0.conf.new
sudo systemctl enable --now wg-quick@wg0
sleep 2
sudo wg show
REMOTE

log "Zawężanie firewalla na $HOSTNAME_NEW do SSH tylko z 10.66.66.0/24..."
ssh -o ProxyJump="$GONDOR_USER@$GONDOR_VPN_IP" "$NEW_USER@$LAN_IP" bash <<'REMOTE'
set -euo pipefail
sudo sed -i 's#tcp dport 22 ip saddr .*#tcp dport 22 ip saddr 10.66.66.0/24 accept#' /etc/nftables.conf
sudo systemctl restart nftables
sudo nft list ruleset | grep 'dport 22'
REMOTE

log "Gotowe. Zweryfikuj: ssh $NEW_USER@$VPN_IP"
