---
created: 2026-02-08
tags: [hardware, dock, displaylink, multi-monitor]
---

# DisplayLink Dock - Second Monitor Setup

## Hardware
- **Dock**: Lenovo ThinkPad Hybrid USB-C with USB-A Dock
- **Connection**: USB-C to laptop, HDMI/DisplayPort to monitor
- **Monitor**: Xiaomi Mi Monitor (3440x1440@50Hz)

## Problem
DisplayLink docks use USB for video transmission, not native DisplayPort. This requires a proprietary driver.

## Solution

### 1. Install DisplayLink Driver

```bash
# Install dependencies
sudo pacman -S dkms linux-headers

# Install from AUR
yay -S evdi-dkms displaylink
```

### 2. Enable Service

```bash
sudo systemctl enable displaylink.service
sudo systemctl start displaylink.service
```

### 3. Verify Installation

```bash
systemctl status displaylink.service
hyprctl monitors
```

## Monitor Configuration

### Monitor Layout (Vertical Stack)
```
+------------------------+
|    DVI-I-1 (Top)       | 3440x1440@50Hz at 0x0
+------------------------+
|                        |
|      eDP-1 (Bottom)    | 3840x2160@60Hz at 0x1440, scale 2
+------------------------+
```

| Setting | Value |
|---------|-------|
| DVI-I-1 Resolution | 3440x1440 |
| DVI-I-1 Refresh Rate | 50Hz |
| DVI-I-1 Position | 0x0 (top) |
| eDP-1 Position | 0x1440 (below DVI-I-1) |
| eDP-1 Scale | 2 |

### Setting Monitor Position

```bash
# Configure monitors (defined in ~/.config/hypr/monitors.conf)
monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
monitor = eDP-1, preferred, 0x1440, 2
```

Note: DisplayLink driver limits refresh rate to 50Hz maximum.

### Side-by-Side (Alternative)

Side-by-side layout is available but less commonly used:
```
+------------------------+------------------------+
|    DVI-I-1 (Left)      |     eDP-1 (Right)      |
|  3440x1440@50Hz at 0x0 | 3840x2160@60Hz at 3440x0
+------------------------+------------------------+
```

To enable side-by-side:
```bash
monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
monitor = eDP-1, preferred, 3440x0, 2
```

## Commands

| Command | Description |
|---------|-------------|
| `hyprctl monitors` | List all connected monitors |
| `hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"` | Set DVI-I-1 position and refresh rate |

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Monitor not detected | Check DisplayLink service: `systemctl status displaylink.service` |
| Wrong position | Apply: `hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"` |
| Black screen | Restart service: `sudo systemctl restart displaylink.service` |
| Low resolution | Verify EDID: `cat /sys/class/drm/card0-DVI-I-1/edid` |

## Related
- [[03-Lid-Switch-Automation]] - Automated lid closing behavior
