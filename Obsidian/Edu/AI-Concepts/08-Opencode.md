l
Understanding and extending the Opencode CLI AI agent system.

## What is Opencode?

Opencode is a CLI-based AI assistant for software engineering:

| Feature | Description |
|---------|-------------|
| **CLI-first** | Terminal-based interaction |
| **Model-agnostic** | Works with multiple AI models |
| **Tool-rich** | Extensive tool integration |
| **Extensible** | Skills, agents, custom commands |
| **Local skills** | Custom domain knowledge |

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                    Opencode                         │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────┐    ┌─────────────┐                │
│  │   Skills    │───→│   Agents    │                │
│  │ (Knowledge) │    │ (Behavior)  │                │
│  └─────────────┘    └──────┬──────┘                │
│                            ↓                        │
│                   ┌─────────────┐                  │
│                   │    Tools    │                  │
│                   │ (Actions)   │                  │
│                   └──────┬──────┘                  │
│                          ↓                          │
│                   ┌─────────────┐                  │
│                   │    CLI     │                  │
│                   │ (User I/F) │                  │
│                   └─────────────┘                  │
│                                                     │
└─────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────┐
│ External: AI Models (OpenAI, Anthropic, Minimax)    │
└─────────────────────────────────────────────────────┘
```

## Getting Started

### Installation

```bash
# Via package manager (Omarchy)
omarchy-install-opencode

# Or via pip
pip install opencode
```

### Basic Usage

```bash
# Start interactive session
opencode

# Single query
opencode "Fix the bug in main.py"

# Use specific agent
opencode --agent build "Write a test suite"
```

## Skills

Skills provide domain-specific knowledge:

### Built-in Skills

| Skill | Purpose |
|-------|---------|
| **Omarchy** | Linux desktop/Omarchy configuration |
| **Omarchy-Custom** | User-specific desktop customizations |

### Loading Skills

```bash
# Load a skill
skill <skill_name>

# Example
skill Omarchy
```

### Custom Skills

Skills are Markdown files with special structure:

```
~/.opencode/skills/
└── <skill-name>/
    └── SKILL.md
```

#### Skill Structure

```markdown
---
name: <Skill Name>
description: >
  Brief description of when to use this skill
---

# <Skill Name>

## When This Skill MUST Be Used

- Specific triggers for skill activation

## Key Concepts

[Domain-specific knowledge]

## Commands

[Relevant commands]

## Examples

[Usage examples]
```

### Case Study: Omarchy-Custom Skill

Your custom skill demonstrates effective skill design:

**Location:** `repos/przydasie/AI/omarchy-custom-skill/SKILL.md`

**Structure:**

```markdown
---
name: Omarchy-Custom
description: >
  Extended Omarchy skill with user-specific customizations
  for Hyprland desktop with DisplayLink dock.
---

# Omarchy-Custom Skill

## When This Skill MUST Be Used

- Editing ~/.config/hypr/ files
- Custom keybindings (SUPER+M, SUPER+SHIFT+V)
- Display setup (DisplayLink dock, vertical stack)
- Custom scripts (toggle-dock-mode.sh, etc.)

## Custom Keybindings

| Binding | Action | Command |
|---------|--------|---------|
| SUPER + M | Toggle Dock Mode | ~/.local/bin/toggle-dock-mode.sh |
| SUPER + SHIFT + V | Fix Cursor | ~/.local/bin/fix-cursor-vertical.sh |

## Custom Display Setup

monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
monitor = eDP-1, preferred, 0x1440, 2
env = GDK_SCALE,2

## Custom Scripts

Located in ~/.local/bin/:
- toggle-dock-mode.sh
- fix-cursor-vertical.sh
- toggle-audio-output.sh
- lid-handler-daemon.sh

## Related Documentation

[[Obsidian/Manuals/Hyprland-Configuration/index]]
```

**See:** `repos/przydasie/AI/omarchy-custom-skill/SKILL.md`

## Agents

Agents define behavior patterns:

### Built-in Agents

| Agent | Purpose |
|-------|---------|
| **build** | Code generation, editing, testing |
| **general** | Q&A, explanation, documentation |
| **explore** | Codebase analysis, pattern finding |

### Agent Selection

```bash
# Use build agent for coding tasks
opencode --agent build "Refactor this function"

# Use explore for understanding
opencode --agent explore "Find all API endpoints"

# General for questions
opencode "Explain this concept"
```

### Custom Agent Configuration

Configure agents in `~/.config/opencode/opencode.json`:

```json
{
  "command": {
    "git-push": {
      "description": "Push changes to remote",
      "template": "Run 'git push'...",
      "agent": "build"
    }
  }
}
```

## Custom Commands

Define reusable command templates:

### Command Structure

```json
{
  "command": {
    "<command-name>": {
      "description": "What it does",
      "template": "The template prompt",
      "agent": "Which agent to use"
    }
  }
}
```

### Example: git-push

```json
{
  "command": {
    "git-push": {
      "description": "Push changes to remote repository",
      "template": "Run 'git push' to push your committed changes.\n\nIMPORTANT: Confirm with the user before executing.",
      "agent": "build"
    }
  }
}
```

### Usage

```
opencode --command git-push
```

## Tools

Opencode provides extensive tools:

| Category | Tools |
|----------|-------|
| **File** | read, write, edit, glob |
| **Shell** | bash |
| **Search** | grep, codesearch, websearch |
| **Web** | webfetch |
| **Git** | commit, push, branch |
| **Meta** | skill, todowrite |

**See also:** [[05-Tools]] for detailed tool documentation.

## Configuration

### Main Config

**Location:** `~/.config/opencode/opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  "theme": "system",
  "command": {
    "git-push": { ... }
  }
}
```

### Skills Directory

```
~/.opencode/skills/
├── omarchy/
│   └── SKILL.md
└── omarchy-custom/
    └── SKILL.md → ~/repos/przydasie/AI/omarchy-custom-skill/SKILL.md
```

**Symlink setup:**
```bash
ln -sf ~/repos/przydasie/AI/omarchy-custom-skill/SKILL.md \
       ~/.opencode/skills/omarchy-custom/SKILL.md
```

## Project-Specific: AGENTS.md

Create `AGENTS.md` in project root for custom agent configs:

```markdown
# Project Agents

## Custom Agent: Code-Reviewer

```yaml
agent: build
model: gpt-4
description: Reviews code for bugs and style
instructions:
  - Check for security issues
  - Verify tests exist
  - Ensure documentation
```

## Usage

```bash
opencode --agent code-reviewer
```

## Related

- [[Obsidian/Manuals/Hyprland-Configuration/index|Hyprland Docs]] - Real-world example
- [[../AI-Concepts/index|AI Concepts]] - General AI knowledge
