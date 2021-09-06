#!/bin/bash

playing_title=$(playerctl metadata --ignore-player=chromium --format "{{ title }}")
playing_artist=$(playerctl metadata --ignore-player=chromium --format "{{ artist }}")

status=$(playerctl metadata --format "{{ uc(status) }}")

if [ $status == "PLAYING" ]
then
	formatted_status=""
elif [ $status == "PAUSED" ]
then
	formatted_status=""
fi

#The following commands don't work as expected on my system for some reason. weird.
#song_length=$(playerctl metadata --format "{{ duration(mpris:length) }}")
#current_position=$(playerctl metadata --format "{{ duration(position) }}")
#time_remaining=$(playerctl metadata --format "{{ duration(mpris:length - position) }}")

echo '{"text": "'$formatted_status' '$playing_title'", "class": "custom-getplayerctl", "tooltip": "<b>Title: </b>'$playing_title'\n<b>Artist: </b>'$playing_artist'"}'

# No tooltip ver
#echo '{"text": "'$formatted_status' '$playing_title'", "class": "custom-getplayerctl"}'
