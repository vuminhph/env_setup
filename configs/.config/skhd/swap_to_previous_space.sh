#!/bin/bash

# Get current and previous space IDs
current_space=$(yabai -m query --spaces --space | jq '.index')
previous_space=$((current_space - 1))

# Check if the previous space exists
if yabai -m query --spaces | jq --exit-status ".[] | select(.index == $previous_space)" >/dev/null; then
  current_windows=$(yabai -m query --windows --space $current_space | jq '.[].id')
  previous_windows=$(yabai -m query --windows --space $previous_space | jq '.[].id')

  # Move all windows from the current space to the previous space
  echo "$current_windows" | while read -r id; do
    yabai -m window $id --space $previous_space
  done

  # Move all windows from the previous space to the current space
  echo "$previous_windows" | while read -r id; do
    yabai -m window $id --space $current_space
  done

  # Focus on the previous space
  yabai -m space --focus $previous_space

  # Focus on the first window of the previous space
  current_window = $(yabai -m query --windows --window | jq '.id')
  yabai -m window $current_window --focus
else
  echo "No previous space found!"
  exit 1
fi
