killall swaybg
swaybg -i $(find Pictures/Wallpapers/. -type f | shuf -n1) -m fill &

killall dunst
dunst &
blueman-applet &
killall waybar
waybar &
killall polkit-gnome-authentication-agent-1
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
killall nm-applet
nm-applet --indicator &

# River will send the process group of the init executable SIGTERM on exit.
riverctl default-layout rivertile &
exec rivertile -main-ratio 0.5 -view-padding 2 -outer-padding 2 &
for pad in $(riverctl list-inputs | grep -i touchpad )
do
  riverctl input $pad events enabled
  riverctl input $pad tap enabled
done
