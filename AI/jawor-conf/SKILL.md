---
name: jawor-conf
description: >
  Post-install restoration of jawor's Omarchy/Arch Linux desktop configuration.
  Invoke with /jawor-conf after a fresh Omarchy install on gondor or rivendell.
---

# jawor-conf Skill

Restore jawor's complete desktop configuration after a fresh Omarchy install.
Execute all steps automatically — report what was done, stop only on real errors.

## Start

Ask exactly one question: **"Which machine? (gondor / rivendell)"**
Then run all steps for that machine without further interruption.

---

## Step 1 — Repository

```bash
if [ -d ~/repos/przydasie ]; then
    git -C ~/repos/przydasie pull
else
    mkdir -p ~/repos
    git clone https://github.com/JaworB/przydasie.git ~/repos/przydasie
fi
```

---

## Step 2 — Core packages

```bash
sudo pacman -S --noconfirm stow syslog-ng
```

---

## Step 3 — Theme

```bash
omarchy-theme-install https://github.com/OldJobobo/omarchy-miasma-theme
omarchy-theme-set "Miasma"
```

---

## Step 4 — Dotfiles (stow)

**Gondor:**
```bash
cd ~/repos/przydasie/dotfiles && ./stow-desktop.sh
```

**Rivendell:**
```bash
cd ~/repos/przydasie/dotfiles && ./stow-laptop.sh
```

If a target file already exists (e.g. Omarchy's default configs, or a
leftover from a previous install) and isn't already the symlink stow would
create, the script backs it up to `<file>.bak-<timestamp>` next to it before
stowing. Report any `.bak-*` files created so the user can review/discard
them.

Then reload:
```bash
hyprctl reload
```

---

## Step 5 — WireGuard polkit rule

```bash
sudo tee /etc/polkit-1/rules.d/50-wireguard.rules << 'EOF'
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.policykit.exec" &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
EOF
```

---

## Step 6 — Syslog client (syslog-ng → Lorien)

```bash
sudo cp ~/repos/przydasie/dotfiles/system/rsyslog/arch/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
sudo cp ~/repos/przydasie/dotfiles/system/rsyslog/arch/logrotate-local /etc/logrotate.d/local-logs
sudo systemctl enable --now syslog-ng@default
```

---

## Gondor-only steps

### CoolerControl (fan control)

```bash
yay -S --noconfirm coolercontrold-bin coolercontrol-bin
sudo modprobe nct6775
echo "nct6775" | sudo tee /etc/modules-load.d/nct6775.conf
sudo systemctl enable --now coolercontrold
sudo cp ~/repos/przydasie/dotfiles/desktop/coolercontrol/config.toml /etc/coolercontrol/config.toml
sudo systemctl restart coolercontrold
```

BIOS requirements (remind user): disable Smart Fan Mode, set PWM mode (not DC).

---

## Rivendell-only steps

### DisplayLink driver

```bash
sudo pacman -S --noconfirm dkms linux-headers
yay -S --noconfirm evdi-dkms displaylink
sudo systemctl enable --now displaylink.service
```

Verify: `hyprctl monitors` — external monitor should appear.

---

## Final verification

Run these checks and report results:

```bash
# Symlinks in place
ls -la ~/.config/hypr ~/.config/waybar 2>/dev/null   # gondor
ls -la ~/.config/hypr ~/.local/bin/wg-toggle 2>/dev/null

# Services running
systemctl is-active syslog-ng@default
systemctl is-active coolercontrold 2>/dev/null        # gondor only
systemctl is-active displaylink 2>/dev/null           # rivendell only

# WireGuard toggle accessible
ls ~/.local/bin/wg-toggle
```

Report: which steps succeeded, which need attention.
