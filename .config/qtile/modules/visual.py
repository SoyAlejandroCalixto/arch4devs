# --> This file contains everything that has to do with the visuals

from libqtile import layout, hook
from libqtile.config import Match, Screen

# set up your screens, if you have more than one screen, put as many screen() objects as needed in this list
screens = [
    Screen(
        wallpaper='~/.local/share/backgrounds/7.png',
        wallpaper_mode='stretch',
    )
]

# layouts config
layouts = [
    layout.Columns(border_width=0, margin=5, border_focus="#ffffff", border_normal="#ffffff")
]

# set up windows that spawn as floating windows, filtering by wm_class
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(wm_class="org.gnome.Characters"),
        Match(wm_class="gnome-system-monitor"),
    ]
)

# set some defaults for the widget
widget_defaults = {
    "font": "Inter",
    "fontsize": 12,
    "padding": 3,
}