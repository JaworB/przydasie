# Paperless-NGX

Shire runs the full Paperless-NGX stack for document management.

## Stack

| Container | Image | Role |
|-----------|-------|------|
| paperless-webserver-1 | paperless-ngx:latest | Web UI + API |
| paperless-db-1 | postgres:17 | Database |
| paperless-broker-1 | redis:8 | Task queue |
| paperless-gotenberg-1 | gotenberg:8.22 | Document conversion |
| paperless-tika-1 | apache/tika:latest | Content extraction |

## Compose file

**Location on shire**: `/root/kontenery/paperless/docker-compose.yaml`

**Repo reference**: `docker/service_compose_files/` does not contain a Paperless compose — the live file is the source of truth on shire.

## Access

```
http://shire:8000    # or http://10.66.66.3:8000
```

## Backup

Documents are exported weekly and synced to Lorien:

- **Script**: `scripts/bash/paperless_backup.sh` (runs on shire)
- **Destination**: `lorien:/backup/paperless/export_YYYY-MM-DD.zip`
- **Retention**: 90 days (with freshness safety check — won't delete if newest backup is older than 14 days)

### Manual backup run

```bash
ssh shire
/path/to/paperless_backup.sh
```

### Manual export

```bash
docker exec paperless-webserver-1 document_exporter /usr/src/paperless/export
```

## Consume directory

Drop files into `/root/kontenery/paperless/consume/` — Paperless picks them up automatically.

## See Also

- [[Lorien-Infrastructure/03-Backup-Paperless]] - Backup flow details
- [[index]] - Shire service overview
