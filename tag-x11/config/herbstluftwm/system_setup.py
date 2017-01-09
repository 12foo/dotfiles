#!/usr/bin/python

import os, sys, subprocess, socket, collections

# default keyboard layout (either 'layout1,layout2/variant' or 'model layout,layout/variant')
defkb = 'de/nodeadkeys,us'

# default keyboard options
kbopt = ['-option', 'grp:shifts_toggle', '-option', 'compose:caps']

# map of hostnames to available modes
# (mode_name, active_screens, keyboard_layout)
# an active screen can be 'VGA1' for max resolution, or 'VGA1 1280x800' for
# forced resolution
modes = {
    'tacito': [
        ('laptop', ['LVDS-1'], 'thinkpad de/nodeadkeys,us'),
        ('desk-vga', ['VGA-1'], defkb),
        ('desk-hdmi', ['HDMI-1'], defkb),
        ('present', ['LVDS-1', 'VGA-1'], 'thinkpad de/nodeadkeys,us'),
    ],
    'bison': [
        ('default', ['DVI-D-0'], defkb),
        ('tv-2nd', ['DVI-D-0', 'HDMI-0 1920x1080'], defkb),
    ],
}

# edit this function to autoselect specific modes based on type and
# availability of monitors as well as hostname
def auto_mode(hostname, monitors):
    if hostname not in modes:
        return None
    if hostname == 'tacito':
        if 'HDMI1' in monitors:
            return 'desk-hdmi'
        elif 'VGA-1' in monitors:
            return 'desk-vga'
        else:
            return 'laptop'
    else:
        return modes[hostname][0][0]

# you probably don't need to edit below

def get_mode(hostname, mode):
    if hostname not in modes:
        return None
    else:
        for m in modes[hostname]:
            if m[0] == mode:
                return m
        return None

def set_xrandr(mode, monitors):
    xr = ['xrandr']
    remaining = list(monitors.keys())
    main = None
    for i, m in enumerate(mode):
        if ' ' in m:
            output, geom = m.split(None, 1)
        else:
            output, geom = m, monitors[m]
        xr.extend(['--output', output, '--mode', geom])
        if i > 0:
            xr.extend(['--right-of', main])
        else:
            main = output
        remaining.remove(output)
    for r in remaining:
        xr.extend(['--output', r, '--off'])
    subprocess.run(xr)

def set_keyboard(kb):
    sx = ['setxkbmap'] + kbopt
    if ' ' in kb:
        model, layouts = kb.split(None, 1)
        sx.extend(['-model', model])
    else:
        layouts = kb
    layouts, _, variants = zip(*(l.partition('/') for l in layouts.split(',')))
    sx.extend(['-layout', ','.join(layouts)])
    if len(variants) > 0:
        sx.extend(['-variant', ','.join(variants)])
    subprocess.run(sx)

def set_wm(mode, monitors):
    rects = []
    xval = 0
    for m in mode:
        if ' ' in m:
            output, geom = m.split(None, 1)
            rects.append('%s+%d+0' % (geom, xval))
            xval += int(geom.split('x', 1)[0])
        else:
            rects.append('%s+%d+0' % (monitors[m], xval))
            xval += int(monitors[m].split('x', 1)[0])
    hc = ['herbstclient', 'set_monitors'] + rects
    subprocess.run(hc)

def apply_mode(mode, monitors):
    set_xrandr(mode[1], monitors)
    set_keyboard(mode[2])
    set_wm(mode[1], monitors)

def detect_monitors():
    xrandr = subprocess.run(['xrandr'], stdout=subprocess.PIPE).stdout.decode('utf-8').strip()
    monitors = {}
    catchnext = False
    output = None
    for line in xrandr.split('\n'):
        if ' connected ' in line:
            output, _ = line.split(None, 1)
            catchnext = True
        elif catchnext and output is not None:
            geom, _ = line.split(None, 1)
            monitors[output] = geom
            output = None
            catchnext = False
    return monitors

def detect_hostname():
    return socket.gethostname()

def help():
    print('Unknown command. Try: auto, list, set [name].')

if __name__ == '__main__':
    if len(sys.argv) < 2:
        help()
    else:
        host = detect_hostname()
        monitors = detect_monitors()
        if sys.argv[1] == 'auto':
            automode = auto_mode(host, monitors)
            if automode is None:
                print('Unable to autodetect best mode.')
            else:
                apply_mode(get_mode(host, automode), monitors)
        elif sys.argv[1] == 'list':
            if host not in modes:
                print('Unknown hostname. No modes available.')
            else:
                print('\n'.join(m[0] for m in modes[host]))
        elif sys.argv[1] == 'set':
            if len(sys.argv) > 2 and sys.argv[2] != '':
                mode = get_mode(host, sys.argv[2])
                if mode is None:
                    print('Invalid mode. Try list.')
                else:
                    apply_mode(mode, monitors)
        else:
            help()
