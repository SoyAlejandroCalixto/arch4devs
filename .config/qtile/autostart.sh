#!/bin/sh
picom &
polybar leftbar &
polybar rightbar &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
