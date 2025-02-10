#!/bin/sh

pkg_list=(
    firefox
    go
    gparted
    pacman-contrib
    vim
    neovim
    nano
    less
    timeshift
    htop
    fastfetch
    wget
    curl
    zip
    unzip
    xarchiver
    bash-completion
    ufw
    gufw
    xdg-user-dirs-gtk
    reflector
    mousepad
    geany
    lm_sensors
    tmux
)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR="$SCRIPT_DIR/.."

if [ ! -d $(PARENT_DIR)/log ]; then
    mkdir $(PARENT_DIR)/log
fi

source "$(SCRIPT_DIR)/install.sh"

LOG_FILE="$(PARENT_DIR)/log/installation-base_$(date +%Y%m%d-%H%M%S).txt"

for pkg in "${pkg_list}"; do
	install_packages "$pkg" "$LOG_FILE"
done

echo "Installation is completed! Log is saved in $(LOG_FILE)."
