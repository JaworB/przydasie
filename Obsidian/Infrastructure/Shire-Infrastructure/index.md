# Shire Infrastructure

Shire (10.66.66.3) is a Raspberry Pi running containerized services on Docker. As of 2026-09-24, Paperless-NGX, Uptime Kuma and Rickroll have been **migrated to [[Lorien-Infrastructure/index|Lorien]]** — see that page for the current containerized-services setup. Their containers are stopped on shire (data preserved as rollback fallback); webtest-gritter is the only container still running here.

## System

| Property | Value |
|----------|-------|
| Hostname | shire |
| OS | Debian GNU/Linux 12 (Bookworm) |
| Architecture | aarch64 (ARM64) |
| Hardware | Raspberry Pi — 8 GB RAM, 57 GB disk |
| VPN IP | 10.66.66.3 |
| SSH | `ssh shire` — port 22, user root |
| Container runtime | Docker |

## Running Services

| Container | Image | Port | Status |
|-----------|-------|------|--------|
| webtest-gritter | nginx | :8081 | Up |

## Stopped (migrated to Lorien 2026-09-24, data preserved)

| Container | Image | Former port | Now at |
|-----------|-------|------|--------|
| Rickroll | custom | :8180 | [[Lorien-Infrastructure/07-Rickroll]] |
| paperless-webserver + stack | paperless-ngx:latest | :8000 | [[Lorien-Infrastructure/05-Paperless]] |
| uptime-kuma | louislam/uptime-kuma:1 | :3001 (host network) | [[Lorien-Infrastructure/06-Uptime-Kuma]] |

## Topics

- [[01-Overview]] — System, directory structure, SSH access, inactive services
- [[02-Paperless]] — Paperless-NGX setup and backup (historical — migrated)
- [[03-Uptime-Kuma]] — Monitoring dashboard, notifications, monitor list (historical — migrated)

## See Also

- [[Lorien-Infrastructure/index]] — where these services live now
- [[Lorien-Infrastructure/04-Syslog-Server]] — Centralized logging
- [[Manuals/Logging/01-Lorien-Log-Report]] — Daily log digest (complements Uptime Kuma's live monitoring)
