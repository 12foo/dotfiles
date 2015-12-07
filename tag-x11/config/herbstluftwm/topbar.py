#!/usr/bin/python

import os, sys, select, datetime, subprocess

color = {
    "foreground": "#ffffff",
    "background": "#282f3a",
    "lightbackground": "#414a59",
    "primary": "#5294e2",
    "good": "#91cc57",
    "bad": "#cc575d",
    "muted": "#999999",
}

def fg(color, text):
    return '%{F' + color + '}' + text + '%{F-}'

def bg(color, text):
    return '%{B' + color + '}' + text + '%{B-}'

def file_contents(f):
    try:
        ff = open(f, 'r')
        c = ff.read().strip()
        ff.close()
        return c
    except:
        return None

class Widget(object):
    @staticmethod
    def available():
        """Determines if widget is available/makes sense on this system."""
        return True
    def __init__(self, pipe, hooks):
        """Initialize widget. The widget may spawn a subprocess and feed its stdout
        into pipe. The main loop runs through all lines received on all widget pipes
        and calls hooks based on the first word in a line. If

        hooks["my_trigger"] = self

        is set, this widget's update function will be called if the main loop sees
        a line starting with 'my_trigger'."""
        pass
    def update(self, line):
        """Update widget's internal state based on data received via the main loop."""
        pass
    def render(self):
        """Render the widget."""
        return ''

class Text(Widget):
    def __init__(self, text):
        super(Widget, self)
        self.text = text
    def render(self):
        return self.text

class HLWM(Widget):
    tagicons = ['\ue00e', '\ue072', '\ue1ce', '\ue1a0']

    def __init__(self, pipe, hooks):
        self.client = subprocess.Popen(['herbstclient', '--idle'], stdout=pipe)
        self.tags = []
        hooks['tag_changed'] = self
    def update(self, line):
        tp = subprocess.run(['herbstclient', 'tag_status'], stdout=subprocess.PIPE)
        self.tags = tp.stdout.decode('utf-8').strip().split()
    def render(self):
        out = '%{T2}'
        empty = ' \ue0e6 '
        for i, t in enumerate(self.tags):
            full = ' ' + self.tagicons[i] + ' ' if len(self.tagicons) > i else ' \ue056 '
            if t[0] == '#':
                out += bg(color['lightbackground'], fg('-', '%{+u}' + full + '%{-u}'))
            elif t[0] == '+':
                out += fg(color['primary'], full)
            elif t[0] == ':':
                out += fg(color['muted'], full)
            elif t[0] == '.':
                out += fg(color['muted'], empty)
            elif t[0] == '!':
                out += fg(color['bad'], full)
        out += '%{T1}'
        return out

class Filesystems(Widget):
    dfcmd = ['df', '-h', '-x', 'tmpfs', '-x', 'devtmpfs', '--output=target,avail']
    icon = fg(color['good'], ' %{T2}\ue1e1%{T1} ')
    def render(self):
        df = subprocess.run(self.dfcmd, stdout=subprocess.PIPE)
        df = df.stdout.decode('utf-8').strip().split('\n')[1:]
        fs = ((f[0], f[1]) for f in (f.strip().split() for f in df) if f[0] != '/boot')
        return self.icon + fg(color['muted'], ' | ').join('%s %s' % (f[0], fg(color['muted'], f[1])) for f in fs)

class Battery(Widget):
    @staticmethod
    def available():
        return file_contents('/sys/class/power_supply/BAT0/present') == '1'
    def render(self):
        try:
            charge = int(file_contents('/sys/class/power_supply/BAT0/capacity'))
        except:
            charge = 0
        c = color['bad'] if charge < 30 else color['good']
        if file_contents('/sys/class/power_supply/BAT0/status') != 'Discharging':
            icon = ' %{T2}\ue239%{T1} '
        else:
            icon = ' %{T2}\ue236%{T1} '
        return fg(c, icon) + str(charge)

class Clock(Widget):
    def render(self):
        return '  ' + bg(color['lightbackground'], datetime.datetime.now().strftime('  %a %b %d  %H:%M  '))

class Wifi(Widget):
    icon = ' \ue048 '
    def render(self):
        iw = subprocess.run(['iwgetid'], stdout=subprocess.PIPE).stdout.decode('utf-8').strip().split()
        profile = iw[1]
        strength = 0.0
        if 'ESSID' not in profile:
            profile = fg(color['muted'], 'disabled')
        else:
            profile = profile[7:-1]
            for line in file_contents('/proc/net/wireless').split('\n')[2:]:
                cols = line.split()
                if cols[0][:-1] == iw[0]:
                    strength = float(cols[2])
                    break
        c = color['good'] if strength > 40 else color['bad']
        return fg(c, self.icon) + profile + ' ' + fg(color['muted'], str(int(strength)))

widgets = ['%{l}', HLWM, '%{c}', '%{r}', Filesystems, Wifi, Battery, Clock]

if __name__ == '__main__':
    sread, swrite = os.pipe()
    hooks = {}

    ws = []
    for wc in widgets:
        if type(wc) is str:
            w = Text(wc)
            ws.append(w)
        elif wc.available():
            w = wc(swrite, hooks)
            w.update(None)
            ws.append(w)

    print(''.join(w.render() for w in ws))
    sys.stdout.flush()

    while True:
        ready, _, _ = select.select([sread], [], [], 5)
        # poll / update widgets (rerender only on updates that match hooks,
        # or on regular timeouts)
        updated = False
        if len(ready) > 0:
            for p in ready:
                line = os.read(p, 4096)
                line = line.decode('utf-8').strip()
                first = line.split(None, 1)[0]
                if first in hooks:
                    updated = True
                    hooks[first].update(line)
        else:
            updated = True
        # render
        if updated:
            print(''.join(w.render() for w in ws))
        sys.stdout.flush()
