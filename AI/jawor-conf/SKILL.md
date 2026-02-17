---
name: jawor-conf
description: >
  User-specific desktop configuration for jawor.
  Includes OS info, window manager, GitHub repo, SSH configs, and common paths.
  Use this skill to avoid repeating configuration details in new sessions.
---

> **IMPORTANT**: Update this skill whenever you learn new useful information about jawor's
> setup, preferences, or configuration. This avoids repeated questions in future sessions.

# jawor-conf Skill

Personal desktop configuration for jawor on Omarchy/Arch Linux.

## System Info

| Property | Value |
|----------|-------|
| OS | Arch Linux (Omarchy) |
| Window Manager | Hyprland |
| Home Directory | /home/jawor |
| Default Editor | code (VS Code) |

## Git Security

**ALWAYS check for secrets before committing to public repo.**

Before any commit/push:
- Scan for API keys, tokens, passwords
- Check `.gitignore` covers sensitive files
- Review diff with `git diff --staged`
- Use `git status` to see what will be committed

This repo is public - do not expose credentials, SSH keys, or sensitive configs.

- **Name**: przydasie
- **URL**: https://github.com/JaworB/przydasie.git
- **Local path**: ~/repos/przydasie

### Repo Structure

```
przydasie/
├── AI/                        # AI-related configs
│   ├── jawor-conf/            # This skill (symlinked to ~/.opencode/skills/)
│   ├── omarchy-custom-skill/  # Custom omarchy overrides
│   └── openclawbot/           # OpenClaw bot config
├── Obsidian/                  # Obsidian vault (English)
├── Obsidian_PL/               # Obsidian vault (Polish)
├── docker/                    # Docker configs
├── edu/                       # Educational materials
├── scripts/                  # Scripts
├── .ansible/                 # Ansible configs
├── .vscode/                   # VS Code settings
└── README.md
```

## Skill Locations

- **Repo**: `~/repos/przydasie/AI/jawor-conf/SKILL.md`
- **OpenCode**: `~/.opencode/skills/jawor-conf/SKILL.md` (symlinked or copied)

## SSH Configuration

Subnet: `10.66.66.0/24`

| Host | IP | Port | User |
|------|-----|------|------|
| Router/Gateway | 10.66.66.1 | 2229 | root |
| Other hosts | 10.66.66.x | 22 | root |

## Common Paths

- Config: `~/.config/`
- Omarchy config: `~/.config/omarchy/`
- Hyprland: `~/.config/hypr/`
- Scripts: `~/scripts/`
- Projects: `~/repos/`

## Usage

Reference this skill when jawor asks to:
- Configure desktop environment settings
- Set up SSH connections to his network
- Clone or work with his GitHub repos
- Set up new development environment
- Find AI-related configs or skills

## Related Skills

- **Omarchy** (system desktop config): `~/.opencode/skills/omarchy/SKILL.md`
- **Omarchy-Custom** (user overrides): `~/.opencode/skills/omarchy-custom/SKILL.md`
- **OpenClawBot** (OpenClaw config): `~/.config/opencode/skills/openclawbot/SKILL.md`
