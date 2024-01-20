#!/usr/bin/env bash

# This script helps me to take screenshots and record my desktop.
# Dependencies: wofi, wf-recorder, slurp, grim 

declare -a options=(
"Record screencast"
"Stop screencast"
"Take screenshot"
)

choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -theme $HOME/.config/rofi/themes/rounded-blue-dark.rasi -i -p 'Choose script:' 2>/dev/null )

if [ "$choice" = "Take screenshot" ]; then 
    geometry=$(slurp)
    notify-send "Screenshot in 3 seconds..."
    rm -rf $HOME/screen.png
    sleep 3
    grim -g "$geometry" - > $HOME/screen.png
    wl-copy $HOME/screen.png -t image/png
    notify-send "Screenshot taken!"
    read -r W H <<< $(identify -format "%w %h\n" ~/screen.png)
    if [ "$W" -gt "300" ] || [ "$H" -gt "300" ]; then
        pqiv ~/screen.png -z 0.45 &
    else 
        pqiv ~/screen.png &
    fi 
    sleep 3
    pkill pqiv 
elif [ "$choice" = "Record screencast" ]; then
    geometry=$(slurp)
    if [ $? -ne 0 ]; then
        echo "Selection cancelled"
        exit 1
    fi
    notify-send "Screen recording in 3 seconds..."
    sleep 3
    notify-send "Screen recording started"
    wf-recorder -g "$geometry" -f ~/Videos/recording_$(date +"%Y-%m-%d_%H:%M:%S.mp4") &
elif [ "$choice" = "Stop screencast" ]; then
    pkill -SIGINT wf-recorder
    notify-send "Screen recording saved to ~/recording.mkv"
else 
    exit 1
fi