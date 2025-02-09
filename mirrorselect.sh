#!/bin/sh
echo 'Backup mirrorlist ...'
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

echo 'Selecting mirrors ...'
sudo reflector --country Japan --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Syu
