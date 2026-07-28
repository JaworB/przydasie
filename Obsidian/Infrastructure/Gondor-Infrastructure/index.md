# Gondor Infrastructure

Gondor (10.66.66.8) is the primary workstation — Arch Linux + Omarchy (Hyprland) desktop.

## System

| Property | Value |
|----------|-------|
| Hostname | gondor |
| OS | Arch Linux (rolling) |
| Architecture | x86_64 |
| Hardware | Desktop PC |
| VPN IP | 10.66.66.8 (wg0) |
| SSH | local access only — no SSH server |
| Container runtime | Docker |

## Running Services

| Container | Image | Port | Status |
|-----------|-------|------|--------|
| plex | plexinc/pms-docker | :32400 | Up (healthy) |

System services (native):

| Service | Description |
|---------|-------------|
| syslog-ng | Log client → Lorien TCP:514 |
| WireGuard | VPN client (wg0, 10.66.66.8) |
| coolercontrold | Fan PWM control (nct6775) |

## Topics

- [[01-Overview]] — System, hardware, services, dotfiles, post-install recovery

## See Also

- [[Lorien-Infrastructure/04-Syslog-Server]] — Centralized logging
- [[Syslog-Server-Configuration/]] — syslog-ng client config
