export LANG=C
sudo -Syyu
sudo pacman -S --needed firefox
sudo pacman -S --needed go
sudo pacman -S --needed noto-fonts-{cjk,extra,emoji}
sudo pacman -S --needed bluez blueman
sudo pacman -S --needed flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo pacman -S --needed network-manager-applet
sudo pacman -S --needed podman
sudo pacman -S --needed fcitx5-im fcitx5-mozc fcitx5-configtool
sudo pacman -S --needed pacman-contrib neovim vim nano less timeshift fastfetch neofetch wget curl unzip zip p7zip bash-completion
sudo pacman -S --needed ufw gufw xdg-user-dirs-gtk gnome-keyring
