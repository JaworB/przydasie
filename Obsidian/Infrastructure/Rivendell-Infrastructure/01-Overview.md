# Rivendell Overview

## System

| Property | Value |
|----------|-------|
| Hostname | rivendell |
| OS | Arch Linux (rolling) |
| Kernel | 7.1.4-arch1-1 |
| Architecture | x86_64 |
| Hardware | Laptop — Intel Core i5-8365U @ 1.60GHz, 15 GiB RAM |
| Desktop | Omarchy — Hyprland + uwsm |
| VPN IP | 10.66.66.9 (wg0) |
| SSH | `rivendell` alias in `~/.ssh/config` (via VPN) |
| Availability | Not always powered on — laptop, used intermittently |

## Key Services

| Service | Description | Config |
|---------|-------------|--------|
| syslog-ng | Syslog client → Lorien TCP:514 | `/etc/syslog-ng/syslog-ng.conf` |
| WireGuard | VPN client — wg0, 10.66.66.9 | native `wg-quick@wg0` |
| DisplayLink | Dock / external display driver | `displaylink` service |
| sshd | Remote access via VPN | native OpenSSH |

## Dotfiles

Managed via GNU Stow from `~/repos/przydasie/dotfiles/laptop/`:

```bash
cd ~/repos/przydasie/dotfiles && ./stow-laptop.sh
```

| Stow package | Target |
|--------------|--------|
| `hypr/` | `~/.config/hypr/` |
| `opencode/` | `~/.config/opencode/` |
| `uwsm/` | uwsm session config |
| `scripts/` | `~/.local/bin/` |

## Repository

```
~/repos/przydasie/   — central repo (dotfiles, scripts, docker configs, docs)
```

## Syslog

syslog-ng forwards all system logs to Lorien (10.66.66.10) via TCP:514, mirroring
Gondor's setup — same source config, generic across Arch hosts.

- Config: `dotfiles/system/rsyslog/arch/syslog-ng.conf`
- Log rotation: `dotfiles/system/rsyslog/arch/logrotate-local`
- Logs stored on Lorien: `/var/log/remote/rivendell.log` and split files
  (`rivendell-messages.log`, `rivendell-secure.log`, `rivendell-cron.log`)

Verified active: syslog-ng@default is running and connected (`ESTAB` to
10.66.66.10:514), logs are landing on Lorien in real time. Since the laptop isn't
always on, expect gaps in log coverage when rivendell is powered off.

## Post-install Recovery

Invoke `/jawor-conf` in Claude Code (select "rivendell") — the skill clones the repo,
stows dotfiles, installs the theme, configures syslog-ng, WireGuard, and DisplayLink
automatically.

See: `AI/jawor-conf/SKILL.md`

## See Also

- [[Lorien-Infrastructure/04-Syslog-Server]] — Syslog server config on Lorien
- [[Gondor-Infrastructure/01-Overview]] — sibling Arch/Omarchy host
