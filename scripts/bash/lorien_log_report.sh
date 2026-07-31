#!/bin/bash
# Runs on lorien only: central rsyslog store lives at /var/log/remote on this host.
set -euo pipefail

# cron's default PATH doesn't include /usr/local/bin, where npm installs `claude`.
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

LOG_DIR="/var/log/remote"
REPORT_DIR="/var/log/reports"
RETENTION_DAYS=30
PATTERN='error|err|fail|critical|crit|emerg|panic'
MAIL_TO="bjawornicki@gmail.com"
MAIL_FROM="lorien-reports@jawor.org"
MSMTP_ACCOUNT="gmail"
CLAUDE_ENV_FILE="/etc/claude-cron.env"
CLAUDE_MODEL="claude-haiku-4-5-20251001"
SUMMARY_PROMPT="Poniżej surowy raport błędów/krytycznych z logów serwerów za wskazany dzień. Napisz zwięzłe podsumowanie po polsku (kilka zdań lub punktów): które hosty mają problemy, ile wpisów, czy coś wygląda na istotne do sprawdzenia. Pomiń oczywisty szum (rutynowe komunikaty jądra/kontenerów przy starcie)."

# logrotate runs ~00:20 daily with delaycompress, so by the time this runs the
# previous full day is available uncompressed under today's date suffix.
TODAY=$(date +%Y%m%d)
REPORT_DATE=$(date -d yesterday +%F)
REPORT_FILE="$REPORT_DIR/log-report-$REPORT_DATE.txt"

mkdir -p "$REPORT_DIR"

{
    echo "=== Log report for $REPORT_DATE (errors/critical only) ==="
    echo

    for f in "$LOG_DIR"/*.log-"$TODAY"; do
        [ -e "$f" ] || continue
        base=$(basename "$f")
        case "$base" in
            *-messages.log-*|*-secure.log-*|*-cron.log-*) continue ;;
        esac
        host="${base%.log-$TODAY}"

        count=$(grep -ciE "$PATTERN" "$f" 2>/dev/null || true)
        echo "--- Host: $host (matches: $count) ---"
        if [ "$count" -gt 0 ]; then
            grep -iE "$PATTERN" "$f"
        fi
        echo
    done

    echo "--- Host: $(hostname) (local journal) ---"
    journalctl --since yesterday --until today -p err..emerg --no-pager 2>/dev/null || true
    echo

} > "$REPORT_FILE"

find "$REPORT_DIR" -name 'log-report-*.txt' -mtime +"$RETENTION_DAYS" -delete

SUMMARY=""
if [ -f "$CLAUDE_ENV_FILE" ] && command -v claude >/dev/null 2>&1; then
    set -a
    # shellcheck disable=SC1090
    source "$CLAUDE_ENV_FILE"
    set +a
    SUMMARY=$(timeout 60s claude -p --model "$CLAUDE_MODEL" "$SUMMARY_PROMPT" < "$REPORT_FILE" 2>/dev/null || true)
fi
if [ -z "$SUMMARY" ]; then
    SUMMARY="(Podsumowanie AI niedostępne — zobacz załączony plik z pełnym raportem.)"
fi

if command -v msmtp >/dev/null 2>&1; then
    ATTACHMENT_NAME=$(basename "$REPORT_FILE")
    BOUNDARY="boundary-$(date +%s)-$$"
    {
        echo "To: $MAIL_TO"
        echo "From: $MAIL_FROM"
        echo "Subject: Lorien log report: $REPORT_DATE"
        echo "MIME-Version: 1.0"
        echo "Content-Type: multipart/mixed; boundary=\"$BOUNDARY\""
        echo
        echo "--$BOUNDARY"
        echo "Content-Type: text/plain; charset=utf-8"
        echo
        echo "$SUMMARY"
        echo
        echo "--$BOUNDARY"
        echo "Content-Type: text/plain; charset=utf-8; name=\"$ATTACHMENT_NAME\""
        echo "Content-Disposition: attachment; filename=\"$ATTACHMENT_NAME\""
        echo "Content-Transfer-Encoding: base64"
        echo
        base64 "$REPORT_FILE"
        echo
        echo "--$BOUNDARY--"
    } | msmtp -a "$MSMTP_ACCOUNT" "$MAIL_TO"
else
    echo "WARNING: msmtp not found, report saved to $REPORT_FILE but not emailed" >&2
fi
