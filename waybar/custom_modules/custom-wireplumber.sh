#!/bin/bash

wpctl_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
fp_volume=$(echo $wpctl_volume | sed -e 's/Volume: //' -e 's/ \[MUTED\]//')
volume=$(bc -l <<< "scale=0;$fp_volume * 100 / 1")

if [[ $wpctl_volume == *"MUTED"* ]]; then
    echo "MUTED"
else
    if [[ $volume -gt 50 ]]; then
        echo " $volume%"
    elif [[ $volume -gt 25 ]]; then
        echo " $volume%"
    elif [[ $volume -ge 0 ]]; then
        echo " $volume%"
    fi
fi
