#!/bin/sh

sudo pacman -Syu
sudo pacman -S --needed dmenu xterm rofi lightdm lightdm-gtk-greeter
sudo pacman -S --needed i3-wm i3blocks i3status i3lock polybar volumeicon network-manager-applet
