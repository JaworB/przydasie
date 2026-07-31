# Rivendell Infrastructure

Rivendell (10.66.66.9) is the secondary machine — Arch Linux + Omarchy (Hyprland) laptop.
Not always powered on; joins the VPN and syslog network intermittently.

## System

| Property | Value |
|----------|-------|
| Hostname | rivendell |
| OS | Arch Linux (rolling) |
| Architecture | x86_64 |
| Hardware | Laptop (Intel Core i5-8365U, 15 GiB RAM) |
| VPN IP | 10.66.66.9 (wg0) |
| SSH | `rivendell` alias in `~/.ssh/config` (via VPN) |

## Running Services

System services (native):

| Service | Description |
|---------|-------------|
| syslog-ng | Log client → Lorien TCP:514 |
| WireGuard | VPN client (wg0, 10.66.66.9) |
| DisplayLink | Dock/external display driver |
| sshd | Remote access via VPN |

## Topics

- [[01-Overview]] — System, hardware, services, dotfiles, post-install recovery

## See Also

- [[Lorien-Infrastructure/04-Syslog-Server]] — Centralized logging
- [[Syslog-Server-Configuration/]] — syslog-ng client config
- [[Gondor-Infrastructure/]] — sibling Arch/Omarchy host, same syslog-ng setup
