#!/bin/bash

#Ignoring chromium in order to ignore discord. I use firefox as a browser.
playing_title=$(playerctl metadata --ignore-player=chromium --format "{{ title }}" | sed "s/'/ /g" | sed 's/\"/ /g')
playing_artist=$(playerctl metadata --ignore-player=chromium --format "{{ artist }}" | sed "s/'/ / g" | sed 's/\"/ /g')
playing_album=$(playerctl metadata --ignore-player=chromium --format "{{ album }}" | sed "s/'/ /g" | sed 's/\"/ /g')

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

echo '{"text":"'$formatted_status' '$playing_title'", "class": "custom-getplayerctl", "tooltip": "<b>Title: </b>'$playing_title'\n<b>Artist: </b>'$playing_artist'\n<b>Album: </b>'$playing_album'"}'

# No tooltip ver
#echo '{"text": "'$formatted_status' '$playing_title'", "class": "custom-getplayerctl"}'
