# Hyprland Configuration

Your Hyprland window manager setup, built on the [Omarchy](https://github.com/OldJobobo/omarchy) configuration framework with custom overrides.

## Architecture

Hyprland uses a layered configuration approach:

```
~/.config/hypr/hyprland.conf
    └── Sources in order:
        ├── ~/.local/share/omarchy/default/hypr/*      (Omarchy defaults)
        ├── ~/.config/omarchy/current/theme/hyprland.conf (Theme settings)
        ├── ~/.config/hypr/*.conf (Your overrides)
        └── Personal customizations at EOF
```

### Configuration Files

| File | Purpose |
|------|---------|
| `hyprland.conf` | Main config entry point |
| `bindings.conf` | Application launch shortcuts |
| `monitors.conf` | Display and monitor setup |
| `input.conf` | Keyboard and touchpad settings |
| `windows.conf` | Workspace-to-monitor mapping |
| `autostart.conf` | Programs to start on login |
| `hypridle.conf` | Idle behavior and auto-lock |
| `hyprlock.conf` | Lock screen configuration |
| `looknfeel.conf` | Visual appearance overrides |

## Key Resources

- [Hyprland Wiki](https://wiki.hyprland.org/Configuring/)
- [Omarchy Documentation](https://github.com/OldJobobo/omarchy)
- [Hyprland GitHub](https://github.com/hyprwm/Hyprland)

## Related Documentation

- [[Arch_after_install/01-DisplayLink-Setup]] - DisplayLink setup overview
- [[Arch_after_install/02-DisplayLink-Dock-Setup]] - Driver installation

## Sections

### Configuration
- [[01-Omarchy-Defaults]] - Omarchy default configuration reference
- [[02-Custom-Keybindings]] - Your personal application shortcuts
- [[03-Tiling-Window-Management]] - Window navigation and workspace control
- [[04-Utilities-System]] - System utilities and utilities

### Hardware
- [[05-Display-Setup]] - Monitor and DisplayLink configuration
- [[06-Input-Devices]] - Keyboard and touchpad settings
- [[07-Workspaces]] - Workspace-to-monitor mapping

### Automation
- [[08-Idle-Lock]] - Auto-lock and power management
- [[09-Custom-Scripts/]] - Custom shell scripts for Hyprland
  - [[09-Custom-Scripts/01-lid-handler-daemon]] - Lid state monitoring daemon
  - [[09-Custom-Scripts/02-toggle-dock-mode]] - Manual dock mode toggle
  - [[09-Custom-Scripts/03-fix-cursor-vertical]] - Cursor recalibration
  - [[09-Custom-Scripts/04-toggle-audio-output]] - Audio output toggle
