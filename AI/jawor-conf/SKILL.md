---
name: jawor-conf
description: >
  Recovery plan for jawor's Omarchy/Arch Linux desktop.
  Use to restore desktop configuration after fresh Omarchy install.
  Includes keybindings, PC cooling, SSH, and OpenCode setup.
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

## Quick Recovery

**Date**: 2026-02-20  
**Hardware**: Desktop PC (Xiaomi Mi Monitor 3440x1440@144Hz via DP-2)

Complete these steps after fresh Omarchy install to restore desktop:

### 1. Clone Dotfiles

```bash
# Clone repo
git clone https://github.com/JaworB/przydasie.git ~/repos/przydasie

# Create symlinks for Hyprland config
mkdir -p ~/.config/hypr
rm -f ~/.config/hypr/bindings.conf ~/.config/hypr/input.conf ~/.config/hypr/autostart.conf ~/.config/hypr/looknfeel.conf ~/.config/hypr/hypridle.conf ~/.config/hypr/hyprlock.conf ~/.config/hypr/hyprsunset.conf

ln -s ~/repos/przydasie/dotfiles/hypr/bindings.conf ~/.config/hypr/bindings.conf
ln -s ~/repos/przydasie/dotfiles/hypr/input.conf ~/.config/hypr/input.conf
ln -s ~/repos/przydasie/dotfiles/hypr/autostart.conf ~/.config/hypr/autostart.conf
ln -s ~/repos/przydasie/dotfiles/hypr/looknfeel.conf ~/.config/hypr/looknfeel.conf
ln -s ~/repos/przydasie/dotfiles/hypr/hypridle.conf ~/.config/hypr/hypridle.conf
ln -s ~/repos/przydasie/dotfiles/hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf
ln -s ~/repos/przydasie/dotfiles/hypr/hyprsunset.conf ~/.config/hypr/hyprsunset.conf
```

### 2. Configure Monitor

**File**: `~/.config/hypr/monitors.conf`

```bash
monitor = DP-2, 3440x1440@144.00, 0x0, 1
env = GDK_SCALE,1
```

> **Note**: `monitors.conf` is NOT in dotfiles - it's hardware-specific.

### 3. Install Theme

```bash
omarchy-theme-install https://github.com/OldJobobo/omarchy-miasma-theme
omarchy-theme-set "Miasma"
```

### 4. WireGuard (Optional)

```bash
# Create symlink
mkdir -p ~/.local/bin
ln -sf ~/repos/przydasie/scripts/hyprland/wg-toggle ~/.local/bin/wg-toggle
chmod +x ~/.local/bin/wg-toggle

# Polkit rule (passwordless toggle)
echo 'polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.policykit.exec" && 
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});' | sudo tee /etc/polkit-1/rules.d/50-wireguard.rules

# Add waybar widget (see Waybar Widget Config below)
omarchy-restart-waybar
```

### 5. Restart

```bash
omarchy-restart-hyprctl
```

---

## Keybindings

### Application Launchers

| Binding | Action |
|---------|--------|
| `SUPER + RETURN` | Terminal |
| `SUPER + SHIFT + F` | File Manager |
| `SUPER + SHIFT + B` | Browser |
| `SUPER + SHIFT + ALT + B` | Browser (Private) |
| `SUPER + SHIFT + M` | Spotify |
| `SUPER + SHIFT + A` | Audio Toggle (AirPods ↔ Speakers) |
| `SUPER + SHIFT + V` | Editor |
| `SUPER + SHIFT + D` | Docker TUI |
| `SUPER + SHIFT + O` | Obsidian |
| `SUPER + CTRL + O` | Opencode |

### Web Applications

| Binding | Action |
|---------|--------|
| `SUPER + SHIFT + Y` | YouTube |
| `SUPER + SHIFT + W` | WhatsApp |
| `SUPER + SHIFT + C` | Codecademy |
| `SUPER + SHIFT + G` | GitHub - Przydasie |
| `SUPER + SHIFT + E` | Email |

