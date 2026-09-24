# Rickroll

Migrated from shire on 2026-09-24, at the user's request after the rest of the migration was already underway — this container backs the public catch-all response for `jawor.org` / `rick.jawor.org` traffic (non-VPN requests hitting the VPS on port 80/443 for the bare domain).

## Deployment

| Property | Value |
|----------|-------|
| Location | `/home/kontenery/rickroll/` on lorien |
| Image | `docker.io/modem7/docker-rickroll@sha256:cf1515b1...` (pinned digest — the `:1.28.0-alpine` tag referenced in shire's old compose file no longer exists in the registry; shire's actually-running container had drifted to `:latest`, same drift pattern seen with the Paperless image) |
| Compose file | `/home/kontenery/rickroll/docker-compose.yaml` |
| Repo reference | `docker/service_compose_files/rickroll/docker-compose.yaml` |
| Access | http://10.66.66.10:8180 (VPN) |

No persistent data/volumes — a fresh deploy on lorien is equivalent to the shire instance.

Firewalld rule added:

```
firewall-cmd --add-rich-rule='rule family="ipv4" source address="10.66.66.0/24" port port="8180" protocol="tcp" accept' --permanent
```

## nginx-proxy-manager (VPS)

Proxy host id `2` (`jawor.org`, `rick.jawor.org`) forwards to `10.66.66.10:8180`. `rick.jawor.org` has no public DNS record (pre-existing gap) — the bare `jawor.org` domain is the one that's actually reachable and verified working end-to-end after migration.

## See Also

- [[Shire-Infrastructure/01-Overview]] — former location (container stopped, webtest-gritter still runs there)
- [[index]] — Lorien service overview
