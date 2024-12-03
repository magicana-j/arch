#!/bin/sh

sudo pacman -Syu
sudo pacman -S --needed wayland xorg-xwayland xorg-server-xwayland polkit \
  wlr-arandr kanshi way-displays \
  fuzzel foot alacritty nwg-drawer \
  waybar swaybg swaylock waylock swayidle wayshot \
  wf-recorder wl-clipboard clipman grimshot wl-screenrec wob obs-studio xwaylandvideobridge \
  noro-fonts-cjk fcitx5-{im,configtool,mozc} \
  brightnessctl pipewire pipewire-pulse pavucontrol wireplumber network-manager-applet \
  firefox \
  gvfs ntfs-3g xdg-user-dirs-gtk bluez blueman \
  xarchiver nemo nemo-fileroller mako volumeicon \
  sway
