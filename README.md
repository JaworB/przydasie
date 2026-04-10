# przydasie

Personal educational repository for learning Linux, Ansible, Docker, and DevOps.

## Contents

| Directory | Description |
|-----------|-------------|
| `AI/` | OpenCode AI skills and configuration |
| `dotfiles/` | System dotfiles managed with GNU stow |
| `docker/` | Docker compose configurations |
| `edu/` | Educational materials and exercises |
| `Obsidian/` | Notes and documentation |
| `plymouth/` | Custom boot themes |
| `scripts/` | Automation scripts |
| `VPS_ansible_setup/` | Ansible playbooks for VPS management |

## Dotfiles

Managed with GNU stow. Symlinked to home directory:

```bash
# Desktop PC
cd dotfiles
./stow-desktop.sh

# Laptop
cd dotfiles
./stow-laptop.sh
```

## Docker

### VPS Services

```bash
cd docker/VPS
cp .env.example .env
# Edit .env with your credentials
docker-compose up -d
```

### Service Compose Files

Ready-to-use compose files for various services:

```bash
cd docker/service_compose_files/{service}
docker-compose up -d
```

Available services:
- `jellyfin` - Media server
- `pihole` - DNS ad-blocker
- `valheim` - Game server

## VPS Ansible

Ansible playbooks for managing VPS servers:

```bash
cd VPS_ansible_setup
# Edit inventory and run playbook
ansible-playbook -i inventory-centos8.yml site-centos8.yml
```

## AI Skills

Custom OpenCode skills for desktop configuration:

- **Omarchy-Custom** - Hyprland/Omarchy desktop configuration
- **jawor-conf** - Personal system configuration recovery

See `AI/` directory for full skill definitions.

## License

MIT