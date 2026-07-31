# przydasie

Personal infrastructure and dotfiles repository — home network of 5 hosts connected over WireGuard VPN (`10.66.66.0/24`), plus dotfiles, Docker services, Ansible playbooks, and learning materials.

## Contents

| Directory | Description |
|-----------|--------------|
| `AI/jawor-conf/` | Claude Code skill — desktop config recovery guide (Omarchy/Arch post-install) |
| `dotfiles/desktop/` | Gondor (desktop PC) dotfiles, stow-managed |
| `dotfiles/laptop/` | Rivendell (laptop) dotfiles, stow-managed |
| `dotfiles/system/rsyslog/` | Syslog configs per host: `arch/` (gondor), `debian/` (shire), `fedora/` (lorien server) |
| `docker/VPS/` | VPS Docker Compose stack |
| `docker/service_compose_files/` | Per-service Compose files (jellyfin, pihole, plex, valheim) |
| `docker/gameserver/` | Game server Compose files (lorien) |
| `scripts/bash/` | Bash automation scripts |
| `scripts/ansible/` | Ansible playbooks and roles |
| `scripts/hyprland/` | Hyprland/laptop helper scripts |
| `scripts/python/` | Python utility scripts |
| `scripts/plymouth/` | Custom Plymouth boot theme |
| `scripts/Stationeers/` | Stationeers IC10 scripts |
| `VPS_ansible_setup/` | Ansible roles for VPS hardening |
| `Obsidian/Infrastructure/` | Per-host infrastructure documentation (Gondor, Lorien, Shire, VPS, Syslog server) |
| `Obsidian/Manuals/` | How-to guides (Arch post-install, Hyprland config, game servers, logging) |
| `Obsidian/Edu/` | Study notes (Ansible, Docker, Git, SQL, Python, JS, AI concepts, etc.) |
| `Obsidian/RPG/` | RPG campaign notes |
| `edu/` | Educational exercises and labs — kept as-is |

## Infrastructure

| Host | IP | OS | Role |
|------|----|----|------|
| gondor | local | Arch Linux + Omarchy | Workstation |
| vps | 10.66.66.1, port 2229 | Rocky Linux | VPN gateway, public IP, hosted at Korbank |
| shire | 10.66.66.3 | Debian (Raspberry Pi) | Containerized services |
| lorien | 10.66.66.10 | Fedora | 24/7 server — container backups, central rsyslog, game servers |
| rivendell | — | Arch Linux + Omarchy | Laptop, not always available |

All hosts reachable only through the WireGuard VPN; SSH via aliases defined in `~/.ssh/config`.

## Dotfiles

Managed with GNU Stow. Symlinked to the home directory:

```bash
# Desktop PC (gondor)
cd dotfiles
./stow-desktop.sh

# Laptop (rivendell)
cd dotfiles
./stow-laptop.sh
```

## Docker

### VPS services

```bash
cd docker/VPS
cp .env.example .env
# Edit .env with your credentials
docker-compose up -d
```

### Service compose files

Ready-to-use compose files for individual services:

```bash
cd docker/service_compose_files/{service}
docker-compose up -d
```

Available services: `jellyfin`, `pihole`, `plex`, `valheim`.

### Game servers (lorien)

Compose files under `docker/gameserver/` for dedicated game servers running on lorien.

## VPS Ansible

Ansible playbooks for hardening and managing the VPS:

```bash
cd VPS_ansible_setup
# Edit inventory and run playbook
ansible-playbook -i inventory-centos8.yml site-centos8.yml
```

## AI Skills

Custom Claude Code skill for desktop configuration recovery — see `AI/jawor-conf/SKILL.md`.

## Documentation

Infrastructure and configuration docs live in `Obsidian/Infrastructure/` and `Obsidian/Manuals/`, kept up to date alongside code changes. Project context and working conventions for Claude Code are in [CLAUDE.md](CLAUDE.md).
