#!/bin/sh

sudo pacman -Syu
sudo pacman -S --needed brightnessctl rofi wofi grim pavucontrol slurp xorg-xwayland xorg-server-xwayland
sudo pacman -S --needed kitty foot alacritty xfce4-terminal wezterm
sudo pacman -S --needed sway swaybg swayidle swaylock waybar mako volumeicon network-manager-applet wl-clipboard clipman
