# 40-rsyslog.sh — klient syslog-ng → lorien:514, analogicznie do reszty infry.

run "Instalacja syslog-ng" sudo pacman -S --needed --noconfirm syslog-ng
run "Kopiowanie syslog-ng.conf" sudo cp "$REPO_DIR/dotfiles/system/rsyslog/arch/syslog-ng.conf" /etc/syslog-ng/syslog-ng.conf
run "Kopiowanie logrotate-local" sudo cp "$REPO_DIR/dotfiles/system/rsyslog/arch/logrotate-local" /etc/logrotate.d/local-logs
run "Enable syslog-ng@default" sudo systemctl enable --now syslog-ng@default
