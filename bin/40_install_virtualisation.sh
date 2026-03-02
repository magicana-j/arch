#!/bin/bash
# ============================================================
# Script 03 - Install Virtualisation (VirtualBox + GNOME Boxes)
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

CURRENT_USER="$(whoami)"
KERNEL_VERSION="$(uname -r)"

log "=== Detected kernel: $KERNEL_VERSION ==="

# --------------------------------------------------------
# VirtualBox
# --------------------------------------------------------
log "=== Installing VirtualBox prerequisites ==="

# Determine correct kernel headers package
if [[ "$KERNEL_VERSION" == *lts* ]]; then
    HEADERS_PKG="linux-lts-headers"
else
    HEADERS_PKG="linux-headers"
fi

log "Using headers package: $HEADERS_PKG"

sudo pacman -S --needed --noconfirm \
    "$HEADERS_PKG" \
    dkms

log "=== Installing VirtualBox ==="

sudo pacman -S --needed --noconfirm \
    virtualbox \
    virtualbox-host-dkms \
    virtualbox-guest-iso

# Load VirtualBox kernel module
log "=== Loading VirtualBox kernel module ==="
sudo modprobe vboxdrv || warn "modprobe vboxdrv failed. A reboot may be required."

# Add user to vboxusers group
if ! groups "$CURRENT_USER" | grep -q "vboxusers"; then
    log "Adding $CURRENT_USER to vboxusers group..."
    sudo usermod -aG vboxusers "$CURRENT_USER"
    warn "Group change for vboxusers requires logout/login to take effect."
else
    log "$CURRENT_USER is already in vboxusers group."
fi

# Verify
if pacman -Q virtualbox &>/dev/null; then
    log "VirtualBox installed successfully: $(pacman -Q virtualbox)"
else
    error "VirtualBox installation failed."
fi

# --------------------------------------------------------
# GNOME Boxes
# --------------------------------------------------------
log "=== Installing GNOME Boxes prerequisites ==="

sudo pacman -S --needed --noconfirm \
    qemu-full \
    libvirt \
    dnsmasq \
    virt-manager

log "=== Installing GNOME Boxes ==="

sudo pacman -S --needed --noconfirm gnome-boxes

# Enable and start libvirtd
log "=== Enabling libvirtd service ==="
sudo systemctl enable --now libvirtd

# Add user to libvirt group
if ! groups "$CURRENT_USER" | grep -q "libvirt"; then
    log "Adding $CURRENT_USER to libvirt group..."
    sudo usermod -aG libvirt "$CURRENT_USER"
    warn "Group change for libvirt requires logout/login to take effect."
else
    log "$CURRENT_USER is already in libvirt group."
fi

# Verify
if pacman -Q gnome-boxes &>/dev/null; then
    log "GNOME Boxes installed successfully: $(pacman -Q gnome-boxes)"
else
    error "GNOME Boxes installation failed."
fi

log "=== Done: VirtualBox and GNOME Boxes are ready ==="
warn "Please reboot or re-login to apply group membership changes (vboxusers, libvirt)."
