# DisplayLink Setup

Local reference for DisplayLink dock configuration.

## Manuals

- [[02-DisplayLink-Dock-Setup]] - Driver installation and monitor configuration
- [[09-Custom-Scripts/01-lid-handler-daemon]] - Automated lid closing behavior

## Scripts

Located in `~/.local/bin/`:
- `lid-handler-daemon.sh` - Background daemon for lid state monitoring
- `toggle-dock-mode.sh` - Manual dock mode toggle (SUPER+M)
- `fix-cursor-vertical.sh` - Cursor recalibration for vertical stacking
- `toggle-audio-output.sh` - Toggle between AirPods and speakers (SUPER+SHIFT+A)

## Quick Commands

```bash
# Toggle dock mode
~/.local/bin/toggle-dock-mode.sh

# Check monitor status
hyprctl monitors

# Restart lid handler
killall lid-handler-daemon.sh && ~/.local/bin/lid-handler-daemon.sh

# Toggle audio output
~/.local/bin/toggle-audio-output.sh
```
