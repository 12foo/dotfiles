#!/bin/bash

# configurables
barheight=24
separator="|"
font1="Terminus:size=9"
font2="-wuncon-siji-medium-r-normal-*-*-*-*-*-*-*-*-*"
color_foreground="#ffffff"
color_background="#282f3a"

set -f

DIR=~/.config/herbstluftwm
monitor=0
mgeom=( $(herbstclient monitor_rect "$monitor") )
offset=$(herbstclient get frame_gap)
bargeometry="${mgeom[2]}x$barheight+0+0"

herbstclient pad $monitor $(expr $barheight)

python $DIR/topbar.py | lemonbar -u 2 -d -p -g $bargeometry -o -1 -f $font1 -o -2 -f $font2 -F $color_foreground -B $color_background
