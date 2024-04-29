sudo pacman -S fcitx5-im fcitx5-mozc fcitx5-configtool

echo <<EOF >> ~/.bashrc
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

EOF

echo <<EOF >> ~/.xprofile
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

EOF

echo <<EOF >> ~/.xsession
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

EOF

echo <<EOF >> ~/.config/environment.d/im.conf
XMODIFIERS=@im=fcitx
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx

EOF
