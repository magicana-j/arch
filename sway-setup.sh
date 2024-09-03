#!/bin/sh

sudo pacman -Syu
sudo pacman -S --needed brightnessctl rofi wofi foot grim pavucontrol slurp xorg-xwayland
sudo pacman -S --needed kitty foot alacritty xfce4-terminal wezterm
sudo pacman -S --needed sway swaybg swayidle swaylock waybar volumeicon network-manager-applet
