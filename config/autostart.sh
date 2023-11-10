#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@& 2>/dev/null
  fi
}


run keepassxc
run ~/dotfile/config/bin/background-changer
run ~/dotfile/config/bin/idle.sh
run copyq --start-server
run fcitx5 -d
run udiskie
run waybar
run dunst
run conky -c ~/.config/conky/wlconkyrc
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
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
# sh ~/dotfile/config/bin/lightsonplus/lightson+ 2>/dev/null
# xautolock -time 30 -locker slock 2>/dev/null
# swhks
# pkexec swhkd  # -c $HOME/.config/swhkd/swhkdrc &
# sh $HOME/.config/bin/pkill_bc
# sh $HOME/.config/bin/pkill_engine
