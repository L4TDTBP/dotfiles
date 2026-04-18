#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.color=0xFFFDE311
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME label.color=0xFFFFFFFF
    sketchybar --set $NAME background.drawing=off
fi