---

## PC Cooling Configuration

**Hardware**: Desktop PC
- Motherboard: ASUS X870 MAX GAMING WIFI7 W
- CPU: AMD Ryzen 7 7800X3D
- GPU: NVIDIA RTX 4090
- Fans: Case fans connected to CHA_FAN (controlled via motherboard)

### Problem

ASUS X870 doesn't expose fan controller by default in Linux. Drivers `nct6687d`, `asus-ec-sensors` don't work on this board.

### Solution

Use built-in kernel driver `nct6775` (Nuvoton NCT6799).

### Installation

```bash
# 1. Install CoolerControl
yay -S coolercontrold-bin coolercontrol-bin

# 2. Install lm_sensors
sudo pacman -S lm_sensors

# 3. Load nct6775 module
sudo modprobe nct6775

# 4. Add autoload
echo "nct6775" | sudo tee /etc/modules-load.d/nct6775.conf

# 5. Enable and start CoolerControl
sudo systemctl enable --now coolercontrold

# 6. Verify
sensors
# Should show nct6799-isa-xxx with fans and PWM
```

### Configuration

**Config file**: `/etc/coolercontrol/config.toml`

**Device UIDs**:
- nct6799: `00a4da18625f56275c89e2fcd25a83c08c5ad3326452fa7e252fcc8a89c92493`
- CPU: `31afea3c316e94c19b918e2e76e98ca246202c76409c1faccfe3b155269f38a9`
- GPU: `7e51251c32d94c13a4a7fcfc30a4c8afd505f84019f61b924284334f62db9c21`

**Fan assignments** (hwmon nct6799):
- fan2 → CPU
- fan4 → GPU (CHA_FAN4)

**Silent profile (CPU)**:
```toml
[[profiles]]
uid = "cpu_profile"
name = "CPU Profile"
p_type = "Graph"
speed_profile = [[0.0, 25], [45.0, 35], [60.0, 50], [75.0, 70], [85.0, 100]]
function_uid = "cpu_function"
temp_source = { temp_name = "temp1", device_uid = "31afea3c316e94c19b918e2e76e98ca246202c76409c1faccfe3b155269f38a9" }
temp_min = 0.0
temp_max = 100.0

[[functions]]
uid = "cpu_function"
name = "CPU Function"
f_type = "Identity"
duty_minimum = 25
duty_maximum = 100
```

**Silent profile (GPU)**:
```toml
[[profiles]]
uid = "gpu_profile"
name = "GPU Profile"
p_type = "Graph"
speed_profile = [[0.0, 30], [35.0, 35], [50.0, 50], [65.0, 70], [80.0, 100]]
function_uid = "gpu_function"
temp_source = { temp_name = "GPU Temp", device_uid = "7e51251c32d94c13a4a7fcfc30a4c8afd505f84019f61b924284334f62db9c21" }
temp_min = 0.0
temp_max = 100.0

[[functions]]
uid = "gpu_function"
name = "GPU Function"
f_type = "Identity"
duty_minimum = 30
duty_maximum = 100
```

**Assign profiles to fans**:
```toml
[device-settings.00a4da18625f56275c89e2fcd25a83c08c5ad3326452fa7e252fcc8a89c92493]
fan2 = { profile_uid = "cpu_profile" }
fan4 = { profile_uid = "gpu_profile" }
```

### BIOS Requirements

- Disable Smart Fan Mode for fans to be controlled
- Set mode to PWM (not DC)
- Or leave on Auto - nct6775 should take over

### Verification

```bash
# Check RPM
sensors | grep -E "fan[24]"

# Check PWM (should show MANUAL CONTROL)
sensors | grep -E "pwm[24]"

# CoolerControl logs
sudo journalctl -u coolercontrold -f
```

### Notes

