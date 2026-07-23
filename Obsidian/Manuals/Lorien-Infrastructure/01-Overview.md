# Lorien Overview

System overview of the lorien server.

## System

| Property | Value |
|----------|-------|
| Hostname | lorien |
| OS | Fedora 43 |
| IP | 10.66.66.10 |
| Role | Backup & syslog server |

## Directory Structure

```
/
├── backup/
│   ├── homeassistant/          # HA config backups
│   │   ├── ha-backup-*.tar.gz  # Daily backups (30 day retention)
│   │   └── backup.log          # Backup log
│   └── paperless/              # Paperless document exports
│       └── export_*.zip        # Weekly backups (90 day retention)
│
├── var/log/remote/             # Syslog storage
│   ├── hassio.log              # Full logs from hassio
│   ├── shire.log               # Full logs from shire
│   ├── gondor.log              # Full logs from gondor
│   ├── *.messages.log          # Info-level logs
│   ├── *.secure.log            # Auth/authpriv logs
│   └── *.cron.log              # Cron logs
│
└── usr/local/bin/
    ├── backup-ha.sh            # HA backup script
    ├── dotenv                  # Python dotenv utility
    └── podman-compose          # Podman compose utility
```

## SSH Access

Lorien initiates SSH connections (pull model):

| From | To | User | Purpose |
|------|-----|------|---------|
| lorien | hassio (10.66.66.7) | hassio | HA backup (tar + rsync) |

## Connected Hosts

| Hostname | OS | Syslog Client | Backup |
|----------|-----|---------------|--------|
| hassio | HA OS | - | backup-ha.sh (daily) |
| shire | Ubuntu/Debian | rsyslog | paperless_backup.sh (weekly) |
| gondor | Arch Linux | syslog-ng | - |
| jawor | Linux VPS | rsyslog | - |
| nginx.jawor.org | Linux VPS | rsyslog | - |
| BIOS | - | rsyslog | - |
| Board | - | rsyslog | - |
| ELF | - | rsyslog | - |
| Stack | - | rsyslog | - |

## Crontab

```
0 3 * * * /usr/local/bin/backup-ha.sh >> /backup/homeassistant/backup.log 2>&1
```

## See Also

- [[02-Backup-HomeAssistant]] - HA backup details
- [[03-Backup-Paperless]] - Paperless backup details
- [[04-Syslog-Server]] - Syslog server configuration
