#!/bin/bash
swayidle -w \
	timeout 1800 '~/.config/bin/wayland_session_lock' \
	timeout 2100 'hyprctl dispatch dpms off eDP-1'\
    timeout 2700 'systemctl suspend' \
	resume 'hyprctl dispatch dpms on eDP-1'\
	before-sleep '~/.config/bin/wayland_session_lock' \
	lock '~/.config/bin/wayland_session_lock' 2>/dev/null
