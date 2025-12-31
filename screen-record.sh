#!/bin/bash

# Define filename
FILENAME=~/Videos/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4

# Check if recording is already in progress
if pgrep -x "wf-recorder" > /dev/null; then
    pkill -SIGINT wf-recorder
    notify-send "Recording Stopped" "Saved to ~/Videos"
    exit 0
fi

# --- AUTOMATION MAGIC ---
# 1. Get the name of your default speaker (sink)
# 2. Add '.monitor' to it (this tells Linux to record OUTPUT, not Input)
AUDIO_SOURCE=$(pactl get-default-sink).monitor

if [ "$1" == "region" ]; then
    # Region Mode
    GEOMETRY=$(slurp)
    if [ -z "$GEOMETRY" ]; then exit 0; fi

    notify-send "Region Recording Started" "With System Audio"
    # We explicitly tell it to use the source we found above
    wf-recorder -g "$GEOMETRY" --audio="$AUDIO_SOURCE" -f $FILENAME
else
    # Full Screen Mode
    notify-send "Full Screen Recording Started" "With System Audio"
    wf-recorder --audio="$AUDIO_SOURCE" -f $FILENAME
fi
