#!/bin/sh

sudo pacman -Sy --needed wayland niri mako waybar swaybg swayidle alacritty fuzzel
mkdir -p .config/niri

mkdir -p .config/waybar
cp /etc/xdg/waybar/* ~/.config/waybar/
mkdir -p .config/fuzzel
cp /etc/xdg/fuzzel/fuzzel.ini ~/.config/fuzzel/
