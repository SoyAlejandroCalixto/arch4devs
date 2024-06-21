#!/bin/sh
picom &
polybar leftbar &
clipton watcher &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
