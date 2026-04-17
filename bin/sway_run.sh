#!/bin/sh

# Wayland関連
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway

# 日本語入力 (fcitx5など)
export XMODIFIERS=@im=fcitx

exec sway
