# DisplayLink Setup

Local reference for DisplayLink dock configuration.

## Manuals

- [[02-DisplayLink-Dock-Setup]] - Driver installation and monitor configuration
- [[03-Lid-Switch-Automation]] - Automated lid closing behavior

## Scripts

Located in `scripts/`:
- `lid-handler-daemon.sh` - Background daemon for lid state monitoring
- `toggle-dock-mode.sh` - Manual dock mode toggle (SUPER+m)
- `fix-cursor-vertical.sh` - Cursor recalibration for vertical stacking

## Quick Commands

```bash
# Toggle dock mode
~/.local/bin/toggle-dock-mode.sh

# Check monitor status
hyprctl monitors

# Restart lid handler
killall lid-handler-daemon.sh && ~/.local/bin/lid-handler-daemon.sh
```
