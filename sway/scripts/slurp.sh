#!/bin/sh
selection=$(slurp -d)
grim -t png -g "$selection" ~/Pictures/Screenshots/$(date +%d-%m-%Y_%H-%M-%S).png
grim -t png -g "$selection" - | wl-copy -t image/png
