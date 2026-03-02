#!/bin/bash
# ============================================================
# Script 02 - Install Steam (Games)
# Target: Panasonic CF-SZ6 | Arch Linux 2026.02.01
# ============================================================

set -euo pipefail

# -- Colors --
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()   { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()  { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# -- Must NOT run as root --
if [[ $EUID -eq 0 ]]; then
    error "Do not run this script as root."
fi

# -- Enable multilib repository if not already enabled --
log "=== Checking multilib repository ==="

PACMAN_CONF="/etc/pacman.conf"

if grep -q "^\[multilib\]" "$PACMAN_CONF"; then
    log "multilib is already enabled."
else
    warn "multilib is not enabled. Enabling now..."
    sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' "$PACMAN_CONF"

    # Verify it was uncommented
    if ! grep -q "^\[multilib\]" "$PACMAN_CONF"; then
        error "Failed to enable multilib. Please enable it manually in $PACMAN_CONF."
    fi
    log "multilib enabled successfully."
fi

log "=== Syncing package databases ==="
sudo pacman -Sy

log "=== Installing Steam prerequisites (lib32 libraries) ==="

sudo pacman -S --needed --noconfirm \
    lib32-mesa \
    lib32-gcc-libs \
    lib32-libglvnd \
    lib32-alsa-plugins \
    lib32-alsa-lib \
    lib32-libpulse \
    lib32-openal

log "=== Installing Intel-specific prerequisites for CF-SZ6 ==="

sudo pacman -S --needed --noconfirm \
    intel-media-driver \
    vulkan-intel

log "=== Installing Steam ==="

sudo pacman -S --needed --noconfirm steam

# Verify
if pacman -Q steam &>/dev/null; then
    log "Steam installed successfully: $(pacman -Q steam)"
else
    error "Steam installation failed."
fi

log "=== Done: Steam is ready ==="
log "Launch Steam from your application menu or by running: steam"
