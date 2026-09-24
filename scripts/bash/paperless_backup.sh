#!/bin/bash
set -e

# Runs on lorien (where Paperless itself now lives, since the 2026-09-24
# migration from shire). Exports documents, encrypts the export with a
# dedicated GPG key (public key only — lorien can encrypt but never
# decrypt), and pushes it to the VPS over a write-only restricted SSH key.
# Retention on the VPS side is handled separately by
# paperless_backup_prune_vps.sh, since the restricted key here can't run
# arbitrary remote commands (least privilege — see Obsidian docs).

DATE=$(date +%F)
EXPORT_DIR="/home/kontenery/paperless/export"
GPG_RECIPIENT="0F2FFFA56C891911E0D3FDF59FBD8DD110D80F98" # "paperless-backup" key, public half only (see Lorien-Infrastructure/03-Backup-Paperless.md)
VPS_HOST="10.66.66.1"
VPS_PORT="2229"
VPS_USER="root"
RETENTION_DAYS=90
FRESHNESS_THRESHOLD=14

echo "=== Paperless backup started: $DATE ==="

echo "=== Generating export in container ==="
podman exec paperless_webserver_1 document_exporter /usr/src/paperless/export -z -zn "export_$DATE"

echo "=== Encrypting export ==="
gpg --encrypt --recipient "$GPG_RECIPIENT" --trust-model always \
    --output "$EXPORT_DIR/export_$DATE.zip.gpg" "$EXPORT_DIR/export_$DATE.zip"
rm "$EXPORT_DIR/export_$DATE.zip"

echo "=== Syncing encrypted backup to VPS ==="
rsync -avz --progress -e "ssh -p $VPS_PORT" "$EXPORT_DIR/export_$DATE.zip.gpg" "${VPS_USER}@${VPS_HOST}:/"

# ----- Local retention (with freshness safety check) -----
prune_old() {
    local dir="$1" label="$2" retention_days="$3" freshness_threshold="$4"
    local latest_file file_date_str file_date_epoch now_epoch age_days

    latest_file=$(ls -1 "$dir"/export_*.zip.gpg 2>/dev/null | sort | tail -1)
    if [ -z "$latest_file" ]; then
        echo "WARNING [$label]: No backup files found, skipping cleanup"
        return 0
    fi

    file_date_str=$(echo "$latest_file" | grep -oP '\d{4}-\d{2}-\d{2}')
    if [ -z "$file_date_str" ]; then
        echo "WARNING [$label]: Could not parse date from filename, skipping"
        return 0
    fi

    file_date_epoch=$(date -d "$file_date_str" +%s 2>/dev/null)
    if [ -z "$file_date_epoch" ]; then
        echo "WARNING [$label]: Invalid date, skipping"
        return 0
    fi

    now_epoch=$(date +%s)
    age_days=$(( (now_epoch - file_date_epoch) / 86400 ))

    echo "  [$label] Newest backup: $file_date_str (age: ${age_days} days)"

    if [ "$age_days" -le "$freshness_threshold" ]; then
        echo "  [$label] Removing backups older than ${retention_days} days..."
        find "$dir" -name "export_*.zip.gpg" -mtime +$retention_days -delete
        echo "  [$label] Cleanup complete"
    else
        echo "WARNING [$label]: Newest backup is ${age_days} days old (threshold: ${freshness_threshold}). Skipping cleanup."
    fi
}

echo "=== Retention: cleaning up local exports ==="
prune_old "$EXPORT_DIR" "lorien" "$RETENTION_DAYS" "$FRESHNESS_THRESHOLD"

echo "=== Backup completed ==="
