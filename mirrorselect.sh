#!/bin/sh
sudo cp /etc/pacman.conf.d/mirrorlist /etc/pacman.conf.d/mirrorlist.bak
sudo reflector --country Japan --age 24 --protocol https --sort rate --save /etc/pacman.conf.d/mirrorlist
