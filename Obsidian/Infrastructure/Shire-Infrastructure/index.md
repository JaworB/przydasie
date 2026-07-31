# Shire Infrastructure

Shire (10.66.66.3) is a Raspberry Pi running containerized services on Docker.

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
| vault | vaultwarden/server | :892 | Up (healthy) |
| Rickroll | custom | :8180 | Up (healthy) |
| webtest-gritter | nginx | :8081 | Up |
| paperless-webserver | paperless-ngx:latest | :8000 | Up (healthy) |
| paperless-db | postgres:17 | internal | Up |
| paperless-broker | redis:8 | internal | Up |
| paperless-gotenberg | gotenberg:8.22 | internal | Up |
| paperless-tika | apache/tika | internal | Up |
| uptime-kuma | louislam/uptime-kuma:1 | :3001 (host network) | Up |

## Topics

- [[01-Overview]] — System, directory structure, SSH access, inactive services
- [[02-Paperless]] — Paperless-NGX setup and backup
- [[03-Uptime-Kuma]] — Monitoring dashboard, notifications, monitor list

## See Also

- [[Lorien-Infrastructure/03-Backup-Paperless]] — Backup flow from shire to Lorien
- [[Lorien-Infrastructure/04-Syslog-Server]] — Centralized logging
- [[Manuals/Logging/01-Lorien-Log-Report]] — Daily log digest (complements Uptime Kuma's live monitoring)
