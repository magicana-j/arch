sudo pacman -S --needed noto-fonts-{cjk,extra,emoji} adobe-source-code-pro-fonts
sudo pacman -S --needed fcitx5-{im,configtool,mozc}

echo << EOF >> ~/.xprofile
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
EOF

# LANG=C xdg-user-dirs-gtk-update
# sudo sed -i.bak -r ‘s/^#(ja_JP.UTF-8)/\1/i’ /etc/locale.gen
# sudo localectl set-keymap jp106
# sudo locale-gen
# sudo localectl set-locale ja_JP.utf-8
# echo “export LANG=C” | sudo tee -a ~/.bashrc
