#!/bin/bash

wf-recorder -f $HOME/Videos/$(date -Is).mp4 &
notify-send '  Screen cap started. Screen recording...'
