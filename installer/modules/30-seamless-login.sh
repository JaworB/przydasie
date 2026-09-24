# 30-seamless-login.sh — start Hyprland bez ekranu logowania (docelowe
# rozwiazanie, nie tymczasowy skrot). Port mechanizmu z
# omarchyconf/install/login/plymouth.sh: maly helper C aktywujacy VT1 w
# trybie graficznym (zero migotania konsoli) i przekazujacy do uwsm.

run "Instalacja gcc (do kompilacji helpera)" sudo pacman -S --needed --noconfirm gcc

if [ ! -x /usr/local/bin/seamless-login ]; then
    step "Kompilacja seamless-login"
    cat > /tmp/seamless-login.c <<'CCODE'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/kd.h>
#include <linux/vt.h>
#include <string.h>

int main(int argc, char *argv[]) {
    int vt_fd;
    int vt_num = 1;
    char vt_path[32];

    if (argc < 2) {
        fprintf(stderr, "Usage: %s <session_command>\n", argv[0]);
        return 1;
    }

    snprintf(vt_path, sizeof(vt_path), "/dev/tty%d", vt_num);
    vt_fd = open(vt_path, O_RDWR);
    if (vt_fd < 0) { perror("Failed to open VT"); return 1; }

    if (ioctl(vt_fd, VT_ACTIVATE, vt_num) < 0) { perror("VT_ACTIVATE failed"); close(vt_fd); return 1; }
    if (ioctl(vt_fd, VT_WAITACTIVE, vt_num) < 0) { perror("VT_WAITACTIVE failed"); close(vt_fd); return 1; }
    if (ioctl(vt_fd, KDSETMODE, KD_GRAPHICS) < 0) { perror("KDSETMODE KD_GRAPHICS failed"); close(vt_fd); return 1; }

    const char *clear_seq = "\33[H\33[2J";
    if (write(vt_fd, clear_seq, strlen(clear_seq)) < 0) perror("Failed to clear VT");
    close(vt_fd);

    const char *home = getenv("HOME");
    if (home) chdir(home);

    execvp(argv[1], &argv[1]);
    perror("Failed to exec session");
    return 1;
}
CCODE
    run "Kompilacja seamless-login.c" gcc -o /tmp/seamless-login /tmp/seamless-login.c
    sudo mv /tmp/seamless-login /usr/local/bin/seamless-login
    sudo chmod +x /usr/local/bin/seamless-login
    rm -f /tmp/seamless-login.c
    ok "Zainstalowano /usr/local/bin/seamless-login"
fi

SEAMLESS_USER="$(whoami)"

sudo tee /etc/systemd/system/jawor-seamless-login.service > /dev/null <<EOF
[Unit]
Description=Seamless auto-login -> Hyprland (bez ekranu logowania)
Conflicts=getty@tty1.service
After=systemd-user-sessions.service getty@tty1.service plymouth-quit.service systemd-logind.service
PartOf=graphical.target

[Service]
Type=simple
ExecStart=/usr/local/bin/seamless-login uwsm start -- hyprland.desktop
Restart=always
RestartSec=2
StartLimitIntervalSec=30
StartLimitBurst=2
User=$SEAMLESS_USER
TTYPath=/dev/tty1
TTYReset=yes
TTYVHangup=yes
TTYVTDisallocate=yes
StandardInput=tty
StandardOutput=journal
StandardError=journal+console
PAMName=login

[Install]
WantedBy=graphical.target
EOF
ok "Utworzono jawor-seamless-login.service"

sudo mkdir -p /etc/systemd/system/plymouth-quit.service.d
sudo tee /etc/systemd/system/plymouth-quit.service.d/wait-for-graphical.conf > /dev/null <<'EOF'
[Unit]
After=multi-user.target
EOF

run "Maskowanie plymouth-quit-wait.service" sudo systemctl mask plymouth-quit-wait.service
run "daemon-reload" sudo systemctl daemon-reload
run "Wlaczenie jawor-seamless-login.service" sudo systemctl enable jawor-seamless-login.service
run "Wylaczenie getty@tty1.service" sudo systemctl disable getty@tty1.service
run "Ustawienie graphical.target jako domyslnego" sudo systemctl set-default graphical.target
