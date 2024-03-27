sudo pacman -Syu fcitx5-im fcitx5-mozc fcitx5-configtool
echo "XMODIFIERS=@im=fcitx" | sudo tee -a /etc/environment
echo "GTK_IM_MODULE=fcitx" | sudo tee -a /etc/environment
echo "QT_IM_MODULE=fcitx" | sudo tee -a /etc/environment
exec fcitx5 -d
