#!/bin/bash

i3-msg exec dunst
i3-msg exec xfce4-power-manager
i3-msg exec xfce4-volumed
i3-msg exec xfsettingsd
i3-msg exec sh ~/.fehbg

sleep 1
~/bin/screen.sh

SETUPS="~/.config/i3/setups"
SCREENRES=`xrandr | grep "*" | awk '{print $1}'`

case "$SCREENRES" in
    1680x1050)
        exec $SETUPS/uni.sh
        ;;
esac
