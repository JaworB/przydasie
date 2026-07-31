# przydasie — Claude Code Context

## Language

All text in this repository (comments, docs, commit messages, scripts) must be in **English**.

## Infrastructure

VPN network: `10.66.66.0/24` (WireGuard, gateway on VPS)

| Host | IP | OS | Role |
|------|----|----|------|
| gondor | local | Arch Linux + Omarchy | Workstation (current machine) |
| vps | 10.66.66.1, port 2229 | Rocky Linux | VPN gateway, public IP, hosted at Korbank |
| shire | 10.66.66.3 | Debian (Raspberry Pi) | Containerized services |
| lorien | 10.66.66.10 | Fedora | 24/7 server — container backups, central rsyslog, game servers |
| rivendell | 10.66.66.9 | Arch Linux + Omarchy | Laptop, not always available |

SSH connections via aliases defined in `~/.ssh/config`. All hosts reachable only through VPN.

## Repository Structure

| Path | Purpose |
|------|---------|
| `AI/jawor-conf/` | OpenCode skill — desktop config recovery guide |
| `dotfiles/desktop/` | Gondor dotfiles (stow-managed) |
| `dotfiles/laptop/` | Rivendell dotfiles (stow-managed) |
| `dotfiles/system/rsyslog/` | Syslog configs: `arch/` (gondor, rivendell), `debian/` (shire), `fedora/` (lorien server) |
| `docker/VPS/` | VPS Docker Compose |
| `docker/service_compose_files/` | Per-service Compose files |
| `docker/gameserver/` | Game server Compose (lorien) |
| `scripts/bash/` | Bash automation scripts |
| `scripts/ansible/` | Ansible playbooks |
| `scripts/hyprland/` | Hyprland/laptop scripts |
| `VPS_ansible_setup/` | Ansible roles for VPS hardening |
| `Obsidian/Manuals/` | Infrastructure and configuration documentation |
| `edu/` | Learning materials — keep as-is |

## Working Conventions

### Security
- Never commit secrets, passwords, tokens, or keys
- Secrets belong in `.env` files (gitignored) or Ansible Vault
- Check `.gitignore` before staging sensitive files

### Git
- Do not `git push` without explicit user confirmation
- Commit messages follow conventional commits: `fix:`, `feat:`, `docs:`, `chore:`

### Documentation
- After making any infrastructure change (config, script, Ansible role), update the relevant documentation in `Obsidian/Manuals/` or the corresponding skill file
- If no doc exists for the changed component, create one

### Dotfiles
- Managed with GNU Stow
- Desktop (gondor): `cd dotfiles && ./stow-desktop.sh`
- Laptop (rivendell): `cd dotfiles && ./stow-laptop.sh`

## Key Config Files

| File | Description |
|------|-------------|
| `dotfiles/system/rsyslog/arch/syslog-ng.conf` | Arch syslog-ng client (gondor, rivendell) → Lorien TCP 514 |
| `dotfiles/system/rsyslog/debian/client.conf` | Shire rsyslog client → Lorien TCP 514 |
| `dotfiles/system/rsyslog/fedora/server.conf` | Lorien rsyslog server config |
| `VPS_ansible_setup/group_vars/all.yml` | Ansible vars (incl. `rsyslog_server: 10.66.66.10`) |
| `scripts/bash/paperless_backup.sh` | Paperless backup: shire → lorien (weekly, 90d retention) |
