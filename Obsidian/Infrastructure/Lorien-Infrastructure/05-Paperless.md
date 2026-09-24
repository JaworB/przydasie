# Paperless-NGX

Migrated from [[Shire-Infrastructure/02-Paperless|shire]] on 2026-09-24. Full document count (52) and history verified intact after migration.

## Stack

| Container | Image | Role |
|-----------|-------|------|
| paperless_webserver_1 | ghcr.io/paperless-ngx/paperless-ngx@sha256:6dbe57... | Web UI + API |
| paperless_db_1 | postgres:17 | Database |
| paperless_broker_1 | redis:8 | Task queue |
| paperless_gotenberg_1 | gotenberg:8.22 | Document conversion |
| paperless_tika_1 | apache/tika | Content extraction |

The webserver image is pinned to the exact digest that was actually running on shire at migration time — the old compose file there had drifted to say `:2.18.3` while the container running in production was actually `:latest` resolving to a different digest. Bump this deliberately, not by chasing tags, since paperless-ngx DB migrations are one-way.

## Compose file

**Location on lorien**: `/home/kontenery/paperless/docker-compose.yaml`

**Repo reference**: `docker/service_compose_files/paperless/docker-compose.yaml` + `docker-compose.env.example` (copy to `docker-compose.env` with real secrets, gitignored).

## Storage

Data lives under `/home/kontenery/paperless/` (not `/root/kontenery/`, unlike shire's old layout) — lorien's root filesystem only has ~8 GB free vs. 82 GB free under `/home`.

Ownership matters for podman here (rootful): the numeric UIDs from the official images must match on-disk ownership or the containers refuse to start / lose data access:

| Path | Owner | Mode | Why |
|------|-------|------|-----|
| `pgdata/` | `999:0` | `700` | Postgres official image's internal UID |
| `redisdata/` | `999:0` | `755` | Redis official image's internal UID |
| `data/`, `media/`, `export/`, `consume/` | `1000:1000` | `755` | Paperless's default `USERMAP_UID`/`USERMAP_GID` |

If data is ever relayed through a third machine (e.g. `rsync` staged via a non-root user account before landing on lorien), numeric ownership gets flattened to that user and must be fixed with `chown` afterwards — it will not be preserved automatically.

## Access

```
http://10.66.66.10:8000      # direct, VPN
https://paperless.jawor.org  # via nginx-proxy-manager on VPS, VPN-restricted (see below)
```

## nginx-proxy-manager (VPS)

Proxy host id `7` in NPM's `database.sqlite` (`/root/kontenery/nginx/data/database.sqlite` on vps) forwards `paperless.jawor.org` → `10.66.66.10:8000`. The proxy host has an nginx access rule restricting it to `10.66.66.0/24` — the public-looking domain is VPN-only, not internet-facing.

**Gotcha**: editing `proxy_host.forward_host` in the sqlite DB directly is not enough — NPM bakes the upstream IP into a generated file at `/root/kontenery/nginx/data/nginx/proxy_host/<id>.conf` (`set $server "...";`) which is **not** regenerated from the DB on container restart. After a direct DB edit, also `sed` the `.conf` file and `docker exec plain-proxy nginx -s reload`.

## Firewalld

Lorien restricts inbound ports per-service via firewalld rich rules. Added for Paperless:

```
firewall-cmd --add-rich-rule='rule family="ipv4" source address="10.66.66.0/24" port port="8000" protocol="tcp" accept' --permanent
```

## Known gotcha: podman-compose + firewalld reload breaks container DNS

Running `firewall-cmd --reload` (e.g. to add a rule for an unrelated service, like Rickroll's port) while a podman-compose stack is already running can break the already-running containers' ability to resolve each other's service names via aardvark-dns — even though the nftables rules and aardvark-dns config remain correct, and *new* containers on the same network resolve fine immediately. Symptom: Paperless returns `500` with `django.db.utils.OperationalError: [Errno -3] Temporary failure in name resolution` trying to reach `db`.

**Fix**: `podman-compose restart` (or restart the affected containers) — this refreshes their network namespace registration and resolution works again immediately. Not yet root-caused further than "existing container network namespaces don't survive a firewalld reload cleanly on this podman/netavark version" — if this recurs, check `podman network inspect <name>` and try a fresh throwaway container on the same network first to confirm aardvark-dns itself is healthy before assuming a bigger problem.

## Consume directory

Drop files into `/home/kontenery/paperless/consume/` — Paperless picks them up automatically.

## Backup

Not yet redesigned post-migration. The old shire→lorien weekly rsync flow (`scripts/bash/paperless_backup.sh`) no longer makes sense now that Paperless runs on lorien itself — its cron trigger on shire has been disabled but the script/flow hasn't been replaced yet.

## See Also

- [[Shire-Infrastructure/02-Paperless]] — historical, pre-migration setup
- [[index]] — Lorien service overview
