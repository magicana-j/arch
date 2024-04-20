sudo pacman -S --needed bluez bluez-utils bluez-libs blueman pulseaudio-alsa pulseaudio-bluetooth
sudo systemctl start bluetooth
sudo systemctl enable bluetooth

# bluetoothctl
