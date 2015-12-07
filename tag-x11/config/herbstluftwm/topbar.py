#!/usr/bin/python

import os, sys, select, datetime, subprocess, atexit

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

def output_of(cmd):
    return subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode('utf-8').strip()

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
        self.client = subprocess.Popen(['herbstclient', '--idle', 'tag_changed'], stdout=pipe)
        atexit.register(self.client.kill)
        self.tags = []
        hooks['tag_changed'] = self
    def update(self, line):
        self.tags = output_of(['herbstclient', 'tag_status']).split()
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
        df = output_of(self.dfcmd).split('\n')[1:]
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

class PulseAudio(Widget):
    icon_loud = ' \ue05d '
    icon_mute = ' \ue04f '
    def __init__(self, pipe, hooks):
        client = subprocess.Popen(['pactl', 'subscribe'], stdout=pipe)
        atexit.register(client.kill)
        self.volume = 0
        self.mute = False
        hooks["Event 'change' on sink"] = self
    def update(self, line):
        painfo = output_of(['pactl', 'info']).split('\n')
        look_for = None
        for l in painfo:
            if l.startswith('Default Sink:'):
                look_for = l.split(':')[1].strip()
                break
        in_sink = False
        look_for = 'Name: ' + look_for
        sink_list = output_of(['pactl', 'list', 'sinks']).split('\n')
        for l in sink_list:
            if not in_sink:
                if look_for in l:
                    in_sink = True
            else:
                if 'Mute:' in l:
                    if l.split(':')[1].strip() == 'yes':
                        self.mute = True
                    else:
                        self.mute = False
                elif 'Volume:' in l:
                    self.volume = int(l.split('/', 2)[1].strip()[:-1])
                    return
    def render(self):
        if self.mute:
            return fg(color['bad'], self.icon_mute) + '--'
        else:
            return fg(color['good'], self.icon_loud) + str(self.volume)

class Clock(Widget):
    def render(self):
        return '  ' + bg(color['lightbackground'], datetime.datetime.now().strftime('  %a %b %d  %H:%M  '))

class Wifi(Widget):
    icon = ' \ue048 '
    @staticmethod
    def available():
        return len(file_contents('/proc/net/wireless').split('\n')) >= 3
    def render(self):
        iw = output_of(['iwgetid']).split()
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

class MPD(Widget):
    icon_paused = ' \ue059 '
    icon_playing = ' \ue05c '
    audio_files = ['mp3', 'ogg', 'flac', 'mp4', 'm4a']
    @staticmethod
    def available():
        try:
            subprocess.run(['mpc'], check=True)
            return True
        except:
            return False
    def __init__(self, pipe, hooks):
        client = subprocess.Popen(['mpc', 'idleloop', 'player'], stdout=pipe)
        atexit.register(client.kill)
        self.song = ''
        self.status = 'stopped'
        hooks['player'] = self
    def update(self, line):
        status = output_of('mpc').split('\n')
        if len(status) < 3:
            self.song = ''
            self.status = 'stopped'
        else:
            self.song = status[0]
            if '.' in self.song[-5:] and self.song.rsplit('.', 1)[1].lower() in self.audio_files:
                self.song = self.song.rsplit('/', 1)[1]
            self.status = status[1].split(None, 1)[0][1:-1]
    def render(self):
        if self.status == 'playing':
            return self.icon_playing + fg(color['muted'], self.song)
        elif self.status == 'paused':
            return self.icon_paused + fg(color['muted'], self.song)
        return ''



widgets = ['%{l}', HLWM, MPD, '%{c}', '%{r}', Filesystems, Wifi, Battery, PulseAudio, Clock]

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
                lines = os.read(p, 4096).decode('utf-8').split('\n')
                for line in lines:
                    for first, hook in hooks.items():
                        if line.startswith(first):
                            updated = True
                            hook.update(line)
        else:
            updated = True
        # render
        if updated:
            print(''.join(w.render() for w in ws))
        sys.stdout.flush()
