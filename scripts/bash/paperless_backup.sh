#!/bin/bash
set -e

DATE=$(date +%F)
EXPORT_DIR="/root/kontenery/paperless/export"
LORIEN_HOST="10.66.66.10"
LORIEN_USER="init_user"
LORIEN_DIR="/backup/paperless"
RETENTION_DAYS=90
FRESHNESS_THRESHOLD=14

echo "=== Paperless backup started: $DATE ==="

echo "=== Generating export in container ==="
docker exec paperless-webserver-1 document_exporter /usr/src/paperless/export -z -zn "export_$DATE"

echo "=== Copying export from container to host ==="
docker cp paperless-webserver-1:/usr/src/paperless/export/export_$DATE.zip "$EXPORT_DIR/export_$DATE.zip"

echo "=== Syncing to lorien ==="
rsync -avz --progress "$EXPORT_DIR/export_$DATE.zip" "${LORIEN_USER}@${LORIEN_HOST}:${LORIEN_DIR}/"

# ----- Usuwanie starych backupow (z asekuracja) -----
prune_old() {
    local dir="$1" label="$2" retention_days="$3" freshness_threshold="$4"
    local latest_file file_date_str file_date_epoch now_epoch age_days

    latest_file=$(ls -1 "$dir"/export_*.zip 2>/dev/null | sort | tail -1)
    if [ -z "$latest_file" ]; then
        echo "WARNING [$label]: Brak plikow backupu, pomijam czyszczenie"
        return 0
    fi

    file_date_str=$(echo "$latest_file" | grep -oP '\d{4}-\d{2}-\d{2}')
    if [ -z "$file_date_str" ]; then
        echo "WARNING [$label]: Nie mozna odczytac daty z nazwy pliku, pomijam"
        return 0
    fi

    file_date_epoch=$(date -d "$file_date_str" +%s 2>/dev/null)
    if [ -z "$file_date_epoch" ]; then
        echo "WARNING [$label]: Nieprawidlowa data, pomijam"
        return 0
    fi

    now_epoch=$(date +%s)
    age_days=$(( (now_epoch - file_date_epoch) / 86400 ))

    echo "  [$label] Najnowszy backup: $file_date_str (wiek: ${age_days} dni)"

    if [ "$age_days" -le "$freshness_threshold" ]; then
        echo "  [$label] Usuwam backupy starsze niz ${retention_days} dni..."
        find "$dir" -name "export_*.zip" -mtime +$retention_days -delete
        echo "  [$label] Czyszczenie zakonczone"
    else
        echo "WARNING [$label]: Najnowszy backup ma ${age_days} dni (prog: ${freshness_threshold}). Pomijam czyszczenie."
    fi
}

echo "=== Retention: czyszczenie starych backupow ==="
prune_old "$EXPORT_DIR" "shire" "$RETENTION_DAYS" "$FRESHNESS_THRESHOLD"

ssh "${LORIEN_USER}@${LORIEN_HOST}" bash -s -- \
    "$LORIEN_DIR" "lorien" "$RETENTION_DAYS" "$FRESHNESS_THRESHOLD" <<'PRUNE'
    prune_old() {
        local dir="$1" label="$2" retention_days="$3" freshness_threshold="$4"
        local latest_file file_date_str file_date_epoch now_epoch age_days

        latest_file=$(ls -1 "$dir"/export_*.zip 2>/dev/null | sort | tail -1)
        [ -z "$latest_file" ] && { echo "WARNING [$label]: Brak plikow, pomijam"; return 0; }

        file_date_str=$(echo "$latest_file" | grep -oP '\d{4}-\d{2}-\d{2}')
        [ -z "$file_date_str" ] && { echo "WARNING [$label]: Nie mozna odczytac daty, pomijam"; return 0; }

        file_date_epoch=$(date -d "$file_date_str" +%s 2>/dev/null)
        [ -z "$file_date_epoch" ] && { echo "WARNING [$label]: Nieprawidlowa data, pomijam"; return 0; }

        now_epoch=$(date +%s)
        age_days=$(( (now_epoch - file_date_epoch) / 86400 ))
        echo "  [$label] Najnowszy backup: $file_date_str (wiek: ${age_days} dni)"

        if [ "$age_days" -le "$freshness_threshold" ]; then
            echo "  [$label] Usuwam backupy starsze niz ${retention_days} dni..."
            find "$dir" -name "export_*.zip" -mtime +$retention_days -delete
            echo "  [$label] Czyszczenie zakonczone"
        else
            echo "WARNING [$label]: Najnowszy backup ma ${age_days} dni (prog: ${freshness_threshold}). Pomijam czyszczenie."
        fi
    }
    prune_old "$@"
PRUNE

echo "=== Backup completed ==="
