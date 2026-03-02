#!/bin/bash
# ============================================================
# Script 01 - Install yay (AUR Helper)
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

log "=== Installing prerequisites for yay ==="

# Install base-devel and git
sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    go

log "=== Cloning yay from AUR ==="

BUILD_DIR="$(mktemp -d)"
git clone https://aur.archlinux.org/yay.git "$BUILD_DIR/yay"

log "=== Building and installing yay ==="

cd "$BUILD_DIR/yay"
makepkg -si --noconfirm

# Verify installation
if command -v yay &>/dev/null; then
    log "yay installed successfully: $(yay --version)"
else
    error "yay installation failed."
fi

# Cleanup
rm -rf "$BUILD_DIR"
log "=== Done: yay is ready ==="
