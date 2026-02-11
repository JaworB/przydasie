# Idle Lock Configuration

Automatic locking, screensaver, and power management using hypridle and hyprlock.

## Idle Timeline

| Time | Action |
|------|--------|
| 2.5 minutes (150s) | Start screensaver |
| 5 minutes (151s) | Lock screen |
| 5.5 minutes (330s) | Turn off display (DPMS) |

## Configuration File

Location: `~/.config/hypr/hypridle.conf`

## hypridle Settings

```conf
general {
    lock_cmd = omarchy-lock-screen
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch dpms on
    inhibit_sleep = 3
}

listener { timeout = 150; on-timeout = pidof hyprlock || omarchy-launch-screensaver }
listener { timeout = 151; on-timeout = loginctl lock-session }
listener { timeout = 330; on-timeout = hyprctl dispatch dpms off }
```

## hyprlock Settings

Location: `~/.config/hypr/hyprlock.conf`

### Appearance

- Background: Theme background with 3 blur passes
- Input field: Centered, 650x100 pixels
- Font: JetBrainsMono Nerd Font
- Rounding: 0 (sharp corners)
- Animations: Disabled for fast response

### Features

- Ignore empty input
- Fingerprint authentication enabled
- Password placeholder: "Enter Password"
- Failed attempt counter

## Idle Toggle

Manual control available:

| Binding | Action |
|---------|--------|
| `SUPER + CTRL + I` | Toggle auto-locking |

## Wake from Display Off

When display is off (DPMS), any input activity will:
1. Turn display back on
2. Restore brightness

```bash
hyprctl dispatch dpms on && brightnessctl -r
```

## Related

- [[04-Utilities-System]] - Lock screen and power controls
- [[09-Custom-Scripts]] - Custom scripts for display management
- [Hyprland Wiki: Idle](https://wiki.hyprland.org/Configuring/Idle/)

## Related

- [[index]] - Main documentation
- [[03-Tiling-Window-Management]] - Window management
