#!/usr/bin/env bash
# install_media_tools.sh
# Installs desktop recording and audio/video editing tools on Arch Linux
# Target hardware: Panasonic CF-SZ6 (Intel HD Graphics 620)
# Arch Linux ISO: 2026.02.xx

set -euo pipefail

# --- Packages ---
PACKAGES=(
    obs-studio          # Desktop recording / streaming
    kdenlive            # Non-linear video editor
    shotcut             # Lightweight video editor
    openshot            # Beginner-friendly video editor
    audacity            # Audio recording and editing
    ffmpeg              # CLI multimedia framework (codec backend)
)

# Intel VA-API driver for hardware-accelerated encoding (QSV) on CF-SZ6
VAAPI_PACKAGES=(
    intel-media-driver  # iHD driver for 7th-gen Intel (Kaby Lake, CF-SZ6)
    libva-utils         # vainfo diagnostic tool
)

# --- Helpers ---
info()  { printf '\e[1;34m[INFO]\e[0m  %s\n' "$*"; }
ok()    { printf '\e[1;32m[ OK ]\e[0m  %s\n' "$*"; }
warn()  { printf '\e[1;33m[WARN]\e[0m  %s\n' "$*"; }
die()   { printf '\e[1;31m[ERR ]\e[0m  %s\n' "$*" >&2; exit 1; }

# --- Pre-flight checks ---
[[ $EUID -eq 0 ]] && die "Do not run as root. Run as a regular user with sudo privileges."
command -v pacman &>/dev/null || die "pacman not found. This script requires Arch Linux."

# --- System update ---
info "Updating package database..."
sudo pacman -Sy --noconfirm

# --- Install main packages ---
info "Installing media tools..."
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
ok "Media tools installed."

# --- Install VA-API packages ---
info "Installing Intel VA-API driver for CF-SZ6 (Intel HD 620)..."
sudo pacman -S --needed --noconfirm "${VAAPI_PACKAGES[@]}"
ok "VA-API driver installed."

# --- Verify VA-API ---
info "Verifying VA-API support..."
if vainfo &>/dev/null; then
    ok "VA-API is working."
    vainfo 2>&1 | grep -E 'Driver|VAProfile' | head -20
else
    warn "vainfo returned an error. Check LIBVA_DRIVER_NAME or reboot first."
fi

# --- Summary ---
echo ""
info "Installation complete. Installed packages:"
for pkg in "${PACKAGES[@]}" "${VAAPI_PACKAGES[@]}"; do
    printf '  - %s\n' "$pkg"
done

echo ""
info "Tips for CF-SZ6:"
echo "  - Set LIBVA_DRIVER_NAME=iHD in /etc/environment for system-wide VA-API."
echo "  - In OBS: Settings > Output > select Hardware (QSV) encoder for H.264."
echo "  - Kdenlive and Shotcut can use ffmpeg VA-API for export acceleration."
