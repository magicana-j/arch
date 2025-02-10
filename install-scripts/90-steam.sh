#!/bin/sh

pkg_list=(
    xf86-video-intel
    mesa
    lib32-mesa
    vulkan-intel
    lib32-vulkan-intel
    xf86-video-amdgpu
    xf86-video-ati
    vulkan-radeon
    vulkan-amdvlk
    lib32-vulkan-radeon
    lib32-amdvlk
    xf86-video-nouveau
    vulkan-nouveau
    lib32-vulkan-nouveau
    steam
)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR="$SCRIPT_DIR/.."

if [ ! -d $(PARENT_DIR)/log ]; then
    mkdir $(PARENT_DIR)/log
fi

source "$(SCRIPT_DIR)/install.sh"

LOG_FILE="$(PARENT_DIR)/log/installation_$(date +%Y%m%d-%H%M%S).txt"

for pkg in "${pkg_list}"; do
	install_packages "$pkg" "$LOG_FILE"
done

echo "Installation is completed! Log is saved in $(LOG_FILE)."
