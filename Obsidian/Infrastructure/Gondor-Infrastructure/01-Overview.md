/# Gondor Overview

## System

| Property | Value |
|----------|-------|
| Hostname | gondor |
| OS | Arch Linux (rolling) |
| Architecture | x86_64 |
| Hardware | Desktop PC |
| Desktop | Omarchy — Hyprland + Waybar + uwsm |
| VPN IP | 10.66.66.8 (wg0) |
| SSH | local access only — no SSH server |
| Container runtime | Docker |

> Hardware specs (CPU / RAM / storage) — update with actual values.

Fan control: CoolerControl (`nct6775` kernel module). BIOS: disable Smart Fan Mode, set PWM mode (not DC).

## Key Services

| Service | Description | Config |
|---------|-------------|--------|
| syslog-ng | Syslog client → Lorien TCP:514 | `/etc/syslog-ng/syslog-ng.conf` |
| WireGuard | VPN client — wg0, 10.66.66.8 | polkit rule: `/etc/polkit-1/rules.d/50-wireguard.rules` |
| coolercontrold | Fan speed / PWM control | `/etc/coolercontrol/config.toml` |
| plex | Plex Media Server (Docker) | port :32400, `plexinc/pms-docker` |

## Dotfiles

Managed via GNU Stow from `~/repos/przydasie/dotfiles/desktop/`:

```bash
cd ~/repos/przydasie/dotfiles && ./stow-desktop.sh
```

| Stow package | Target |
|--------------|--------|
| `hypr/` | `~/.config/hypr/` |
| `waybar/` | `~/.config/waybar/` |
| `opencode/` | `~/.config/opencode/` |
| `uwsm/` | uwsm session config |
| `coolercontrol/` | source for `/etc/coolercontrol/config.toml` |
| `scripts/` | `~/.local/bin/` |

## Repository

```
~/repos/przydasie/   — central repo (dotfiles, scripts, docker configs, docs)
```

## Syslog

syslog-ng forwards all system logs to Lorien (10.66.66.10) via TCP:514.

- Config: `dotfiles/system/rsyslog/arch/syslog-ng.conf`
- Log rotation: `dotfiles/system/rsyslog/arch/logrotate-local`
- Logs stored on Lorien: `/var/log/remote/gondor.log` and split files

## Post-install Recovery

Invoke `/jawor-conf` in Claude Code (select "gondor") — the skill clones the repo,
stows dotfiles, installs the theme, configures syslog-ng, WireGuard polkit, and
CoolerControl automatically.

See: `AI/jawor-conf/SKILL.md`

## See Also

- [[Lorien-Infrastructure/04-Syslog-Server]] — Syslog server config on Lorien
