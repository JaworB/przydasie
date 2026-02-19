---
name: Omarchy-Custom
description: >
  Extended Omarchy skill with user-specific customizations for Linux desktop configuration.
  REQUIRED for ANY changes to Linux desktop, window manager, or system config.
  Use when editing ~/.config/hypr/, ~/.config/waybar/, ~/.config/walker/,
  ~/.config/alacritty/, ~/.config/kitty/, ~/.config/ghostty/, ~/.config/mako/,
  or ~/.config/omarchy/. Triggers: Hyprland, window rules, animations, keybindings,
  monitors, gaps, borders, blur, opacity, waybar, walker, terminal config, themes,
  wallpaper, night light, idle, lock screen, screenshots, layer rules, workspace
  settings, display config, or any omarchy-* commands.
---

# Omarchy-Custom Skill

Extended Omarchy skill with user-specific customizations for a Hyprland desktop with DisplayLink dock.

## When This Skill MUST Be Used

**ALWAYS invoke this skill when the user's request involves ANY of these:**

- Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
- Editing ANY file in `~/.config/waybar/`, `~/.config/walker/`, `~/.config/mako/`
- Editing terminal configs (alacritty, kitty, ghostty)
- Editing ANY file in `~/.config/omarchy/`
- Window behavior, animations, opacity, blur, gaps, borders
- Layer rules, workspace settings, display/monitor configuration
- Themes, wallpapers, fonts, appearance changes
- Any `omarchy-*` command
- Screenshots, screen recording, night light, idle behavior, lock screen
- Custom scripts: toggle-dock-mode.sh, fix-cursor-vertical.sh, toggle-audio-output.sh, lid-handler-daemon.sh

**If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**

## Custom Keybindings

**Location:** `~/.config/hypr/bindings.conf`

### Application Launchers

| Binding | Action | Command |
|---------|--------|---------|
| `SUPER + RETURN` | Terminal | `uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"` |
| `SUPER + SHIFT + F` | File Manager | `nautilus --new-window` |
| `SUPER + SHIFT + B` | Browser | `omarchy-launch-browser` |
| `SUPER + SHIFT + ALT + B` | Browser (Private) | `omarchy-launch-browser --private` |
| `SUPER + SHIFT + M` | Spotify | `omarchy-launch-or-focus spotify` |
| `SUPER + SHIFT + A` | Toggle Audio Output | `~/.local/bin/toggle-audio-output.sh` |
| `SUPER + SHIFT + V` | Editor | `omarchy-launch-editor` |
| `SUPER + SHIFT + D` | Docker TUI | `omarchy-launch-tui lazydocker` |
| `SUPER + SHIFT + O` | Obsidian | `omarchy-launch-or-focus ^obsidian$ "uwsm-app -- obsidian -disable-gpu --enable-wayland-ime"` |
| `SUPER + CTRL + O` | Opencode | `omarchy-launch-tui opencode` |

### Web Applications

| Binding | Action | URL |
|---------|--------|-----|
| `SUPER + SHIFT + Y` | YouTube | `https://youtube.com/` |
| `SUPER + SHIFT + W` | WhatsApp | `https://web.whatsapp.com/` |
| `SUPER + SHIFT + CTRL + G` | Google Messages | `https://messages.google.com/web/conversations` |
| `SUPER + SHIFT + P` | Google Photos | `https://photos.google.com/` |
| `SUPER + SHIFT + X` | X (Twitter) | `https://x.com/` |
| `SUPER + SHIFT + ALT + X` | X Post | `https://x.com/compose/post` |
| `SUPER + C` | Codecademy | `https://codecademy.com/learn` |
| `SUPER + G` | GitHub - Przydasie | `https://github.com/JaworB/przydasie` |
| `SUPER + E` | Email | `https://gmail.com` |
| `SUPER + SHIFT + D` | Discord | `omarchy-launch discord` |

### Display Controls

| Binding | Action | Script |
|---------|--------|--------|
| `SUPER + M` | Toggle Dock Mode | `~/.local/bin/toggle-dock-mode.sh` |
| `SUPER + SHIFT + V` | Fix Vertical Cursor | `~/.local/bin/fix-cursor-vertical.sh` |

**Note:** Use `##` in URLs to escape the `#` character (hyprland treats `#` as a comment).

## Custom Display Setup

**Location:** `~/.config/hypr/monitors.conf`

### Vertical Stack Layout

```
+---------------------+
|     DVI-I-1         |
|   (3440x1440)       |
|   @ 50Hz            |
|   scale 1x          |
+---------------------+
       ^
       | 0x1440
       v
+---------------------+
|      eDP-1          |
|    (laptop)         |
|   preferred         |
|     2x scale        |
+---------------------+
```

