#!/bin/sh
echo 'Installing flatpak ...'
sudo pacman -Sy flatpak
echo 'Adding flathub repository ...'
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Warehouse
echo 'Installing warehouse ...'
flatpak install -y flathub io.github.flattool.Warehouse

# OBS Studio
echo 'Installing OBS Studio ...'
flatpak install -y flathub com.obsproject.Studio

# GPU Screen Recorder
echo 'Installing GPU Screen Recorder ...'
flatpak install -y flathub com.dec05eba.gpu_screen_recorder

# VokoscreenNG
echo 'Installing VokoscreenNG ...'
flatpak install -y flathub com.github.vkohaupt.vokoscreenNG

# Easy Effects
echo 'Installing Easy Effects ...'
flatpak install -y flathub com.github.wwmm.easyeffects