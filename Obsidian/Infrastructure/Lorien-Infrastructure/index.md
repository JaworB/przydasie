# Lorien Infrastructure

Lorien (10.66.66.10) is the central backup and logging server, running 24/7.

## System

| Property | Value |
|----------|-------|
| Hostname | lorien.jawor.org |
| OS | Fedora 43 |
| Architecture | x86_64 |
| Hardware | Lenovo ThinkCentre — 16 GB RAM |
| VPN IP | 10.66.66.10 |
| SSH | `ssh lorien` — port 22, user root |
| Container runtime | Podman |

## Running Services

| Container | Image | Port | Status |
|-----------|-------|------|--------|
| VintageStory | ralnoc/vintagestory:latest | :42420 | Up |
| Stationeers | — | :27015 | Not running |

System services (native, not containers):

| Service | Port / Notes |
|---------|--------------|
| rsyslog server | TCP :514 — receives logs from all VPN hosts |
| backup-ha.sh | cron 03:00 daily — pulls HA backup from hassio |

## Topics

- [[01-Overview]] — System, directory structure, SSH access, connected hosts
- [[02-Backup-HomeAssistant]] — HA backup script, cron, retention
- [[03-Backup-Paperless]] — Paperless backup from shire
- [[04-Syslog-Server]] — rsyslog server configuration

## See Also

- [[Syslog-Server-Configuration/]] — Syslog client/server config details
- [[Shire-Infrastructure/03-Uptime-Kuma]] — Lorien is monitored (ping, rsyslog :514, VintageStory :42420) by Uptime Kuma running on shire
