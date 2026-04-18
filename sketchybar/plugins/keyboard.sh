#!/bin/bash

LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev)"

# specify short layouts individually.
case "$LAYOUT" in
    "\"USInternational-PC\"") SHORT_LAYOUT="INT";;
    "\"U.S.\"") SHORT_LAYOUT="US";;
esac

sketchybar --set keyboard label="$SHORT_LAYOUT"
