#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@& 2>/dev/null
  fi
}


#run keepassxc
run ~/dotfile/config/scripts/background-changer
run ~/dotfile/config/scripts/idle.sh
run ~/dotfile/config/scripts/agsload.sh
#run copyq --start-server
run wl-paste --type text -watch cliphist store
run wl-paste --type image -watch cliphist store

run fcitx5 -d
run udiskie
#run waybar
run gBar bar 0
run dunst
run conky -c ~/.config/conky/wlconkyrc
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run blueman-applet
#run dbus-update-activation-environment --all

#run waybar
#run numlockx on
#run mako list
#run xfce4-power-manager
#run picom
#run slstatus
#run nm-applet  # network-manager-applet
#run mpd
#run xfce4-power-manager --no-daemon
#run blueman-applet
#run thunar --daemon
# sh ~/dotfile/config/scripts/lightsonplus/lightson+ 2>/dev/null
# xautolock -time 30 -locker slock 2>/dev/null
# swhks
# pkexec swhkd  # -c $HOME/.config/swhkd/swhkdrc &
# sh $HOME/.config/scripts/pkill_bc
# sh $HOME/.config/scripts/pkill_engine
