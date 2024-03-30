sudo -Syyu
sudo pacman -S vim nano less timeshift neofetch wget curl unzip
sudo pacman -S ufw gufw xdg-user-dirs-gtk gnome-keyring
sudo pacman -S firefox
sudo pacman -S go
sudo pacman -S noto-fonts-cjk noto-fonts-extra noto-fonts-emoji
LANG=C xdg-user-dirs-gtk-update
sudo sed -i.bak -r ‘s/^#(ja_JP.UTF-8)/\1/i’ /etc/locale.gen
sudo localectl set-keymap jp106
sudo locale-gen
sudo localectl set-locale ja_JP.utf-8
# echo “export LANG=C” | sudo tee -a ~/.bashrc
