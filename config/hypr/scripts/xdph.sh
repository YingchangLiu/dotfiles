#!/bin/bash
sleep 1
killall -e xdg-desktop-portal-hyprland 2>/dev/null
killall -e xdg-desktop-portal-wlr 2>/dev/null
killall xdg-desktop-portal 2>/dev/null
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
