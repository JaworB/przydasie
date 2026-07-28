# Backup Home Assistant

Lorien pulls HA config backups from hassio via SSH + rsync.

## Script

**Location**: `/usr/local/bin/backup-ha.sh`

### How It Works

1. SSH to hassio (10.66.66.7) as `hassio`
2. Create tar.gz of `/homeassistant` (excluding DB files)
3. rsync archive to lorien `/backup/homeassistant/`
4. Cleanup temp file on hassio
5. Verify backup size (warn if < 1MB)
6. Remove backups older than 30 days
7. Log summary

### Exclusions

The following files are excluded from backup:

| File | Reason |
|------|--------|
| `home-assistant_v2.db` | SQLite database (~140MB), can be recreated |
| `home-assistant_v2.db-wal` | Write-ahead log |
| `home-assistant_v2.db-shm` | Shared memory file |
| `.cache/` | Temporary cache |

### Output

Backup file: `ha-backup-YYYY-MM-DD_HH-MM-SS.tar.gz`

Example size: ~22MB (compressed from ~225MB uncompressed)

## Cron

Runs daily at 03:00:

```
0 3 * * * /usr/local/bin/backup-ha.sh >> /backup/homeassistant/backup.log 2>&1
```

## Retention

- **Keep**: 30 days
- **Delete**: backups older than 30 days
- **Safety**: logs each deletion to backup.log

## Logs

**Location**: `/backup/homeassistant/backup.log`

Example entry:
```
[Thu Jul 23 15:02:51 CEST 2026] Starting Home Assistant backup...
[Thu Jul 23 15:02:55 CEST 2026] Creating archive on hassio...
[Thu Jul 23 15:03:05 CEST 2026] Downloading backup...
[Thu Jul 23 15:03:06 CEST 2026] Cleaning up temp file on hassio...
[Thu Jul 23 15:03:06 CEST 2026] Backup OK: ha-backup-2026-07-23_15-02-51.tar.gz (22M)
[Thu Jul 23 15:03:06 CEST 2026] Removing backups older than 30 days...
[Thu Jul 23 15:03:06 CEST 2026] Done. 1 backup(s), total: 22M
```

## Manual Run

```bash
ssh lorien "/usr/local/bin/backup-ha.sh"
```

## Restore

To restore from backup:

```bash
# On hassio
ssh hassio@10.66.66.7
sudo tar xzf /path/to/ha-backup-YYYY-MM-DD_HH-MM-SS.tar.gz -C /homeassistant
sudo systemctl restart homeassistant
```

## Technical Details

### SSH Connection

Lorien connects to hassio via SSH (key-based auth):

```
lorien → ssh hassio@10.66.66.7 → sudo tar czf /tmp/...
lorien → rsync hassio:/tmp/... → /backup/homeassistant/
lorien → ssh hassio@10.66.66.7 → sudo rm /tmp/...
```

### Why rsync Instead of scp

The hassio SSH session uses a custom subsystem that doesn't support scp.
rsync works because it uses SSH directly for data transfer.

### Path Handling

The `/config` directory on hassio is a symlink to `/homeassistant`.
The tar command uses `-C /homeassistant .` to correctly follow the target directory.

## See Also

- [[01-Overview]] - System overview
- [[03-Backup-Paperless]] - Paperless backup (similar pattern)
