#!/bin/sh

sudo pacman -Syu
sudo pacman -S --needed wayland xorg-xwayland xorg-server-xwayland polkit \
  xwaylandvideobridge qt5-wayland qt6-wayland

sudo pacman -S --needed kitty foot alacritty 
sudo pacman -S --needed gvfs ntfs-3g xdg-user-dirs-gtk bluez blueman \
  xarchiver mako volumeicon kanshi \
sudo pacman -S --needed  nwg-drawer \
  waybar swaybg swaylock swayidle \
  wf-recorder wl-clipboard wob
  
sudo pacman -S --needed  brightnessctl pavucontrol network-manager-applet \
  firefox obs-studio pcmanfm dolphin thunar thunar-archive-plugin
sudo pacman -S --needed sway

cp -rf ./config/* ~/.config/
