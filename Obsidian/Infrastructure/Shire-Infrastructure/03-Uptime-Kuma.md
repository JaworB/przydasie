# Uptime Kuma (Monitoring)

Centralized uptime/status monitoring for VPN hosts and key services. Deployed 2026-08-01.

## Deployment

| Property | Value |
|----------|-------|
| Location | `/root/kontenery/uptime_kuma/` on shire |
| Image | `louislam/uptime-kuma:1` |
| Compose file | `/root/kontenery/uptime_kuma/docker-compose.yaml` |
| Access | http://10.66.66.3:3001 (VPN only) |

A data directory (`kuma.db`, `upload/`, `screenshots/`, `docker-tls/`) already existed from an earlier, undocumented setup with no compose file. That old database was moved aside to `old-data-backup-20260801/` and a fresh instance was created from scratch (old account/monitors weren't relevant anymore).

## Networking — network_mode: host

**Important**: the container runs with `network_mode: host`, not the default bridge network.

Shire has a `DOCKER-USER` iptables chain that only forwards traffic sourced from `10.66.66.0/24` (VPN) or `192.168.0.0/24` (LAN); everything else hits a catch-all DROP at the end. Docker's default bridge gives containers an internal IP (e.g. `172.20.0.x`), which matches neither allowed source — so outbound pings/connections from a bridged container to any VPN peer (including shire's own VPN IP) were silently dropped before masquerade even applied. Confirmed with `docker exec uptime-kuma ping 10.66.66.10` failing 100% while the same ping from the shire host itself worked fine.

Rather than opening a hole in that firewall rule for arbitrary container traffic, Uptime Kuma runs with `network_mode: host` — its outbound traffic then originates from shire's own VPN IP (`10.66.66.3`), which is already allowed. No firewall changes were needed.

**Implication for future services on shire**: any container that needs to reach *other* hosts on the VPN (not just serve requests coming in from it) will hit this same DROP wall on the default bridge network. `network_mode: host` is the working pattern — plan port usage accordingly since there's no bridge/NAT isolation.

## Notifications

Email (SMTP) notification, reusing the same Gmail relay as [[Manuals/Logging/01-Lorien-Log-Report]] but with its own dedicated Google App Password (generated separately so it can be revoked independently of the log-report script).

| Field | Value |
|---|---|
| Host | smtp.gmail.com |
| Port | 587 |
| Secure | off (STARTTLS negotiated automatically) |
| Username / From / To | bjawornicki@gmail.com |

Body text is fixed in this Uptime Kuma version (1.23.16, checked in `/app/server/notification-providers/smtp.js` inside the image) — only the Subject line is customizable, via `{{NAME}}`, `{{HOSTNAME_OR_URL}}`, `{{STATUS}}` macros. No custom HTML/body template support in this version.

Tested 2026-08-01 with a throwaway TCP-port monitor pointed at a closed port (guaranteed `ECONNREFUSED`) — alert delivered successfully, then the test monitor was deleted.

## Monitors

| Monitor | Type | Target | Notes |
|---|---|---|---|
| Lorien (self) | Ping | `10.66.66.10` | |
| Shire (self) | Ping | `10.66.66.3` | |
| VPS | Ping | `10.66.66.1` | |
| Paperless | HTTP(s) | `http://10.66.66.3:8000` | |
| Rsyslog server | TCP Port | `10.66.66.10:514` | |
| VintageStory | TCP Port | `10.66.66.10:42420` | |
| Pi-hole | HTTP(s) | `http://10.66.66.1:85/admin/` | root path `/` returns 403 on Pi-hole v6's webserver; `/admin/` redirects to `/admin/login` and returns 200 |
| nginx-proxy-manager (Reverse-proxy) | HTTP(s) | `http://10.66.66.1:81` | |
| Home Assistant | HTTP(s) | `http://10.66.66.7:8123` | added 2026-08-01 — was a monitoring gap, hassio wasn't covered until pointed out |

Monitors are grouped in the UI under Lorien / Shire / VPS folders.

Gondor and Rivendell (desktop/laptop, not always powered on) are intentionally excluded — monitoring them would just generate constant false "down" alerts. **Vaultwarden is also intentionally excluded** (owner's call, 2026-08-01) despite being reachable at `http://10.66.66.3:892`.

Retries: 2, check interval: 60s (avoids single dropped-packet false positives).

## See Also

- [[index]] — Shire service overview
- [[Manuals/Logging/01-Lorien-Log-Report]] — the other half of the observability stack (passive daily log digest vs. active uptime monitoring)
