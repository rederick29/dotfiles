#!/bin/bash

raw_clock=$(cat /sys/class/drm/card0/device/pp_dpm_sclk | egrep -o '[0-9]{0,4}Mhz \W' | sed "s/Mhz \*//")
#clock=$(echo "scale=1;$raw_clock/1000" | bc | sed -e 's/^-\./-0./' -e 's/^\./0./')
clock=$(echo $raw_clock)

raw_temp=$(cat /sys/class/drm/card0/device/hwmon/hwmon2/temp1_input)
temperature=$(($raw_temp/1000))

busypercent=$(cat /sys/class/hwmon/hwmon2/device/gpu_busy_percent)

deviceinfo=$(glxinfo -B | grep 'Device:' | sed 's/^.*: //')
driverinfo=$(glxinfo -B | grep "OpenGL version")


echo '{"text": "'$clock' MHz | '$temperature'°C | '$busypercent'", "class": "custom-gpu", "tooltip": "<b>'$deviceinfo'</b>\n'$driverinfo'"}'
