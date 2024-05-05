# --> This file is the central file of the WM. This is where all the information set in other scripts is used to give all the information to the WM to run with what this script tells it to do.

from libqtile import hook
import os
import subprocess
import modules.consts as consts
from modules.binds import keys_binds, drag_binds, click_binds
import modules.visual as visual

wmname = "ChristIsKing"

# run this script on startup
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

# connects the data you set in other modules
keys = keys_binds
mouse = drag_binds + click_binds
layouts = visual.layouts
screens = visual.screens
floating_layout = visual.floating_layout
groups = consts.groups

# set some defaults for the widget
widget_defaults = visual.widget_defaults.copy()
extension_defaults = widget_defaults

# some properties
dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None