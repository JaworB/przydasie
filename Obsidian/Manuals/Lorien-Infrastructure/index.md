# Lorien Infrastructure

Lorien (10.66.66.10) is the central backup and logging server for the VPN network.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      VPN Network                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌─────────────┐    backup-ha.sh     ┌─────────────────┐  │
│   │   hassio     │───────────────────>│     lorien      │  │
│   │ 10.66.66.7  │     (daily 3:00)   │ 10.66.66.10     │  │
│   │  Home Asst.  │                    │                 │  │
│   └─────────────┘                    │  /backup/       │  │
│                                       │  ├── homeassist.│  │
│   ┌─────────────┐  paperless_backup  │  └── paperless  │  │
│   │   shire      │──────────────────>│                 │  │
│   │  (Arch Linux)│    (weekly)       │  /var/log/      │  │
│   │  10.66.66.x │                    │  └── remote/    │  │
│   └──────┬──────┘                    │    ├── hassio   │  │
│          │                           │    ├── shire    │  │
│          │     syslog (TCP 514)      │    ├── gondor   │  │
│          └──────────────────────────>│    ├── jawor    │  │
│                                       │    └── ...      │  │
│                                       └─────────────────┘  │
│   ┌─────────────┐     syslog          ┌─────────────────┐  │
│   │   gondor     │───────────────────>│  /var/log/      │  │
│   │  (Arch Linux)│     (TCP 514)      │  └── remote/    │  │
│   └─────────────┘                    │    └── gondor    │  │
│                                       └─────────────────┘  │
│   ┌─────────────┐     syslog          ┌─────────────────┐  │
│   │   jawor      │───────────────────>│  /var/log/      │  │
│   │  (Linux VPS) │     (TCP 514)      │  └── remote/    │  │
│   └─────────────┘                    │    └── jawor     │  │
│                                       └─────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Services

| Service | Description | Port |
|---------|-------------|------|
| [[04-Syslog-Server\|Syslog]] | Centralized logging (rsyslog) | 514/tcp |
| [[02-Backup-HomeAssistant\|HA Backup]] | Home Assistant config backup | - |
| [[03-Backup-Paperless\|Paperless Backup]] | Paperless document export | - |

## Topics

- [[01-Overview]] - System overview, directory structure, SSH access
- [[02-Backup-HomeAssistant]] - HA backup script, cron, retention
- [[03-Backup-Paperless]] - Paperless backup from shire, retention with freshness check
- [[04-Syslog-Server]] - rsyslog server config, templates, connected clients

## Backup Directory Structure

```
/backup/
├── homeassistant/
│   ├── ha-backup-YYYY-MM-DD_HH-MM-SS.tar.gz
│   └── backup.log
└── paperless/
    └── export_YYYY-MM-DD.zip
```

## Backup Flow

1. **Home Assistant**: lorien pulls from hassio via SSH + rsync (daily at 03:00)
2. **Paperless**: shire pushes to lorien via rsync (weekly)
3. **Retention**: HA backups kept 30 days, Paperless kept 90 days (with freshness safety)

## See Also

- [[Syslog-Server-Configuration/]] - Detailed syslog client/server configuration