### Configuration

```bash
# DisplayLink Dock Configuration (Vertical Stack)
monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
monitor = eDP-1, preferred, 0x1440, 2

# HiDPI scaling
env = GDK_SCALE,2
```

### DisplayLink Dock Modes

**Normal Mode (Lid Open or On Battery):**
```
DVI-I-1: 3440x1440@50.00, 0x0, 1
eDP-1: preferred, 0x1440, 2
```

**Dock Mode (Lid Closed + AC):**
```
eDP-1: disabled
DVI-I-1: 3440x1440@50.00, 0x0, 1
```

## Custom Scripts

### Overview

Custom automation scripts located in `~/.local/bin/`:

| Script | Purpose | Trigger |
|--------|---------|---------|
| `toggle-dock-mode.sh` | Toggle between dock mode and dual display | `SUPER + M` |
| `fix-cursor-vertical.sh` | Fix cursor issues with vertical monitor stack | `SUPER + SHIFT + V` |
| `toggle-audio-output.sh` | Toggle between AirPods and speakers | `SUPER + SHIFT + A` |
| `lid-handler-daemon.sh` | Auto-switch display modes based on lid/AC state | Auto-start on login |

### Documentation

All scripts are documented in Obsidian:

- [[Obsidian/Manuals/Hyprland-Configuration/09-Custom-Scripts/02-toggle-dock-mode|Toggle Dock Mode Script]]
- [[Obsidian/Manuals/Hyprland-Configuration/09-Custom-Scripts/03-fix-cursor-vertical|Fix Cursor Vertical Script]]
- [[Obsidian/Manuals/Hyprland-Configuration/09-Custom-Scripts/04-toggle-audio-output|Toggle Audio Output Script]]
- [[Obsidian/Manuals/Hyprland-Configuration/09-Custom-Scripts/01-lid-handler-daemon|Lid Handler Daemon]]

### Application Launchers

**Obsidian:**
```bash
obsidian -disable-gpu --enable-wayland-ime
```

**Terminal with preserved CWD:**
```bash
uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"
```

## Critical Safety Rules

**NEVER modify anything in `~/.local/share/omarchy/`** - but READING is safe and encouraged.

This directory contains Omarchy's source files managed by git. Any changes will be:
- Lost on next `omarchy-update`
- Cause conflicts with upstream
- Break the system's update mechanism

```
~/.local/share/omarchy/     # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                    # Source scripts (symlinked to PATH)
├── config/                 # Default config templates
├── themes/                 # Stock themes
├── default/                # System defaults
├── migrations/             # Update migrations
└── install/                # Installation scripts
```

**Reading `~/.local/share/omarchy/` is SAFE and useful** - do it freely to:
- Understand how omarchy commands work: `cat $(which omarchy-theme-set)`
- See default configs before customizing: `cat ~/.local/share/omarchy/config/waybar/config.jsonc`
- Check stock theme files to copy for customization
- Reference default hyprland settings: `cat ~/.local/share/omarchy/default/hypr/*`

**Always use these safe locations instead:**
- `~/.config/` - User configuration (safe to edit)
- `~/.config/omarchy/themes/<custom-name>/` - Custom themes (must be real directories)
- `~/.config/omarchy/hooks/` - Custom automation hooks
- `~/.local/bin/` - Custom scripts

## System Architecture

Omarchy is built on:

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch Linux** | Base OS | `/etc/`, `~/.config/` |
| **Hyprland** | Wayland compositor/WM | `~/.config/hypr/` |
| **Waybar** | Status bar | `~/.config/waybar/` |
| **Walker** | App launcher | `~/.config/walker/` |
| **Alacritty/Kitty/Ghostty** | Terminals | `~/.config/<terminal>/` |
| **Mako** | Notifications | `~/.config/mako/` |
| **SwayOSD** | On-screen display | `~/.config/swayosd/` |

## Command Discovery

Omarchy provides ~145 commands following `omarchy-<category>-<action>` pattern.

```bash
# List all omarchy commands
compgen -c | grep -E '^omarchy-' | sort -u

# Find commands by category
compgen -c | grep -E '^omarchy-theme'
compgen -c | grep -E '^omarchy-restart'

# Read a command's source to understand it
cat $(which omarchy-theme-set)
```

### Command Categories

