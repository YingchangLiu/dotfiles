#!/bin/bash
geometry=$(slurp)
if [ $? -ne 0 ]; then
    echo "Selection cancelled"
    exit 1
fi
wf-recorder -g "$(geometry)" -f ~/Videos/recording_$(date +"%Y-%m-%d_%H:%M:%S.mp4") &
notify-send '  Screen cap started. Screen recording...'
