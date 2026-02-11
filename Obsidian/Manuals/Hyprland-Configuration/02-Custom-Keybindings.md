# Custom Keybindings

Your personal application launch shortcuts using SUPER (Windows/Command) key.

## Application Launchers

| Binding | Action | Command |
|---------|--------|---------|
| `SUPER + RETURN` | Terminal | `uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"` |
| `SUPER + SHIFT + F` | File Manager | `nautilus --new-window` |
| `SUPER + SHIFT + B` | Browser | `omarchy-launch-browser` |
| `SUPER + SHIFT + ALT + B` | Browser (Private) | `omarchy-launch-browser --private` |
| `SUPER + SHIFT + M` | Spotify | `omarchy-launch-or-focus spotify` |
| `SUPER + SHIFT + A` | Toggle Audio Output | `~/.local/bin/toggle-audio-output.sh` |
| `SUPER + SHIFT + N` | Editor | `omarchy-launch-editor` |
| `SUPER + SHIFT + D` | Docker TUI | `omarchy-launch-tui lazydocker` |
| `SUPER + SHIFT + O` | Obsidian | `obsidian -disable-gpu --enable-wayland-ime` |
| `SUPER + CTRL + O` | Opencode | `omarchy-launch-tui opencode` |

## Web Applications

| Binding | Action | URL |
|---------|--------|-----|
| `SUPER + SHIFT + Y` | YouTube | `https://youtube.com/` |
| `SUPER + SHIFT + W` | WhatsApp | `https://web.whatsapp.com/` |
| `SUPER + SHIFT + CTRL + G` | Google Messages | `https://messages.google.com/web/conversations` |
| `SUPER + SHIFT + P` | Google Photos | `https://photos.google.com/` |
| `SUPER + SHIFT + X` | X (Twitter) | `https://x.com/` |
| `SUPER + SHIFT + ALT + X` | X Post | `https://x.com/compose/post` |

## Display Controls

| Binding | Action | Script |
|---------|--------|--------|
| `SUPER + M` | Toggle Dock Mode | `toggle-dock-mode.sh` |
| `SUPER + SHIFT + V` | Fix Vertical Cursor | `fix-cursor-vertical.sh` |

## Configuration File

Location: `~/.config/hypr/bindings.conf`

## Notes

- Use `##` in URLs to escape the `#` character (hyprland treats `#` as a comment)
- Web apps open in native windows via `omarchy-launch-webapp`
- Terminal cwd is preserved using `omarchy-cmd-terminal-cwd`

## Related

- [[01-Omarchy-Defaults]] - Omarchy default bindings
- [[03-Tiling-Window-Management]] - Window management shortcuts
- [[05-Display-Setup]] - Display controls
- [[09-Custom-Scripts]] - Custom scripts documentation
