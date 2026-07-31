# Shire Overview

## System

| Property | Value |
|----------|-------|
| Hostname | shire |
| OS | Debian GNU/Linux 12 (Bookworm) |
| Architecture | aarch64 (ARM64) |
| Hardware | Raspberry Pi |
| VPN IP | 10.66.66.3 |
| RAM | 8 GB |
| Disk | 57 GB (24 GB used) |
| SSH | `ssh shire` — port 22, user root |
| Container runtime | Docker |

## Directory Structure

```
/root/kontenery/
├── paperless/
│   ├── docker-compose.yaml  # Paperless stack definition
│   ├── data/                # Paperless app data
│   ├── media/               # Document files
│   ├── export/              # Backup exports
│   ├── consume/             # Inbox for new documents
│   ├── pgdata/              # PostgreSQL data
│   └── redisdata/           # Redis data
├── nginx/
│   ├── data/                # nginx-proxy-manager config (not running)
│   └── letsencrypt/         # TLS certificates
├── uptime_kuma/             # Uptime Kuma — ACTIVE, see below
│   ├── docker-compose.yaml
│   ├── kuma.db
│   ├── upload/
│   ├── screenshots/
│   ├── docker-tls/
│   └── old-data-backup-20260801/  # pre-existing DB, superseded 2026-08-01
└── webhost/
    └── site-content/        # Static site content (not running)
```

## SSH Access

```bash
ssh shire   # via ~/.ssh/config → 10.66.66.3, root
```

Requires VPN connection (WireGuard).

## Running Services

See [[index]] for current container status.

Uptime Kuma (`/root/kontenery/uptime_kuma/`) moved from inactive to running 2026-08-01 — see [[03-Uptime-Kuma]] for deployment details, notifications, and monitor list.

## Inactive Services (data preserved)

| Service | Data location | Notes |
|---------|--------------|-------|
| nginx-proxy-manager | /root/kontenery/nginx/ | Not running, config preserved |
| Static webhost | /root/kontenery/webhost/ | Not running |

## See Also

- [[index]] — Shire service overview
- [[02-Paperless]] — Paperless-NGX setup and backup
- [[03-Uptime-Kuma]] — Monitoring dashboard, notifications, monitor list
