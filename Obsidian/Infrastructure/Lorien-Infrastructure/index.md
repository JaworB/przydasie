# Lorien Infrastructure

Lorien (10.66.66.10) is the central backup, logging, and (as of 2026-09-24) containerized-services server, running 24/7.

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
| paperless_webserver_1 + stack | paperless-ngx (pinned digest) | :8000 | Up — migrated from shire 2026-09-24 |
| uptime-kuma | louislam/uptime-kuma:1 | :3001 (host network) | Stopped (manually, password lockout) — migrated from shire 2026-09-24 |
| Rickroll | modem7/docker-rickroll (pinned digest) | :8180 | Up — migrated from shire 2026-09-24 |

System services (native, not containers):

| Service | Port / Notes |
|---------|--------------|
| rsyslog server | TCP :514 — receives logs from all VPN hosts |
| backup-ha.sh | cron 03:00 daily — pulls HA backup from hassio |

## Topics

- [[01-Overview]] — System, directory structure, SSH access, connected hosts
- [[02-Backup-HomeAssistant]] — HA backup script, cron, retention
- [[03-Backup-Paperless]] — Paperless backup from shire (historical — flow needs redesign, see [[05-Paperless]])
- [[04-Syslog-Server]] — rsyslog server configuration
- [[05-Paperless]] — Paperless-NGX, migrated from shire 2026-09-24
- [[06-Uptime-Kuma]] — Uptime Kuma, migrated from shire 2026-09-24
- [[07-Rickroll]] — Rickroll, migrated from shire 2026-09-24

## See Also

- [[Syslog-Server-Configuration/]] — Syslog client/server config details
- [[Shire-Infrastructure/index]] — former home of these services, now stopped/fallback
