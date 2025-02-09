#!/bin/bash

# ログファイルの設定
LOG_FILE="installation_log.txt"

# パッケージのインストール処理を行う関数
install_packages() {
    local package_file=$1
    echo "Proccessing $package_file ..." | tee -a "$LOG_FILE"
    
    while IFS= read -r package; do
        # 空行やコメント行をスキップ
        [ -z "$pkg" ] || [ "${pkg#\#}" != "$pkg" ] && continue

        # パッケージがインストールされているか確認
        if pacman -Qi "$package" &> /dev/null; then
            echo "$package is already installed. Skipping." | tee -a "$LOG_FILE"
        else
            echo "Installing $package ..." | tee -a "$LOG_FILE"
            if sudo pacman -S --noconfirm "$package"; then
                echo "$package is installed successfully." | tee -a "$LOG_FILE"
            else
                echo "$package is failed to be installed." | tee -a "$LOG_FILE"
            fi
        fi
    done < "$package_file"
}

# メイン処理
main() {
    # パッケージリストファイルの配列
    package_files=(
        "base-tools.txt"
        "multimedia.txt"
        "bluetooth.txt"
        "opengl-intel.txt"
        "libreoffice.txt"
    )

    for file in "${package_files[@]}"; do
        if [ -f "$file" ]; then
            install_packages "$file"
        else
            echo "Warning: $file not found. Skipping it." | tee -a "$LOG_FILE"
        fi
    done

    echo "Installation is completed! Log is saved in $LOG_FILE ."
}

# メイン関数の実行
main
