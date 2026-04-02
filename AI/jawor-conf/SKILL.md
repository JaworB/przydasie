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

---

## 1. Repository Structure

```
przydasie/
├── AI/
│   └── jawor-conf/              # This skill
├── dotfiles/
│   ├── desktop/                 # PC configuration
│   │   ├── hypr/.config/hypr/
│   │   ├── waybar/.config/waybar/
│   │   ├── scripts/bin/         # wg-toggle, gpu-power-toggle
│   │   ├── coolercontrol/
│   │   ├── opencode/.config/opencode/
│   │   └── uwsm/.config/uwsm/
│   ├── laptop/                  # Laptop configuration
│   │   ├── hypr/.config/hypr/
│   │   ├── scripts/bin/         # laptop scripts + wg-toggle
│   │   ├── opencode/
│   │   └── uwsm/.config/uwsm/
│   ├── system/                  # rsyslog configs
│   ├── stow-desktop.sh          # Stow script for PC
│   └── stow-laptop.sh           # Stow script for laptop
├── Obsidian/
├── docker/
├── edu/
├── scripts/
└── .vscode/
```

### Hardware-specific files:
- **monitors.conf** - now in dotfiles/desktop/ or dotfiles/laptop/ (already configured for each machine)
- **envs.conf** - not in dotfiles
- **xdph.conf** - not in dotfiles

---

## 2. System Info

| Property | Value |
|----------|-------|
| OS | Arch Linux (Omarchy) |
| Window Manager | Hyprland |
| Home Directory | /home/jawor |
| Default Editor | code (VS Code) |

---

## 3. System Custom Config

### 3.1 Base Setup (Both)

**Packages:**
```bash
# Core packages
sudo pacman -S --noconfirm stow

# Optional: Discord (for autostart)
yay -S --noconfirm discord
```

---

### 3.2 Theme (Both)

**Location**: System theme

**Setup:**
```bash
omarchy-theme-install https://github.com/OldJobobo/omarchy-miasma-theme
omarchy-theme-set "Miasma"
```

---

### 3.3 dotfiles (Hyprland)

**Location**: `~/repos/przydasie/dotfiles/{desktop|laptop}/`

**Setup:**

**PC:**
```bash
cd ~/repos/przydasie/dotfiles
./stow-desktop.sh
```

**Laptop:**
```bash
cd ~/repos/przydasie/dotfiles
./stow-laptop.sh
```

**Manual (without script):**
```bash
# PC
cd ~/repos/przydasie/dotfiles/desktop
stow -t ~ hypr uwsm waybar opencode coolercontrol scripts

# Laptop
cd ~/repos/przydasie/dotfiles/laptop
stow -t ~ hypr uwsm opencode scripts
```

**After stow:**
```bash
hyprctl reload
```

**Note**: Monitors are already pre-configured in dotfiles for each machine. No manual edits needed.

---

### 3.4 DisplayLink Driver (Laptop only)

**Hardware**: Lenovo ThinkPad Hybrid USB-C with USB-A Dock, Xiaomi Mi Monitor 3440x1440@50Hz

**Setup:**
```bash
# Install dependencies
sudo pacman -S --noconfirm dkms linux-headers

# Install DisplayLink driver
yay -S --noconfirm evdi-dkms displaylink

# Enable service
sudo systemctl enable --now displaylink.service

# Verify
systemctl status displaylink.service
hyprctl monitors
```

**Troubleshooting**:
```bash
# Check monitors
hyprctl monitors

# Restart service
sudo systemctl restart displaylink.service

# Check EVID
ls /dev/dri/card*
```

---

### 3.5 Monitor config

**Location**: 
- PC: `~/repos/przydasie/dotfiles/desktop/hypr/.config/hypr/monitors.conf`
- Laptop: `~/repos/przydasie/dotfiles/laptop/hypr/.config/hypr/monitors.conf`

**Note**: Monitors are pre-configured in dotfiles for each machine. After stow, just reload Hyprland:
```bash
hyprctl reload
```

#### PC (Desktop)
```
monitor = DP-2, 3440x1440@144.00, 0x0, 1
env = GDK_SCALE,1
```

#### Laptop (with DisplayLink Dock)

**Normal Mode (Lid Open / Dual Display):**
```
monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
monitor = eDP-1, preferred, 0x1440, 2
env = GDK_SCALE,2
```

**Dock Mode (Lid Closed):**
```
monitor = eDP-1, disabled
monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
env = GDK_SCALE,1
```

---

### 3.6 OpenCode (Both)

**Location**: 
- PC: `~/repos/przydasie/dotfiles/desktop/opencode/.config/opencode/opencode.json`
- Laptop: `~/repos/przydasie/dotfiles/laptop/opencode/opencode.json`

**Setup**: Automatically stowed by `stow-desktop.sh` or `stow-laptop.sh`. No manual setup needed.

**Available models**: `opencode/minimax-m2.5-free`, `opencode/gpt-5-nano`, `opencode/trinity-large-preview-free`

---

### 3.7 WireGuard (Both)

**Location**: 
- PC: `~/repos/przydasie/dotfiles/desktop/scripts/bin/wg-toggle`
- Laptop: `~/repos/przydasie/dotfiles/laptop/scripts/bin/wg-toggle`

**Setup**: Automatically stowed by `stow-desktop.sh` or `stow-laptop.sh`.

**Polkit rule** (needed for toggle):
```bash
echo 'polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.policykit.exec" && 
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});' | sudo tee /etc/polkit-1/rules.d/50-wireguard.rules
```

---

### 3.8 GPU Power (PC only)

