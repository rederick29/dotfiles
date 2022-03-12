#!/bin/sh
grim -t png -g "$(slurp -d)" ~/Pictures/Screenshots/$(date +%d-%m-%Y_%H-%M-%S).png | wl-copy
