from sys import stdout
import json
import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib

persistent = [] # List at the top level so that the Python garbage collector does not delete the function variables that I put here

def metadata_changed(player, metadata, *args):
    title = player.get_title()

    out = {}
    if len(title) > 30:
        out = { "text": (title[:30] + '...'), 'class': 'custom-spotify', 'alt': 'spotify' }
    else:
        out = { "text": title, 'class': 'custom-spotify', 'alt': 'spotify' }

    stdout.write('\n' + json.dumps(out) + '\n')
    stdout.flush()

def player_appeared(player_manager, player_name):
    if player_name.name == 'spotify':
        player = Playerctl.Player.new_from_name(player_name)
        persistent.append(player) # so that the garbage collector does not delete the variable with all its events

        title = player.get_title()

        out = {}
        if len(title) > 30:
            out = { "text": (title[:30] + '...'), 'class': 'custom-spotify', 'alt': 'spotify' }
        else:
            out = { "text": title, 'class': 'custom-spotify', 'alt': 'spotify' }

        stdout.write('\n' + json.dumps(out) + '\n')
        stdout.flush()
        player.connect('metadata', metadata_changed)

def player_vanished(player_manager, player_name):
    stdout.write('\n')
    stdout.flush()

mgr = Playerctl.PlayerManager()
mgr.connect('name-appeared', player_appeared)
mgr.connect('name-vanished', player_vanished)

loop = GLib.MainLoop()
loop.run()

