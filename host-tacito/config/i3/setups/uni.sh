#!/bin/bash

SETUPS="~/.config/i3/setups"

setxkbmap -model thinkpad -option grp:shifts_toggle "de(nodeadkeys),us" -option compose:caps

i3-msg workspace 1
i3-msg append_layout $SETUPS/uni1.json;
i3-msg exec "firefox"
i3-msg exec "st"
i3-msg exec "st -c irc -- abduco -c irc weechat"

i3-msg workspace 2;
i3-msg append_layout $SETUPS/uni2.json
i3-msg exec "thunderbird"
i3-msg exec "st -c telegram -- telegram-cli -N -W"

until xprop -name Firefox; do
    sleep 1
done
sleep 2
i3-msg exec "firefox -private-window"
sleep 2
i3-msg '[title=".*\(Private Browsing\).*"] move to workspace 4'

i3-msg exec owncloud
