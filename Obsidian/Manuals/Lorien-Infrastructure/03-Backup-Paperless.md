# Backup Paperless

Shire pushes Paperless document exports to lorien via rsync.

## Script

**Location**: `scripts/bash/paperless_backup.sh` (in przydasie repository, runs on **shire**)

### How It Works

1. Generate export in Paperless container (document_exporter)
2. Copy export from container to host
3. rsync to lorien (init_user@10.66.66.10:/backup/paperless/)
4. Prune old backups locally (shire)
5. Prune old backups on lorien (remote cleanup)

### Safety Features

The script includes a freshness check before deleting old backups:

- **Retention**: 90 days
- **Freshness threshold**: 14 days
- **Safety rule**: Only deletes backups if the newest one is less than 14 days old

This prevents data loss if backups stop running (e.g., cron failure, network issue).

## Output

Backup file: `export_YYYY-MM-DD.zip`

Example size: ~100-198MB

## Cron

Runs weekly on shire (day/time depends on shire's crontab).

## Retention

- **Keep**: 90 days
- **Safety**: won't delete if newest backup is > 14 days old
- **Applies to**: both local (shire) and remote (lorien)

## Logs

Script outputs to stdout. Capture with cron:

```bash
/path/to/paperless_backup.sh >> /var/log/paperless-backup.log 2>&1
```

## Manual Run

```bash
# On shire
/path/to/paperless_backup.sh
```

## Directory Structure

```
/backup/paperless/
├── export_2026-04-27.zip
├── export_2026-05-04.zip
├── export_2026-05-11.zip
├── export_2026-05-18.zip
├── export_2026-05-25.zip
├── export_2026-06-01.zip
├── export_2026-06-08.zip
├── export_2026-06-15.zip
├── export_2026-06-17.zip
├── export_2026-06-22.zip
├── export_2026-06-29.zip
├── export_2026-07-06.zip
├── export_2026-07-13.zip
└── export_2026-07-20.zip
```

## Technical Details

### Docker Commands

The script uses these Docker commands on shire:

```bash
# Generate export
docker exec paperless-webserver-1 document_exporter \
    /usr/src/paperless/export -z -zn "export_$DATE"

# Copy to host
docker cp paperless-webserver-1:/usr/src/paperless/export/export_$DATE.zip \
    "$EXPORT_DIR/export_$DATE.zip"
```

### Remote Pruning

The script SSHes into lorien and runs a cleanup function remotely:

```bash
ssh init_user@10.66.66.10 bash -s -- "$LORIEN_DIR" "lorien" "$RETENTION_DAYS" "$FRESHNESS_THRESHOLD" <<'PRUNE'
    prune_old "$@"
PRUNE
```

## See Also

- [[01-Overview]] - System overview
- [[02-Backup-HomeAssistant]] - HA backup (pull model vs push model)
