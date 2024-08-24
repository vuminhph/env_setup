#!/bin/bash

# Get current and next space IDs
current_space=$(yabai -m query --spaces --space | jq '.index')
next_space=$((current_space + 1))

# Check if the next space exists
if yabai -m query --spaces | jq --exit-status ".[] | select(.index == $next_space)" >/dev/null; then
  current_windows=$(yabai -m query --windows --space $current_space | jq '.[].id')
  next_windows=$(yabai -m query --windows --space $next_space | jq '.[].id')

  # Move all windows from the current space to the next space
  echo "$current_windows" | while read -r id; do
    yabai -m window $id --space $next_space
  done

  # Move all windows from the next space to the current space
  echo "$next_windows" | while read -r id; do
    yabai -m window $id --space $current_space
  done

  # Focus on the next space
  yabai -m space --focus $next_space

  # Focus on the first window of the next space
  current_window = $(yabai -m query --windows --window | jq '.id')
  yabai -m window $current_window --focus
else
  echo "No next space found!"
  exit 1
fi
