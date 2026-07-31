# VPS Infrastructure

VPS (10.66.66.1) is the public gateway and WireGuard VPN server for the network, hosted at Korbank.

## System

| Property | Value |
|----------|-------|
| Hostname | jawor.vpn |
| OS | Rocky Linux 9.7 (Blue Onyx) |
| Architecture | x86_64 |
| Hardware | VPS — Korbank datacenter |
| VPN IP | 10.66.66.1 (server) |
| SSH | `ssh vps` — port 2229, user root |
| Container runtime | Docker 29 |

## Running Services

| Container | Image | Port | Status |
|-----------|-------|------|--------|
| plain-proxy | jc21/nginx-proxy-manager:latest | :80 :81 :443 | Up |
| pihole | pihole/pihole:latest | 10.66.66.1:53, :85 (web) | Up |

WireGuard is native (not a container): interface `palantir`, network `10.66.66.0/24`.

## Topics

- [[01-Overview]] — System, SSH hardening, directory structure
- [[02-WireGuard]] — VPN configuration and peer management

## See Also

- [[Lorien-Infrastructure/04-Syslog-Server]] — Centralized logging
- [[Syslog-Server-Configuration/]] — Rsyslog client setup
- [[Shire-Infrastructure/03-Uptime-Kuma]] — VPS is monitored (ping, Pi-hole :85/admin/, nginx-proxy-manager :81) by Uptime Kuma running on shire
