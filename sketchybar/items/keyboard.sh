#!/bin/bash


sketchybar --add item keyboard right \
           --set keyboard \
             icon=􀇳 \
             script="$PLUGIN_DIR/keyboard.sh" \
           --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
           --subscribe keyboard keyboard_change