**Widget**: Waybar GPU Power toggle (undervolt/normal TDP)

**Script**: `~/.local/bin/gpu-power-toggle`

**Function**:
- Toggle TDP between 300W (undervolt) and 450W (normal)
- Displays icon in waybar: 󰡧 (undervolt) / 󰡨 (normal)
- Click on widget to toggle

**Setup**: Automatically stowed by `stow-desktop.sh` (desktop package includes waybar with GPU Power widget)

---

### 3.9 Custom Scripts (Laptop)

**Location**: `~/repos/przydasie/dotfiles/laptop/scripts/bin/`

**Setup**: Automatically stowed by `stow-laptop.sh`. All scripts are symlinked to `~/.local/bin/`.

**Scripts:**
| Script | Purpose | Keybinding |
|--------|---------|------------|
| `toggle-dock-mode.sh` | Toggle dock mode (dual display ↔ external only) | `SUPER + M` |
| `fix-cursor-vertical.sh` | Fix cursor with vertical monitor stack | `SUPER + SHIFT + V` |
| `toggle-audio-output.sh` | Toggle AirPods ↔ Speakers | `SUPER + SHIFT + A` |
| `lid-handler-daemon.sh` | Auto-switch display on lid/AC state | Auto-start via autostart.conf |
| `wg-toggle` | WireGuard toggle | Auto-start |

**Note**: All keybindings are pre-configured in `dotfiles/laptop/hypr/.config/hypr/bindings.conf`. Lid handler starts automatically from autostart.conf - no manual start needed.

---

## 4. PC Cooling (optional, PC only)

**Location**: `~/repos/przydasie/dotfiles/desktop/coolercontrol/config.toml`

**Hardware**: ASUS X870 MAX GAMING WIFI7 W, AMD Ryzen 7 7800X3D, NVIDIA RTX 4090

**Hardware**: ASUS X870 MAX GAMING WIFI7 W, AMD Ryzen 7 7800X3D, NVIDIA RTX 4090

**Setup:**
```bash
# Install CoolerControl
yay -S coolercontrold-bin coolercontrol-bin

# Load kernel module
sudo modprobe nct6775
echo "nct6775" | sudo tee /etc/modules-load.d/nct6775.conf

# Enable service
sudo systemctl enable --now coolercontrold

# Copy config
sudo cp ~/repos/przydasie/dotfiles/desktop/coolercontrol/config.toml /etc/coolercontrol/config.toml
sudo systemctl restart coolercontrold

# Verify
sensors | grep -E "fan[24]"
sensors | grep -E "pwm[24]"
```

**BIOS Requirements**:
- Disable Smart Fan Mode
- Set mode to PWM (not DC)

---

### 3.8 Remote Logging (Arch → Rocky)

**Konfiguracja**: `~/repos/przydasie/dotfiles/system/rsyslog/`

Arch (klient) wysyła logi do Rocky (serwer) przez UDP.

| Parametr | Wartość |
|----------|---------|
| Serwer | 10.66.66.1:514 UDP |
| Protokół | UDP |
| Retention lokalne | 4 dni (daily, rotate 4) |
| Retention zdalne | 180 tygodni (weekly, rotate 180) |

#### Arch (klient) - syslog-ng

```bash
# Instalacja
pacman -S syslog-ng

# Konfiguracja (z dotfiles)
cp ~/repos/przydasie/dotfiles/system/rsyslog/arch/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
cp ~/repos/przydasie/dotfiles/system/rsyslog/arch/logrotate-local /etc/logrotate.d/local-logs

# Uruchomienie
systemctl enable --now syslog-ng@default
```

#### Rocky (serwer) - rsyslog

```bash
# Instalacja
dnf install rsyslog

# Konfiguracja (z dotfiles)
cp ~/repos/przydasie/dotfiles/system/rsyslog/rocky/rsyslog.conf /etc/rsyslog.conf
cp ~/repos/przydasie/dotfiles/system/rsyslog/rocky/remote.conf /etc/rsyslog.d/
cp ~/repos/przydasie/dotfiles/system/rsyslog/rocky/remote-split.conf /etc/rsyslog.d/
cp ~/repos/przydasie/dotfiles/system/rsyslog/rocky/remote-security.conf /etc/rsyslog.d/
cp ~/repos/przydasie/dotfiles/system/rsyslog/rocky/logrotate-remote /etc/logrotate.d/

# Firewall - dopuszć sieć lokalną
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="10.66.66.0/24" port port="514" protocol="udp" accept'
firewall-cmd --reload

# Uruchomienie
systemctl enable --now rsyslog
```

#### Struktura logów

| Lokalizacja | Zawartość |
|-------------|-----------|
| Rocky /var/log/{secure,messages,cron} | Lokalne logi (jawor.vpn) |
| Rocky /var/log/remote/{HOSTNAME}/ | Logi zdalne per host |

#### Debian (shire) - rsyslog

```bash
# Instalacja (jeśli nie ma)
apt install rsyslog

# Konfiguracja (z dotfiles)
cp ~/repos/przydasie/dotfiles/system/rsyslog/debian/client.conf /etc/rsyslog.d/
cp ~/repos/przydasie/dotfiles/system/rsyslog/debian/logrotate-local /etc/logrotate.d/

# Uruchomienie
systemctl restart rsyslog
```

---

## Related Skills

- **Omarchy** (system desktop config): `~/.claude/skills/omarchy/SKILL.md`

---

## Usage

Reference this skill when jawor asks to:
- Restore desktop configuration after Omarchy install
- Configure desktop environment settings
- Clone or work with his GitHub repos
- Find AI-related configs or skills
