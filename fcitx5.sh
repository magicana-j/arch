sudo pacman -Syu fcitx5-im fcitx5-mozc fcitx5-configtool

echo "XMODIFIERS=@im=fcitx" >> ~/.bashrc
echo "GTK_IM_MODULE=fcitx" >> ~/.bashrc
echo "QT_IM_MODULE=fcitx" >> ~/.bashrc

echo "XMODIFIERS=@im=fcitx" >> ~/.xprofile
echo "GTK_IM_MODULE=fcitx" >> ~/.xprofile
echo "QT_IM_MODULE=fcitx" >> ~/.xprofile

exec fcitx5 -d
