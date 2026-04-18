#!/bin/bash

sketchybar -m --set "$NAME" label="$(
  memory_pressure | grep "System-wide memory free percentage:" \
  | awk '{ printf("%.0f", 100-$5"%") }' \
  )%"
