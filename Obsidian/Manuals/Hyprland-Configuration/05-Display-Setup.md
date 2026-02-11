# Display Setup

Monitor configuration including primary display, external DisplayLink dock, and scaling.

## Current Configuration

### Primary Monitor (eDP-1)

Built-in laptop display at 0x1440 position with 2x scaling:

```
monitor = eDP-1, preferred, 0x1440, 2
```

### External Display (DVI-I-1)

DisplayLink dock monitor at 50Hz with 1x scaling:

```
monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
```

## Vertical Stack Layout

```
+---------------------+
|     DVI-I-1         |
|   (3440x1440)       |
|                     |
+---------------------+
      ^
      | 0x1440
      v
+---------------------+
|      eDP-1          |
|    (laptop)         |
|     2x scale        |
+---------------------+
```

## Scaling Configuration

```
env = GDK_SCALE,2
```

Optimized for HiDPI displays. Alternative presets available in `monitors.conf` for:
- 1.75x for 27"/32" 4K monitors
- 1x for 1080p/1440p displays
- Custom per-monitor configurations

## Quick Commands

```bash
# Check monitor status
hyprctl monitors

# Get current configuration
hyprctl monitor eDP-1
hyprctl monitor DVI-I-1
```

## Display Controls

### Manual Toggle (SUPER + M)

Toggles between dock mode and normal mode:

```
~/.local/bin/toggle-dock-mode.sh
```

### Cursor Recalibration (SUPER + SHIFT + V)

Fixes cursor issues when monitors are in vertical stack:

```
~/.local/bin/fix-cursor-vertical.sh
```

## DisplayLink Dock Mode

### When Active (Lid Closed + AC)

```
eDP-1: disabled
DVI-I-1: 3440x1440@50.00, 0x0, 1
```

### When Normal (Lid Open or On Battery)

```
DVI-I-1: 3440x1440@50.00, 0x0, 1
eDP-1: preferred, 0x1440, 2
```

## Related Documentation

- [[Arch_after_install/01-DisplayLink-Setup]] - DisplayLink setup overview
- [[Arch_after_install/02-DisplayLink-Dock-Setup]] - Driver installation
- [[09-Custom-Scripts/01-lid-handler-daemon]] - Lid handler daemon
- [[09-Custom-Scripts]] - toggle-dock-mode.sh and fix-cursor-vertical.sh

## Related

- [[index]] - Main documentation
- [[06-Input-Devices]] - Input configuration
- [[07-Workspaces]] - Workspace-to-monitor mapping
