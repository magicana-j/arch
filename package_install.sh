#!/bin/bash

# root権限チェック
if [ "$EUID" -ne 0 ]; then
  echo "このスクリプトは sudo で実行してください。"
  exit 1
fi

# インストール対象（公式リポジトリ）
PACKAGES=(
    "gvfs" "udiskie" "exfat-utils"
    "noto-fonts-cjk" "noto-fonts-extra" "noto-fonts-emoji"
    "fcitx5-mozc" "fcitx5-configtool" "fcitx5-gtk" "fcitx5-qt"
    "base-devel" "go" "git" "curl"
    "firefox" "audacity" "ffmpeg" "vlc" "gimp"
    "vim" "neovim" "geany" "btop" "fastfetch" "xdg-user-dirs-gtk"
)

# 削除対象
REMOVE_PACKAGES=("ttf-droid")

echo "--- システムを更新しています ---"
pacman -Syu --noconfirm

echo "--- 指定されたパッケージをインストール中 ---"
for pkg in "${PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        echo "[$pkg] は既にインストールされています。"
    else
        pacman -S --noconfirm "$pkg"
    fi
done

echo "--- 不要なパッケージを削除中 ---"
for pkg in "${REMOVE_PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        pacman -Rs --noconfirm "$pkg"
    else
        echo "[$pkg] はインストールされていないためスキップします。"
    fi
done

echo "--- すべての処理が完了しました ---"
