sudo pacman -Sy
sudo pacman -S noto-fonts-cjk noto-fonts-extra noto-fonts-emoji
sudo pacman -S fcitx5-im fcitx5-mozc fcitx5-configtool
sudo cat <<EOL >> /etc/environment

XMODIFIERS=@im=fcitx
#GTK_IM_MODULE=fcitx
#QT_IM_MODULE=fcitx
EOL
exec fcitx5 -d
