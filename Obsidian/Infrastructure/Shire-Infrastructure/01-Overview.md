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
├── vault/
│   └── vw-data/             # Vaultwarden persistent data
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
├── uptime_kuma/             # Uptime Kuma data (not running)
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

## Inactive Services (data preserved)

| Service | Data location | Notes |
|---------|--------------|-------|
| nginx-proxy-manager | /root/kontenery/nginx/ | Not running, config preserved |
| Uptime Kuma | /root/kontenery/uptime_kuma/ | Not running, DB preserved |
| Static webhost | /root/kontenery/webhost/ | Not running |
