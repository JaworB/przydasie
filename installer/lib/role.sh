#!/bin/bash
# Detekcja roli hosta (desktop/laptop) po hostname, z fallbackiem na pytanie.

detect_role() {
    case "$(hostname)" in
        gondor) echo "desktop" ;;
        rivendell) echo "laptop" ;;
        *)
            local ans
            read -rp "Ta maszyna to desktop czy laptop? [desktop/laptop]: " ans >&2
            echo "$ans"
            ;;
    esac
}