| Prefix | Purpose | Example |
|--------|---------|---------|
| `omarchy-refresh-*` | Reset config to defaults (backs up first) | `omarchy-refresh-waybar` |
| `omarchy-restart-*` | Restart a service/app | `omarchy-restart-waybar` |
| `omarchy-toggle-*` | Toggle feature on/off | `omarchy-toggle-nightlight` |
| `omarchy-theme-*` | Theme management | `omarchy-theme-set <name>` |
| `omarchy-install-*` | Install optional software | `omarchy-install-docker-dbs` |
| `omarchy-launch-*` | Launch apps | `omarchy-launch-browser` |
| `omarchy-cmd-*` | System commands | `omarchy-cmd-screenshot` |
| `omarchy-pkg-*` | Package management | `omarchy-pkg-install <pkg>` |
| `omarchy-setup-*` | Initial setup tasks | `omarchy-setup-fingerprint` |
| `omarchy-update-*` | System updates | `omarchy-update` |

## Configuration Locations

### Hyprland (Window Manager)

```
~/.config/hypr/
├── hyprland.conf      # Main config (sources others)
├── bindings.conf      # Custom keybindings (USER OVERRIDES)
├── monitors.conf      # Display configuration (USER OVERRIDES)
├── input.conf         # Keyboard/mouse settings
├── looknfeel.conf     # Appearance (gaps, borders, animations)
├── envs.conf          # Environment variables
├── autostart.conf     # Startup applications
├── hypridle.conf      # Idle behavior (screen off, lock, suspend)
├── hyprlock.conf      # Lock screen appearance
└── hyprsunset.conf    # Night light / blue light filter
```

**Key behaviors:**
- Hyprland auto-reloads on config save (no restart needed for most changes)
- Use `hyprctl reload` to force reload
- Use `omarchy-refresh-hyprland` to reset to defaults

### Waybar (Status Bar)

```
~/.config/waybar/
├── config.jsonc       # Bar layout and modules (JSONC format)
└── style.css          # Styling
```

**Waybar does NOT auto-reload.** You MUST run `omarchy-restart-waybar` after any config changes.

**Commands:** `omarchy-restart-waybar`, `omarchy-refresh-waybar`, `omarchy-toggle-waybar`

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/kitty/kitty.conf
~/.config/ghostty/config
```

**Command:** `omarchy-restart-terminal`

### Other Configs

| App | Location |
|-----|----------|
| btop | `~/.config/btop/btop.conf` |
| fastfetch | `~/.config/fastfetch/config.jsonc` |
| lazygit | `~/.config/lazygit/config.yml` |
| starship | `~/.config/starship.toml` |
| git | `~/.config/git/config` |
| walker | `~/.config/walker/config.toml` |

## Safe Customization Patterns

### Pattern 1: Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/hypr/bindings.conf

# 2. Backup before changes
cp ~/.config/hypr/bindings.conf ~/.config/hypr/bindings.conf.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Hyprland: auto-reloads on save (no restart needed)
# - Waybar: MUST restart with omarchy-restart-waybar
# - Walker: MUST restart with omarchy-restart-walker
# - Terminals: MUST restart with omarchy-restart-terminal
```

### Pattern 2: Make a new theme

1. Create a directory under ~/.config/omarchy/themes.
2. See how an existing theme is done via ~/.local/share/omarchy/themes/catppuccin.
3. Download a matching background (or several) from the internet and put them in ~/.config/omarchy/themes/[name-of-new-theme]
4. When done with the theme, run omarchy-theme-set "Name of new theme"

### Pattern 3: Use Hooks for Automation

Create scripts in `~/.config/omarchy/hooks/` to run automatically on events:

```bash
# Available hooks (see samples in ~/.config/omarchy/hooks/):
~/.config/omarchy/hooks/
├── theme-set        # Runs after theme change (receives theme name as $1)
├── font-set         # Runs after font change
└── post-update      # Runs after omarchy-update
```

Example hook (`~/.config/omarchy/hooks/theme-set`):
```bash
#!/bin/bash
THEME_NAME=$1
echo "Theme changed to: $THEME_NAME"
# Add custom actions here
```

