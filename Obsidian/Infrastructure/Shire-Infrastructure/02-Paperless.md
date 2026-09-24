# Paperless-NGX (migrated to Lorien)

**Migrated to [[Lorien-Infrastructure/05-Paperless]] on 2026-09-24.** This page is kept for history — see the Lorien page for the live setup.

Shire used to run the full Paperless-NGX stack for document management. The stack (`docker compose down`) is stopped on shire but its bind-mounted data under `/root/kontenery/paperless/` is left in place, untouched, as a rollback fallback.

## Former stack (shire, stopped)

| Container | Image | Role |
|-----------|-------|------|
| paperless-webserver-1 | paperless-ngx:latest | Web UI + API |
| paperless-db-1 | postgres:17 | Database |
| paperless-broker-1 | redis:8 | Task queue |
| paperless-gotenberg-1 | gotenberg:8.22 | Document conversion |
| paperless-tika-1 | apache/tika:latest | Content extraction |

**Former compose location on shire**: `/root/kontenery/paperless/docker-compose.yaml` (data still present, containers stopped).

## Backup (pre-migration flow, now disabled)

Documents used to be exported weekly on shire and synced to Lorien via `scripts/bash/paperless_backup.sh`. Since Paperless now runs *on* Lorien, this shire→lorien flow no longer makes sense — the cron entry on shire (`/root/kontenery/paperless/export/backup.sh`, weekly) has been commented out. A new backup destination/flow for the Lorien-hosted instance is a separate, not-yet-designed task.

## See Also

- [[Lorien-Infrastructure/05-Paperless]] — current live setup
- [[index]] - Shire service overview
