# Lorien Overview

## System

| Property | Value |
|----------|-------|
| Hostname | lorien.jawor.org |
| OS | Fedora 43 |
| Architecture | x86_64 |
| Hardware | Lenovo ThinkCentre |
| VPN IP | 10.66.66.10 |
| RAM | 16 GB |
| Disk | 15 GB root (~8.2 GB free as of 2026-09-24) + 100 GB `/home` (~82 GB free) |
| SSH | `ssh lorien` — port 22, user root |
| Container runtime | Podman |

## SSH Access

```bash
ssh lorien   # via ~/.ssh/config → 10.66.66.10, root
```

Requires VPN connection (WireGuard).

Lorien initiates outbound SSH connections (pull model):

| From | To | User | Purpose |
|------|----|------|---------|
| lorien | hassio (10.66.66.7) | hassio | HA backup (tar + rsync) |

## Directory Structure

```
/
├── backup/
│   ├── homeassistant/          # HA config backups (30-day retention)
│   │   ├── ha-backup-*.tar.gz
│   │   └── backup.log
│   └── paperless/              # Paperless document exports (90-day retention, pre-migration)
│       └── export_*.zip
│
├── home/kontenery/              # Containerized services, migrated from shire 2026-09-24
│   ├── paperless/               # Paperless-NGX stack — see 05-Paperless
│   ├── uptime_kuma/             # Uptime Kuma — see 06-Uptime-Kuma
│   └── rickroll/                # Rickroll — see 07-Rickroll
│
├── var/log/remote/             # Syslog storage (14-day retention)
│   ├── gondor.log              # Full logs from gondor
│   ├── gondor.messages.log     # Info-level
│   ├── gondor.secure.log       # Auth/authpriv
│   ├── gondor.cron.log         # Cron
│   ├── shire.log               # Full logs from shire
│   ├── jawor.log               # Full logs from VPS
│   └── nginx.jawor.org.log     # nginx logs from VPS
│
└── usr/local/bin/
    ├── backup-ha.sh            # HA backup script
    └── podman-compose          # Podman compose utility
```

## Connected Hosts

| Hostname | OS | Syslog client | Backup |
|----------|----|---------------|--------|
| gondor | Arch Linux | syslog-ng | — |
| shire | Debian 12 (RPi) | rsyslog | paperless_backup.sh (weekly) |
| jawor.vpn | Rocky Linux 9 (VPS) | rsyslog | — |
| hassio | Home Assistant OS | — | backup-ha.sh (daily, pull) |

## Local Log Sources

The following hostnames appear in `/var/log/remote/` but originate from local processes on Lorien itself (not remote hosts):

| Hostname | Notes |
|----------|-------|
| BIOS | Local Lorien process |
| Board | Local Lorien process |
| ELF | Local Lorien process |
| Stack | Local Lorien process |

## Crontab

```
0 3 * * * /usr/local/bin/backup-ha.sh >> /backup/homeassistant/backup.log 2>&1
```

## See Also

- [[02-Backup-HomeAssistant]] — HA backup details
- [[03-Backup-Paperless]] — Paperless backup details (historical — flow needs redesign post-migration)
- [[04-Syslog-Server]] — Syslog server configuration
- [[05-Paperless]] — Paperless-NGX, migrated from shire 2026-09-24
- [[06-Uptime-Kuma]] — Uptime Kuma, migrated from shire 2026-09-24 (now monitors lorien itself, self-hosted)
- [[07-Rickroll]] — Rickroll, migrated from shire 2026-09-24
