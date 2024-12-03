#!/bin/sh

sudo pacman -Syu
sudo pacman -S --needed wayland xorg-xwayland xorg-server-xwayland polkit \
  fuzzel foot alacritty nwg-drawer \
  waybar swaybg swaylock waylock swayidle \
  wf-recorder wl-clipboard wob obs-studio xwaylandvideobridge \
  noto-fonts-cjk fcitx5-{im,configtool,mozc} \
  brightnessctl pipewire pipewire-pulse pavucontrol wireplumber network-manager-applet \
  firefox \
  gvfs ntfs-3g xdg-user-dirs-gtk bluez blueman \
  xarchiver nemo nemo-fileroller mako volumeicon kanshi \
  sway

cp -rf ./config/* ~/.config/