### Pattern 4: Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
omarchy-refresh-waybar
omarchy-refresh-hyprland

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from ~/.local/share/omarchy/config/
# 3. Restarts the component
```

## Common Tasks

### Custom Display Tasks

**Toggle dock mode:**
```bash
~/.local/bin/toggle-dock-mode.sh
# Or: SUPER + M
```

**Fix cursor after monitor changes:**
```bash
~/.local/bin/fix-cursor-vertical.sh
# Or: SUPER + SHIFT + V
```

**Toggle audio output (AirPods ↔ Speakers):**
```bash
~/.local/bin/toggle-audio-output.sh
# Or: SUPER + SHIFT + A
```

**Check monitor status:**
```bash
hyprctl monitors
```

### Themes

```bash
omarchy-theme-list              # Show available themes
omarchy-theme-current           # Current theme
omarchy-theme-set <name>        # Apply theme (use "Tokyo Night" not "tokyo-night")
omarchy-theme-next              # Cycle to next theme
omarchy-theme-bg-next           # Cycle wallpaper
omarchy-theme-install <url>     # Install from git repo
```

### Keybindings

Edit `~/.config/hypr/bindings.conf`. Format:
```
bind = SUPER, Return, exec, xdg-terminal-exec
bind = SUPER, Q, killactive
bind = SUPER SHIFT, E, exit
```

View current bindings: `omarchy-menu-keybindings --print`

**IMPORTANT: When re-binding an existing key:**

1. First check existing bindings: `omarchy-menu-keybindings --print`
2. If the key is already bound, you MUST add an `unbind` directive BEFORE your new `bind`
3. Inform the user what the key was previously bound to

Example - rebinding SUPER+F (which is bound to fullscreen by default):
```
# Unbind existing SUPER+F (was: fullscreen)
unbind = SUPER, F
# New binding for file manager
bind = SUPER, F, exec, nautilus
```

Always tell the user: "Note: SUPER+F was previously bound to fullscreen. I've added an unbind directive to override it."

### Display/Monitors

Edit `~/.config/hypr/monitors.conf`. Format:
```
monitor = eDP-1, 1920x1080@60, 0x0, 1
monitor = HDMI-A-1, 2560x1440@144, 1920x0, 1
```

List monitors: `hyprctl monitors`

**Custom user's setup (Desktop PC):**
```
monitor = DP-2, 3440x1440@144.00, 0x0, 1
```

### Keyboard (Polish)

Edit `~/.config/hypr/input.conf`. Format:
```
input {
  kb_layout = pl
  kb_options = compose:caps
  ...
}
```

**Correct format (full config with touchpad):**
```
input {
  kb_layout = pl
  kb_options = compose:caps

  repeat_rate = 40
  repeat_delay = 600
  numlock_by_default = true

  touchpad {
    scroll_factor = 0.4
  }
}
```

**Common issues:**
- Fcitx5 can override keyboard layout - check `~/.config/fcitx5/profile`
- If keyboard shows "English (US)" in `hyprctl devices`, ensure fcitx5 is configured with `pl` layout

### Window Rules

**CRITICAL: Hyprland window rules syntax changes frequently between versions.**

Before writing ANY window rules, you MUST fetch the current documentation from the official Hyprland wiki:
- https://github.com/hyprwm/hyprland-wiki/blob/main/content/Configuring/Window-Rules.md

DO NOT rely on cached or memorized window rule syntax. The format has changed multiple times and using outdated syntax will cause errors or unexpected behavior.

Window rules go in `~/.config/hypr/hyprland.conf` or a sourced file. Always verify the current syntax from the wiki first.

### Fonts

```bash
omarchy-font-list               # Available fonts
omarchy-font-current            # Current font
omarchy-font-set <name>         # Change font
```

### System

```bash
omarchy-update                  # Full system update
omarchy-version                 # Show Omarchy version
omarchy-debug --no-sudo --print # Debug info (ALWAYS use these flags)
omarchy-lock-screen             # Lock screen
omarchy-cmd-shutdown            # Shutdown
omarchy-cmd-reboot              # Reboot
```

**IMPORTANT:** Always run `omarchy-debug` with `--no-sudo --print` flags to avoid interactive sudo prompts that will hang the terminal.

## Troubleshooting

### SDDM Autologin Not Working

If Hyprland doesn't start automatically after reboot and you see the SDDM greeter:

**Check if user is in video group:**
```bash
id jawor
```

If `video` group is missing, add user to it:
```bash
sudo usermod -aG video jawor
```

Then reboot. This is required for Xorg (used by SDDM) to access the GPU.

**Check SDDM logs:**
```bash
journalctl -b -u sddm --no-pager
```

Look for "Xorg dumped core" which indicates a crash preventing autologin.

```bash
# Get debug information (ALWAYS use these flags to avoid interactive prompts)
omarchy-debug --no-sudo --print

# Upload logs for support
omarchy-upload-log

# Reset specific config to defaults
omarchy-refresh-<app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# eg. omarchy-refresh-config hypr/hyprlock.conf will refresh ~/.config/hypr/hyprlock.conf
omarchy-refresh-config <config-file>

