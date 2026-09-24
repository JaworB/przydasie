# Uptime Kuma (Monitoring)

Migrated from [[Shire-Infrastructure/03-Uptime-Kuma|shire]] on 2026-09-24. All 12 monitors and history carried over intact (same `kuma.db` SQLite file, copied while the container was stopped for a clean cutover).

## Deployment

| Property | Value |
|----------|-------|
| Location | `/home/kontenery/uptime_kuma/` on lorien |
| Image | `docker.io/louislam/uptime-kuma:1` |
| Compose file | `/home/kontenery/uptime_kuma/docker-compose.yaml` |
| Repo reference | `docker/service_compose_files/uptime-kuma/docker-compose.yaml` |
| Access | http://10.66.66.10:3001 (VPN only) |

## Networking — network_mode: host

Kept `network_mode: host` on lorien too, unchanged from shire. On shire this was required to work around a `DOCKER-USER` iptables chain that dropped bridge-originated traffic to VPN peers (see [[Shire-Infrastructure/03-Uptime-Kuma]] for that history) — lorien's firewalld setup wasn't specifically re-tested for whether bridge mode would work fine here, since keeping the known-working pattern was the safer call during migration.

Needed a firewalld rich rule since host networking bypasses container port publishing:

```
firewall-cmd --add-rich-rule='rule family="ipv4" source address="10.66.66.0/24" port port="3001" protocol="tcp" accept' --permanent
```

## nginx-proxy-manager (VPS)

Proxy host id `8` in NPM (`kuma.jawor.org`) forwards to `10.66.66.10:3001`. No public DNS record exists for `kuma.jawor.org` currently (pre-existing gap, not introduced by this migration) — access is via the direct VPN IP.

## Status note (2026-09-24)

Container was manually stopped shortly after migration (password forgotten, notification flood from the cutover). Needs a password reset / restart before the "Paperless" monitor URL (currently still pointing at `10.66.66.3:8000`, needs updating to `10.66.66.10:8000`) can be fixed via the UI.

## Monitors, notifications, access-control background

Notification config (Gmail SMTP relay) and the full monitor list carried over unchanged from shire — see [[Shire-Infrastructure/03-Uptime-Kuma]] for the reference table and setup history (kept there since it predates the migration and the details didn't change).

## See Also

- [[Shire-Infrastructure/03-Uptime-Kuma]] — historical, pre-migration setup + monitor/notification reference
- [[index]] — Lorien service overview
