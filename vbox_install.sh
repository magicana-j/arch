#!/bin/bash

# root 権限チェック
if [ "$EUID" -ne 0 ]; then
    echo "エラー: このスクリプトは root 権限で実行する必要があります。sudo を使用してください。"
    exit 1
fi

# 現在のカーネルリリースを取得
KERNEL_RELEASE=$(uname -r)
PACKAGES="virtualbox"
INSTALL_DKMS=false

echo "カーネル $KERNEL_RELEASE を検出しました。"

# カーネルの種類に応じたモジュールの選択
if [[ "$KERNEL_RELEASE" == *"-lts"* ]]; then
    MODULE_PKG="virtualbox-host-modules-artix-lts"
elif [[ "$KERNEL_RELEASE" == *"-zen"* ]]; then
    echo "Zen カーネルを検出しました。DKMS モジュールを使用します。"
    MODULE_PKG="virtualbox-host-dkms"
    PACKAGES="$PACKAGES linux-zen-headers"
    INSTALL_DKMS=true
elif [[ "$KERNEL_RELEASE" == *"-hardened"* ]]; then
    echo "Hardened カーネルを検出しました。DKMS モジュールを使用します。"
    MODULE_PKG="virtualbox-host-dkms"
    PACKAGES="$PACKAGES linux-hardened-headers"
    INSTALL_DKMS=true
else
    # 通常の linux カーネル用
    MODULE_PKG="virtualbox-host-modules-artix"
fi

PACKAGES="$PACKAGES $MODULE_PKG"

# インストール実行
echo "パッケージをインストール中: $PACKAGES"
pacman -S --needed --noconfirm $PACKAGES

# DKMS を使用する場合のビルド（念のため）
if [ "$INSTALL_DKMS" = true ]; then
    dkms autoinstall -k "$KERNEL_RELEASE"
fi

# カーネルモジュールの手動ロード（現在のセッション用）
echo "カーネルモジュールをロードしています..."
modprobe vboxdrv vboxnetadp vboxnetflt

# OpenRC の設定: /etc/conf.d/modules への登録
# 既存の記述を確認し、重複を避けて追記する
CONF_FILE="/etc/conf.d/modules"
VBOX_MODS="vboxdrv vboxnetadp vboxnetflt"

if [ ! -f "$CONF_FILE" ]; then
    touch "$CONF_FILE"
fi

for mod in $VBOX_MODS; do
    if ! grep -q "$mod" "$CONF_FILE"; then
        # 既存の modules="" 行があるか確認
        if grep -q "modules=" "$CONF_FILE"; then
            sed -i "s/modules=\"/modules=\"$mod /" "$CONF_FILE"
        else
            echo "modules=\"$mod\"" >> "$CONF_FILE"
        fi
        echo "$mod を $CONF_FILE の自動ロードリストに追加しました。"
    fi
done

# 実行したユーザーを vboxusers グループに追加
if [ -n "$SUDO_USER" ]; then
    gpasswd -a "$SUDO_USER" vboxusers
    echo "ユーザー $SUDO_USER を vboxusers グループに追加しました。"
else
    echo "警告: SUDO_USER が特定できなかったため、グループへの追加は手動で行ってください。"
fi

echo "--- 完了 ---"
echo "グループ設定を有効にするため、一度ログアウトして再ログインしてください。"

