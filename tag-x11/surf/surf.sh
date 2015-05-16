#!/bin/sh
# v. 2.0 - upgrade based on surf 4.0
# Creative Commons License.  Peter John Hartman (http://individual.utoronto.ca/peterjh)
# Much thanks to nibble and pancake who have a different surf.sh script available which
# doesn't do the history bit.
#
# this script does:
# * stores history of: (1) successful uri entries; (2) certain smart prefix entries, e.g., "g foobar"; (3) find entries
# * direct bookmark (via ^b)
# * information debug (via ^I)
# * smart prefixes e.g. g for google search, t for tinyurl, etc.
# * delete (with smart prefix x)
#
# $1 = $xid
# $2 = $p = _SURF_FIND _SURF_BMARK _SURF_URI (what SETPROP sets in config.h)
#
# // replace default setprop with this one
# #define SETPROP(p) { .v = (char *[]){ "/bin/sh", "-c", "surf.sh $0 $1 $2", p, q, winid, NULL } }
#
# { MODKEY, GDK_b, spawn, SETPROP("_SURF_BMARK") },
# { MODKEY|GDK_SHIFT_MASK, GDK_i, spawn, SETPROP("_SURF_INFO") },
# { MODKEY|GDK_SHIFT_MASK, GDK_g, spawn, SETPROP("_SURF_URI_RAW") },

font='-*-terminus-medium-*-*-*-*-*-*-*-*-*-*-*'
normbgcolor='#181818'
normfgcolor='#e9e9e9'
selbgcolor=$normbgcolor
selfgcolor='#dd6003'
bmarks=~/.surf/history.txt
ffile=~/.surf/find.txt 

pid=$1
fid=$2
xid=$3

dmenu="dmenu -nb $normbgcolor -nf $normfgcolor \
       -sb $selbgcolor -sf $selfgcolor"

s_get_prop() { # xprop
    xprop -id $xid $1 | cut -d '"' -f 2
}

s_set_prop() { # xprop value
    [ -n "$2" ] && xprop -id $xid -f $1 8s -set $1 "$2"
}

s_write_f() { # file value
    [ -n "$2" ] && (sed -i "\|$2|d" $1; echo "$2" >> $1)
    #grep "$uri" $bmarks >/dev/null 2>&1 || echo "$uri" >> $bmarks
}

s_set_write_proper_uri() { # uri
    # TODO: (xprop -spy _SURF_URI ... | while read name __ value; do echo $value; done works quite nice for eventloops)
    # input is whatever the use inputed, so don't store that!
    # first, clear the name field because surf doesn't sometimes
    #s_set_prop WM_ICON_NAME ""
    # set the uri
    s_set_prop _SURF_GO "$1"
    # get the new name
    name=`s_get_prop WM_ICON_NAME`
    # loop until the [10%] stuff is finished and we have a load (is this necessary?)
    #while echo $name | grep "[*%\]" >/dev/null 2>&1; do 
    #   name=`s_get_prop WM_ICON_NAME`
    #done 
    # bail on error and don't store
    #if [[ $name != "Error" ]]; then
    #   uri=`s_get_prop _SURF_URI`
        # store to the bmarks file the OFFICIAL url (with http://whatever)
        s_write_f $bmarks "$1"
        #grep "$uri" $bmarks >/dev/null 2>&1 || echo "$uri" >> $bmarks
    #fi
}

case "$pid" in
"_SURF_INFO")
    xprop -id $xid | sed 's/\t/    /g' | $dmenu -b -l 20
    ;;
"_SURF_FIND")
    find="`tac $ffile 2>/dev/null | $dmenu -b -p find:`"
    s_set_prop _SURF_FIND "$find"
    s_write_f $ffile "$find"
    ;;
"_SURF_BMARK")
    uri=`s_get_prop _SURF_URI`
    s_write_f $bmarks "$uri"
    ;;
"_SURF_URI_RAW")
    uri=`echo $(s_get_prop _SURF_URI) | $dmenu -b -p "uri:"`
    s_set_prop _SURF_GO "$uri"
    ;;
"_SURF_URI")
    sel=`tac $bmarks 2> /dev/null | $dmenu -b -l 5 -p "go to:"`
    [ -z "$sel" ] && exit
    opt=$(echo $sel | cut -d ' ' -f 1)
    arg=$(echo $sel | cut -d ' ' -f 2-)
    save=0
    case "$opt" in
    "g") # duckduckgo
        uri="https://www.duckduckgo.com/?q=$arg"
        save=0
        ;;
    "gg") # google for it
        uri="https://www.google.com/search?q=$arg"
        save=0
        ;;
    "w") # wikipedia
        uri="http://wikipedia.org/wiki/$arg"
        save=0
        ;;
    "x") # delete
        sed -i "\|$arg|d" $bmarks
        exit;
        ;;
    *)
        uri="$sel"
        save=0
        ;;
    esac

    # only set the uri; don't write to file
    [ $save -eq 0 ] && s_set_prop _SURF_GO "$uri"
    # set the url and write exactly what the user inputed to the file
    [ $save -eq 1 ] && (s_set_prop _SURF_GO "$uri"; s_write_f $bmarks "$sel")
    # try to set the uri only if it is a success
    [ $save -eq 2 ] && s_set_write_proper_uri "$uri"
    ;;
*)
    echo Unknown xprop
    ;;
esac
