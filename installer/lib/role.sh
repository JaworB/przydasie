#!/bin/bash
# Detekcja roli hosta (desktop/laptop) po hostname, z fallbackiem na pytanie.
# $HOSTNAME to wbudowana zmienna basha (gethostname()) — działa nawet gdy
# pakiet z komendą `hostname` nie jest zainstalowany (np. profil Minimal).

detect_role() {
    case "$HOSTNAME" in
        gondor) echo "desktop" ;;
        rivendell) echo "laptop" ;;
        *)
            local ans
            read -rp "Ta maszyna to desktop czy laptop? [desktop/laptop]: " ans >&2
            echo "$ans"
            ;;
    esac
}