- Fan5 may be marked as "Uncontrollable RPM-only"
- Warning "Tctl is missing" in logs doesn't block operation - fans work
- For full control, can use `pwmconfig` instead of CoolerControl

### References

- https://unix.stackexchange.com/questions/790419/asus-motherboard-fan-control-under-linux
- https://www.reddit.com/r/cachyos/comments/1qrnzbp/fix_coolercontrol_so_it_can_see_fans_on_an_asus/
- https://docs.coolercontrol.org/

---

## SSH Configuration

Subnet: `10.66.66.0/24`

| Host | IP | Port | User |
|------|-----|------|------|
| Router/Gateway | 10.66.66.1 | 2229 | root |
| Other hosts | 10.66.66.x | 22 | root |

---

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

---

## OpenCode Configuration

**Config file**: `~/repos/przydasie/AI/jawor-conf/opencode.json`  
**Symlink**: `~/.config/opencode/opencode.json` → `~/repos/przydasie/AI/jawor-conf/opencode.json`

```json
{
  "model": "opencode/minimax-m2.5-free",
  "default_agent": "plan",
  "skills": {
    "paths": [
      "~/.claude/skills/omarchy",
      "~/repos/przydasie/AI/"
    ]
  },
  "theme": "system",
  "autoupdate": true
}
```

**Available models**: `opencode/minimax-m2.5-free`, `opencode/gpt-5-nano`, `opencode/trinity-large-preview-free`

**Skills loaded**:
- `~/.claude/skills/omarchy` - Omarchy desktop config
- `~/repos/przydasie/AI/` - jawor-conf + omarchy-custom-skill

---

## Commands Reference

```bash
# Reload Hyprland config
omarchy-restart-hyprctl

# Change theme
omarchy-theme-set "Miasma"

# List themes
omarchy-theme-list

# Backup configs
~/scripts/backup-omarchy-configs.sh
```

---

## Waybar Widget Config

### WireGuard Widget

Add to `~/.config/waybar/config.jsonc`:

```jsonc
// In modules-right, after "network":
"custom/wireguard",

// Add module config:
"custom/wireguard": {
  "exec": "~/.local/bin/wg-toggle status",
  "on-click": "~/.local/bin/wg-toggle toggle",
  "return-type": "json",
  "format": "{text}",
  "tooltip": true,
  "interval": 5
}
```

**Icons**: `󰒍` (connected) / `󰒎` (disconnected)

---

## Repo Structure

```
przydasie/
├── AI/
│   ├── jawor-conf/              # This skill
│   │   ├── SKILL.md
│   │   └── opencode.json       # OpenCode config
│   ├── omarchy-custom-skill/   # Custom omarchy overrides
│   └── openclawbot/            # OpenClaw bot config
├── dotfiles/
│   └── hypr/                   # Hyprland configs
│       ├── bindings.conf
│       ├── input.conf
│       ├── autostart.conf
│       ├── looknfeel.conf
│       ├── hypridle.conf
│       ├── hyprlock.conf
│       └── hyprsunset.conf
├── Obsidian/
├── Obsidian_PL/
├── docker/
├── edu/
├── scripts/
├── .ansible/
└── .vscode/
```

**Files NOT in dotfiles (hardware-specific):**
- `monitors.conf` - monitor setup per PC
- `envs.conf` - environment variables
- `hyprland.conf` - main config (managed by omarchy)
- `xdph.conf` - XWayland config

---

## Related Skills

- **Omarchy** (system desktop config): `~/.claude/skills/omarchy/SKILL.md`
- **Omarchy-Custom** (user overrides): `~/repos/przydasie/AI/omarchy-custom-skill/SKILL.md`

---

## Usage

Reference this skill when jawor asks to:
- Restore desktop configuration after Omarchy install
- Configure desktop environment settings
- Set up SSH connections to his network
- Clone or work with his GitHub repos
- Find AI-related configs or skills
