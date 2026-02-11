# Input Devices

Keyboard layout, touchpad settings, and input device configuration.

## Keyboard Configuration

### Layout

```
kb_layout = pl
```

Polish keyboard layout with Compose key:

```
kb_options = compose:caps
```

### Repeat Settings

```
repeat_rate = 40
repeat_delay = 600
```

| Setting | Value | Description |
|---------|-------|-------------|
| repeat_rate | 40 | Characters per second when holding key |
| repeat_delay | 600 | ms before repeat starts |

### Numlock

```
numlock_by_default = true
```

NumLock is enabled on startup.

### Compose Key

The Caps Lock key is configured as Compose key (`compose:caps`), enabling:
- `Compose + , + c` → ç
- `Compose + ' + e` → é
- `Compose + < + <` → «
- Many more combinations via X Compose

## Touchpad Configuration

### Natural Scrolling

```
natural_scroll = true
```

Inverted scrolling direction (like macOS).

### Scroll Factor

```
scroll_factor = 0.4
```

Reduces scroll speed to 40% of default.

### Touchpad Features (Disabled)

These are available but disabled in your config:

| Setting | Default | Description |
|---------|---------|-------------|
| clickfinger_behavior | false | Two-finger right-click |
| disable_while_typing | true | Disable while typing |
| drag_3fg | false | Three-finger drag |

## Terminal Scroll Settings

Special scroll speed for terminals:

```conf
# Alacritty, kitty
windowrule = match:class (Alacritty|kitty), scroll_touchpad 1.5

# Ghostty
windowrule = match:class com.mitchellh.ghostty, scroll_touchpad 0.2
```

| Terminal | Scroll Speed |
|----------|--------------|
| Alacritty | 1.5x |
| kitty | 1.5x |
| Ghostty | 0.2x |

## Touchpad Gestures (Available)

Touchpad gestures are available but disabled:

```conf
# gesture = 3, horizontal, workspace  # 3-finger swipe workspaces
```

## Quick Commands

```bash
# List input devices
hyprctl devices

# Get keyboard repeat info
xset r

# Test keyboard layout
setxkbmap -print | xkbcomp - - | xkbprint - - | ps2pdf - > keyboard.pdf
```

## Related

- [[index]] - Main documentation
- [[01-Omarchy-Defaults]] - Omarchy default input settings
- [[05-Display-Setup]] - Display configuration