# Full reinstall of configs (nuclear option)
omarchy-reinstall
```

## Decision Framework

When user requests system changes:

1. **Is it a stock omarchy command?** Use it directly
2. **Is it a config edit?** Edit in `~/.config/`, never `~/.local/share/omarchy/`
3. **Is it a theme customization?** Create a NEW custom theme directory
4. **Is it automation?** Use hooks in `~/.config/omarchy/hooks/` or custom scripts in `~/.local/bin/`
5. **Is it a package install?** Use `yay`
6. **Unsure if command exists?** Search with `compgen -c | grep omarchy`

**Custom-specific decisions:**
- Dock/cursor issues? Use toggle-dock-mode.sh or fix-cursor-vertical.sh
- Audio output toggle? Use toggle-audio-output.sh
- Lid-based automation? Check lid-handler-daemon.sh status

## Development (AI Agents)

When contributing to Omarchy itself (e.g., fixing bugs, adding features), migrations are used to apply changes to existing installations.

### Creating Migrations

```bash
# ALWAYS use --no-edit flag or you will get stuck
omarchy-dev-add-migration --no-edit
```

This creates a new migration file and outputs its path without opening an editor. The migration filename is based on the git commit timestamp.

**Migration files** are shell scripts in `~/.local/share/omarchy/migrations/` that run once per system during `omarchy-update`. Use them for:
- Updating user configs with new defaults
- Installing new dependencies
- Running one-time setup tasks

## Example Requests

### Custom Setup Requests

- "Toggle dock mode" -> `~/.local/bin/toggle-dock-mode.sh` or SUPER+M
- "Fix cursor position" -> `~/.local/bin/fix-cursor-vertical.sh` or SUPER+SHIFT+V
- "Switch audio to AirPods" -> `~/.local/bin/toggle-audio-output.sh` or SUPER+SHIFT+A
- "Open Obsidian" -> `uwsm-app -- obsidian -disable-gpu --enable-wayland-ime`
- "Check display configuration" -> `hyprctl monitors`

### Standard Omarchy Requests

- "Change my theme to catppuccin" -> `omarchy-theme-set catppuccin`
- "Add a keybinding for Super+E to open file manager" -> Check existing bindings first, add `unbind` if needed, then add `bind` in `~/.config/hypr/bindings.conf`
- "Configure my external monitor" -> Edit `~/.config/hypr/monitors.conf`
- "Make the window gaps smaller" -> Edit `~/.config/hypr/looknfeel.conf`
- "Set up night light to turn on at sunset" -> `omarchy-toggle-nightlight` or edit `~/.config/hypr/hyprsunset.conf`
- "Customize the catppuccin theme colors" -> Create `~/.config/omarchy/themes/catppuccin-custom/` by copying from stock, then edit
- "Run a script every time I change themes" -> Create `~/.config/omarchy/hooks/theme-set`
- "Reset waybar to defaults" -> `omarchy-refresh-waybar`

## Reinstallation Quick Reference

After Omarchy reinstall, copy these files to restore custom setup:

```bash
# Restore keyboard config (Polish layout)
cp dotfiles/hypr/input.conf ~/.config/hypr/input.conf

# Restore keybindings
cp dotfiles/hypr/bindings.conf ~/.config/hypr/bindings.conf

# Restore display config (Desktop PC)
cp dotfiles/hypr/monitors.conf ~/.config/hypr/monitors.conf

# Restore autostart (keyboard fix)
cp dotfiles/hypr/autostart.conf ~/.config/hypr/autostart.conf

# Restore custom scripts
cp dotfiles/local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*.sh

# Install Miasma theme
omarchy-theme-install https://github.com/OldJobobo/omarchy-miasma-theme
omarchy-theme-set "Miasma"

# Restart Hyprland to apply changes
omarchy-restart-hyprctl
```

**Documentation reference:** See [[Obsidian/Manuals/Hyprland-Configuration/index|Hyprland Configuration Index]] for full details.

---

**Base directory for this skill:** file:///home/jawor/repos/przydasie/AI/omarchy-custom-skill

**Related documentation:**
- [[Obsidian/Manuals/Hyprland-Configuration/index|Hyprland Configuration]]
- [[Obsidian/Manuals/Hyprland-Configuration/01-Omarchy-Defaults|Omarchy Defaults]]
- [[Obsidian/Manuals/Hyprland-Configuration/02-Custom-Keybindings|Custom Keybindings]]
- [[Obsidian/Manuals/Hyprland-Configuration/05-Display-Setup|Display Setup]]
