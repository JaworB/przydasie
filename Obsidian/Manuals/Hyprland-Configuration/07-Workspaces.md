# Workspaces

Workspace-to-monitor mapping and virtual workspace configuration.

## Monitor-Workspace Mapping

### DVI-I-1 (DisplayLink)

| Workspace | Purpose |
|-----------|---------|
| 1 | Primary work |
| 2 | Secondary work |

### eDP-1 (Laptop)

| Workspace | Purpose |
|-----------|---------|
| 3 | Primary laptop |
| 4 | Secondary laptop |

## Configuration

```
workspace = 1, monitor: DVI-I-1
workspace = 2, monitor: DVI-I-1
workspace = 3, monitor: eDP-1
workspace = 4, monitor: eDP-1
```

## Layout Diagram

```
+---------------------+     +---------------------+
|      DVI-I-1        |     |       eDP-1          |
| +-----------------+ |     | +-----------------+ |
| |  WS 1  |  WS 2  | |     | |  WS 3  |  WS 4  | |
| |         |         | |     | |         |         | |
| |         |         | |     | |         |         | |
| +-----------------+ |     | +-----------------+ |
+---------------------+     +---------------------+
```

## Workspace Shortcuts

| Binding | Action |
|---------|--------|
| `SUPER + [1-9, 0]` | Switch to workspace 1-10 |
| `SUPER + TAB` | Next workspace |
| `SUPER + SHIFT + TAB` | Previous workspace |
| `SUPER + CTRL + TAB` | Return to previous workspace |
| `SUPER + mouse_scroll` | Scroll workspaces |

## Move Window to Workspace

| Binding | Action |
|---------|--------|
| `SUPER + SHIFT + [1-9, 0]` | Move window to workspace (with focus) |
| `SUPER + SHIFT + ALT + [1-9, 0]` | Move silently (no focus) |

## Move Workspace to Monitor

| Binding | Action |
|---------|--------|
| `SUPER + SHIFT + ALT + LEFT` | Move workspace left |
| `SUPER + SHIFT + ALT + RIGHT` | Move workspace right |
| `SUPER + SHIFT + ALT + UP` | Move workspace up |
| `SUPER + SHIFT + ALT + DOWN` | Move workspace down |

## Quick Commands

```bash
# List workspaces
hyprctl workspaces

# List monitors and their workspaces
hyprctl monitors

# Move active window to workspace 3
hyprctl dispatch movetoworkspace 3

# Move active window to workspace 3 (silent)
hyprctl dispatch movetoworkspacesilent 3

# Move current workspace to eDP-1
hyprctl dispatch movecurrentworkspacetomonitor eDP-1
```

## Related

- [[03-Tiling-Window-Management]] - Window and workspace controls
- [[05-Display-Setup]] - Monitor configuration
- [[index]] - Main documentation
