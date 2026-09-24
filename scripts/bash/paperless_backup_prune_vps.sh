#!/bin/bash
set -e

# Runs on the VPS itself via its own crontab. Lorien's SSH key for pushing
# backups here is restricted to write-only rsync (rrsync -wo, no shell
# access) — least privilege means it can't trigger remote cleanup, so
# retention has to run locally on this side instead.

DIR="/backup/paperless"
RETENTION_DAYS=90
FRESHNESS_THRESHOLD=14

latest_file=$(ls -1 "$DIR"/export_*.zip.gpg 2>/dev/null | sort | tail -1)
if [ -z "$latest_file" ]; then
    echo "WARNING: No backup files found, skipping cleanup"
    exit 0
fi

file_date_str=$(echo "$latest_file" | grep -oP '\d{4}-\d{2}-\d{2}')
if [ -z "$file_date_str" ]; then
    echo "WARNING: Could not parse date from filename, skipping"
    exit 0
fi

file_date_epoch=$(date -d "$file_date_str" +%s 2>/dev/null)
if [ -z "$file_date_epoch" ]; then
    echo "WARNING: Invalid date, skipping"
    exit 0
fi

now_epoch=$(date +%s)
age_days=$(( (now_epoch - file_date_epoch) / 86400 ))

echo "Newest backup: $file_date_str (age: ${age_days} days)"

if [ "$age_days" -le "$FRESHNESS_THRESHOLD" ]; then
    echo "Removing backups older than ${RETENTION_DAYS} days..."
    find "$DIR" -name "export_*.zip.gpg" -mtime +$RETENTION_DAYS -delete
    echo "Cleanup complete"
else
    echo "WARNING: Newest backup is ${age_days} days old (threshold: ${FRESHNESS_THRESHOLD}). Skipping cleanup."
fi
