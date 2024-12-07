sudo pacman -S fcitx5-im fcitx5-mozc fcitx5-configtool

cat << EOF >> ~/.xprofile
setxkmap -layout jp
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
EOF

cat << EOF > ~/.config/environment.d/im.conf
XMODIFIERS=@im=fcitx
#GTK_IM_MODULE=fcitx
#QT_IM_MODULE=fcitx

EOF
