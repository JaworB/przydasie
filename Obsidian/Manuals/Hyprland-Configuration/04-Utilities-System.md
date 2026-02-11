# Utilities and System

System utilities, launchers, and general system control bindings.

## Application Launchers

| Binding | Action | Command |
|---------|--------|---------|
| `SUPER + SPACE` | App Launcher | `omarchy-launch-walker` |
| `SUPER + CTRL + E` | Emoji Picker | `omarchy-launch-walker -m symbols` |
| `SUPER + ALT + SPACE` | Omarchy Menu | `omarchy-menu` |
| `SUPER + ESCAPE` | System Menu | `omarchy-menu system` |
| `XF86PowerOff` | Power Menu | `omarchy-menu system` |
| `SUPER + K` | Key Bindings Help | `omarchy-menu-keybindings` |
| `XF86Calculator` | Calculator | `gnome-calculator` |

## Aesthetics

| Binding | Action | Command |
|---------|--------|---------|
| `SUPER + SHIFT + SPACE` | Toggle Waybar | `omarchy-toggle-waybar` |
| `SUPER + CTRL + SPACE` | Next Background | `omarchy-theme-bg-next` |
| `SUPER + SHIFT + CTRL + SPACE` | Theme Menu | `omarchy-menu theme` |
| `SUPER + BACKSPACE` | Toggle Transparency | `setprop opaque toggle` |
| `SUPER + SHIFT + BACKSPACE` | Toggle Workspace Gaps | `omarchy-hyprland-workspace-toggle-gaps` |

## Notifications

| Binding | Action |
|---------|--------|
| `SUPER + ,` | Dismiss last |
| `SUPER + SHIFT + ,` | Dismiss all |
| `SUPER + CTRL + ,` | Toggle DND |
| `SUPER + ALT + ,` | Invoke last |
| `SUPER + SHIFT + ALT + ,` | Restore last |

## Power and Idle

| Binding | Action |
|---------|--------|
| `SUPER + CTRL + I` | Toggle Idle Locking |
| `SUPER + CTRL + L` | Lock Screen |

## Nightlight

| Binding | Action |
|---------|--------|
| `SUPER + CTRL + N` | Toggle Nightlight |

## Screenshot and Recording

| Binding | Action | Command |
|---------|--------|---------|
| `PRINT` | Screenshot with Editor | `omarchy-cmd-screenshot` |
| `SHIFT + PRINT` | Screenshot to Clipboard | `omarchy-cmd-screenshot smart clipboard` |
| `ALT + PRINT` | Screen Recording | `omarchy-menu screenrecord` |
| `SUPER + PRINT` | Color Picker | `hyprpicker -a` |

## Display Brightness (Apple Display)

| Binding | Action |
|---------|--------|
| `CTRL + F1` | Brightness Down |
| `CTRL + F2` | Brightness Up |
| `SHIFT + CTRL + F2` | Full Brightness |

## Control Panels

| Binding | Action | Command |
|---------|--------|---------|
| `SUPER + CTRL + A` | Audio Controls | `omarchy-launch-audio` |
| `SUPER + CTRL + B` | Bluetooth Controls | `omarchy-launch-bluetooth` |
| `SUPER + CTRL + W` | WiFi Controls | `omarchy-launch-wifi` |
| `SUPER + CTRL + T` | Activity Monitor (btop) | `omarchy-launch-tui btop` |

## File Sharing

| Binding | Action |
|---------|--------|
| `SUPER + CTRL + S` | Share Menu |

## Information Display

| Binding | Action | Output |
|---------|--------|--------|
| `SUPER + CTRL + ALT + T` | Show Time | Notification with date/time |
| `SUPER + CTRL + ALT + B` | Show Battery | Notification with percentage |

## Dictation

| Binding | Action |
|---------|--------|
| `SUPER + CTRL + X` | Start Dictation |
| `SUPER + CTRL (release) + X` | Stop Dictation |

## Related

- [[01-Omarchy-Defaults]] - Omarchy utilities framework
- [[02-Custom-Keybindings]] - Your custom application bindings
- [[03-Tiling-Window-Management]] - Window management
- [[08-Idle-Lock]] - Auto-lock configuration
