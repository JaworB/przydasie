# 30-firewall.sh — ruleset startowy (przejściowy): SSH dozwolone z LAN, żeby
# vps-join/join-host.sh mógł się dobić z gondor. Docelowo (po etapie join)
# ta reguła zostaje zawężona do 10.66.66.0/24 (wg0) przez join-host.sh.

LAN_CIDR="${JAWOR_LAN_CIDR:-192.168.0.0/16}"

run "Instalacja nftables" sudo pacman -S --needed --noconfirm nftables

sudo tee /etc/nftables.conf >/dev/null <<EOF
#!/usr/sbin/nft -f
flush ruleset

table inet filter {
    chain input {
        type filter hook input priority 0; policy drop;

        iif "lo" accept
        ct state established,related accept
        ip protocol icmp accept
        ip6 nexthdr icmpv6 accept

        # Klient DHCP/DHCPv6 — bez tego conntrack nie zawsze łapie
        # DISCOVER/REQUEST (wysyłane z 0.0.0.0), odnowienie dzierżawy
        # się psuje i klient dostaje losowy nowy adres z puli routera.
        udp dport 68 accept
        udp dport 546 accept

        # Stan przejściowy — zawężone do 10.66.66.0/24 przez join-host.sh
        tcp dport 22 ip saddr $LAN_CIDR accept
    }

    chain forward {
        type filter hook forward priority 0; policy drop;
    }
}
EOF

run "Włączenie nftables" sudo systemctl enable --now nftables
run "Aktywacja rulesetu" sudo systemctl restart nftables
