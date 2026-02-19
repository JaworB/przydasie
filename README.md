# przydasie

Public educational repository for learning Linux, Ansible, Docker, and DevOps.

## Contents

- `AI/` - AI configuration and skills for OpenCode
- `edu/` - Educational materials and exercises
- `scripts/` - Automation scripts and utilities
- `Obsidian/` - Notes and documentation
- `docker/` - Docker configurations

## AI Skills

This repo contains custom OpenCode skills for jawor's desktop setup:

- **Omarchy-Custom** - Hyprland/Omarchy desktop configuration
- **jawor-conf** - Personal system configuration

See `AI/` directory for full skill definitions.

## Usage

Clone and explore. Files marked as examples/educational only.

## Docker Setup

For Docker services, copy the environment template and fill in values:

```bash
cd docker/VPS
cp .env.example .env
# Edit .env with your credentials
docker-compose up -d
```

## License

MIT
