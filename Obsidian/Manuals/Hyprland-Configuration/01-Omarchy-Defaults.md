# Omarchy Defaults

Omarchy provides a comprehensive Hyprland configuration framework. Your setup sources these defaults first, then applies your custom overrides.

## Default Configuration Files

Omarchy defaults are located in `~/.local/share/omarchy/default/hypr/` and are sourced in this order:

### Core Files

| File | Purpose |
|------|---------|
| `autostart.conf` | Default applications launched on startup |
| `bindings.conf` | Master keybinding toggle switches |
| `envs.conf` | Environment variables (GDK_SCALE, etc.) |
| `looknfeel.conf` | General appearance: gaps, borders, rounding |
| `input.conf` | Default keyboard layout and touchpad settings |
| `windows.conf` | Default window rules |

### Binding Files

| File | Contents |
|------|----------|
| `bindings/media.conf` | Audio control (volume, mute, playerctl) |
| `bindings/clipboard.conf` | Clipboard manager shortcuts |
| `bindings/tiling-v2.conf` | Window management, workspaces, groups |
| `bindings/utilities.conf` | Launchers, screenshots, system menus |

## Key Omarchy Features

### Animations

Omarchy enables smooth animations with custom bezier curves:

```
bezier = neon,   0.4, 0.0, 0.2, 1.0
bezier = miasma, 0.55, 0.02, 0.38, 0.98
bezier = fogbank, 0.70, 0.01, 0.30, 1.00
bezier = toxic,   0.85, 0.00, 0.25, 1.00
```

### Visual Theme (Miasma)

The active border gradient uses a green-to-dark theme:

```
$activeBorderColorGreen = rgb(78824b)
$activeBorderColorDark = rgb(3c4125)
col.active_border = $activeBorderColorGreen $activeBorderColorDark 35deg
```

### Window Shadows

Soft shadows with 18px range and 60% opacity:

```
decoration {
    shadow {
        enabled = true
        range = 18
        render_power = 4
        color = rgba(0, 0, 0, 0.6)
        offset = 2 2
    }
}
```

## How Overrides Work

Your custom configs in `~/.config/hypr/` are sourced AFTER omarchy defaults, allowing you to:

1. **Overwrite** settings by redefining variables or options
2. **Disable** bindings by using `unbind`
3. **Add** new bindings at the end

Example from your `hyprland.conf`:

```
source = ~/.local/share/omarchy/default/hypr/looknfeel.conf  # Omarchy defaults
source = ~/.config/hypr/looknfeel.conf                       # Your overrides
```

## Related

- [[index]] - Main documentation index
- [[02-Custom-Keybindings]] - Your personal keybindings
- [[03-Tiling-Window-Management]] - Window management shortcuts
- [[04-Utilities-System]] - System utilities
