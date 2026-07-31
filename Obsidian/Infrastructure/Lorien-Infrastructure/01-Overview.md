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
| Disk | 15 GB root (4.8 GB used) |
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
│   └── paperless/              # Paperless document exports (90-day retention)
│       └── export_*.zip
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
- [[03-Backup-Paperless]] — Paperless backup details
- [[04-Syslog-Server]] — Syslog server configuration
- [[Shire-Infrastructure/03-Uptime-Kuma]] — Lorien is monitored (ping, rsyslog :514, VintageStory :42420) by Uptime Kuma running on shire
