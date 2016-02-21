#!/bin/bash

case "$1" in
    screen)
        cd ~/.config/herbstluftwm
        python system_setup.py list | rofi -p 'switch screen: ' -width 20 -dmenu | xargs python system_setup.py set

        # restart topbar if running
        if pidof lemonbar; then
            killall lemonbar
            sh topbar.sh &
        fi
        ;;
    song)
        mpc playlist | rofi -p 'jump to song: ' -dmenu -i --only-match -format d | xargs mpc play
        ;;
    password)
        cd ~/.password-store
        find . -name *.gpg | cut -c 3- | sed 's/.gpg//' | rofi -p "grab password: " -width 20 -dmenu | xargs pass -c
        ;;
esac

