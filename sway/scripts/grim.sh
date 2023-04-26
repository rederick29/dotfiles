#!/bin/sh
grim -t png ~/Pictures/Screenshots/$(date +%d-%m-%Y_%H-%M-%S).png
grim -t png - | wl-copy -t image/png
