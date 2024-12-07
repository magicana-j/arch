#!/bin/sh

sudo pacman -Syu
sudo pacman -S --needed wayland xorg-xwayland xorg-server-xwayland polkit \
  fuzzel foot alacritty nwg-drawer \
  waybar swaybg swaylock waylock swayidle \
  wf-recorder wl-clipboard wob obs-studio xwaylandvideobridge \
  brightnessctl pavucontrol network-manager-applet \
  firefox nemo nemo-fileroller thunar thunar-archive-plugin \
  gvfs ntfs-3g xdg-user-dirs-gtk bluez blueman \
  xarchiver mako volumeicon kanshi \
  sway

cp -rf ./config/* ~/.config/
