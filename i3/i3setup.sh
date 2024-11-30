#!/bin/sh

sudo pacman -S i3-wm i3status i3blocks i3lock dunst dmenu alacritty grim slurp picom ttf-font-awesome

mkdir -p ~/.config/i3blocks
mkdir -p ~/.config/i3status
cp /usr/local/etc/i3/i3blocks.conf.sample ~/.config/i3blocks/conf
cp /usr/local/etc/i3/i3status.conf.sample ~/.config/i3status/conf

