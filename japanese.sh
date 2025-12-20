#!/usr/bin/env bash
set -euo pipefail

# Install Japanese fonts from AUR using yay
# Packages:
# - ttf-udev-gothic
# - ttf-hackgen
# - ttf-firge
# - ttf-plemoljp

FONTS=(
  ttf-udev-gothic
  ttf-hackgen
  ttf-firge
  ttf-plemoljp
)

if ! command -v yay >/dev/null 2>&1; then
  echo "WARNING: yay command not found." >&2
  echo "Please install an AUR helper (yay) before running this script." >&2
  exit 1
fi

echo "Installing Japanese fonts from AUR"
echo "Packages: ${FONTS[*]}"

yay -S --needed "${FONTS[@]}"

echo "Done."
echo "If the fonts are not available immediately, run: fc-cache -fv"