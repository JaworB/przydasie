#!/bin/bash
# Logowanie: zwięzły status na ekranie + pełny log do pliku (debug).

: "${JAWOR_LOG_FILE:=/var/log/jawor-install.log}"

log_init() {
    local dir
    dir="$(dirname "$JAWOR_LOG_FILE")"
    if [ -w "$dir" ] || mkdir -p "$dir" 2>/dev/null; then
        touch "$JAWOR_LOG_FILE" 2>/dev/null || { sudo mkdir -p "$dir"; sudo touch "$JAWOR_LOG_FILE"; sudo chmod 666 "$JAWOR_LOG_FILE"; }
    else
        sudo mkdir -p "$dir"
        sudo touch "$JAWOR_LOG_FILE"
        sudo chmod 666 "$JAWOR_LOG_FILE"
    fi
    echo "=== jawor-install $(date -Iseconds) na $(hostname) ===" >> "$JAWOR_LOG_FILE"
}

step() {
    echo -e "\n\033[1;34m==>\033[0m $*"
    echo "[$(date -Iseconds)] STEP: $*" >> "$JAWOR_LOG_FILE"
}

ok() {
    echo -e "\033[1;32m  ok\033[0m $*"
    echo "[$(date -Iseconds)] OK: $*" >> "$JAWOR_LOG_FILE"
}

fail() {
    echo -e "\033[1;31m  FAIL\033[0m $*" >&2
    echo "[$(date -Iseconds)] FAIL: $*" >> "$JAWOR_LOG_FILE"
}

# run <opis> -- <komenda...>  — pełny output komendy trafia tylko do logu
run() {
    local desc="$1"; shift
    echo "[$(date -Iseconds)] RUN: $desc :: $*" >> "$JAWOR_LOG_FILE"
    if "$@" >>"$JAWOR_LOG_FILE" 2>&1; then
        ok "$desc"
    else
        fail "$desc — zobacz $JAWOR_LOG_FILE"
        exit 1
    fi
}
