# --> This file contains everything that has to do with triggers

from libqtile.config import Key, Drag, Click
from libqtile.lazy import lazy
from .consts import groups, default_terminal

super = "mod4"
alt = "mod1"
left_click = 'Button1'
wheel_click = 'Button2'
right_click = 'Button3'

# docs: https://docs.qtile.org/en/latest/manual/config/lazy.html

keys_binds = [
    # move focus window
    Key([super, "control"], "j", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([super, "control"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([super, "control"], "k", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([super, "control"], "i", lazy.layout.shuffle_up(), desc="Move window up"),

    # change focus window size
    Key([super], "j", lazy.layout.grow_left()),
    Key([super], "l", lazy.layout.grow_right()),
    Key([super], "k", lazy.layout.grow_down()),
    Key([super], "i", lazy.layout.grow_up()),
    Key([super], "r", lazy.layout.normalize()),  # reset windows size

    # manage windows
    Key([super], "w", lazy.window.kill()),
    Key([super], "f", lazy.window.toggle_fullscreen()),
    Key([super], "t", lazy.window.toggle_floating()),  # toggle floating window
    Key([alt], "space", lazy.layout.next()),  # move focus to next windows

    # utils (screenshots, volume, emotes...)
    Key([super], "p", lazy.spawn('amixer -c 0 sset Master 1+ unmute')),
    Key([super], "o", lazy.spawn('amixer -c 0 sset Master 1- unmute')),
    Key([super], "e", lazy.spawn('gnome-characters')),
    Key([], "Print", lazy.spawn('flameshot gui')),
    Key([super], "space", lazy.spawn('rofi -show drun')),
    Key([super], "v", lazy.spawn('clipton')),

    # spawn apps
    Key([super, alt], "b", lazy.spawn('brave')),
    Key([super, alt], "c", lazy.spawn('code')),
    Key([super, alt], "d", lazy.spawn('discord')),
    Key([super], "Return", lazy.spawn(default_terminal)),
]

# super + 1-9 --> switch group
for group in groups:
    keys_binds.extend(
        [
            Key([super], group.name, lazy.group[group.name].toscreen()),

            # super + alt + 1-9 = switch group and move focused window to group
            Key([super, alt], group.name, lazy.window.togroup(
                group.name, switch_group=True)),

            # or use this one if you prefer not to change the group when moving the window

            # Key([super, alt], group.name, lazy.window.togroup(group.name)),
        ]
    )

drag_binds = [
    Drag([super], left_click, lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([super], right_click, lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
]

click_binds = [
    Click([super], wheel_click, lazy.window.bring_to_front()),
]
