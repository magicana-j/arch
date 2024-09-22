export LANG=C
sudo pacman -Syyu
sudo pacman -S --needed firefox
sudo pacman -S --needed go
sudo pacman -S --needed noto-fonts-{cjk,extra,emoji}
sudo pacman -S --needed bluez blueman
sudo pacman -S --needed flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo pacman -S --needed network-manager-applet
sudo pacman -S --needed podman
sudo pacman -S --needed fcitx5-im fcitx5-mozc fcitx5-configtool
cat << EOF >> ~/.xprofile
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
EOF
sudo pacman -S --needed lib32-mesa lib32-vulkan-intel
sudo pacman -S --needed gnome-software gparted pacman-contrib neovim vim nano less timeshift fastfetch neofetch wget curl unzip zip p7zip xarchiver bash-completion
sudo pacman -S --needed ufw gufw xdg-user-dirs-gtk gnome-keyring
