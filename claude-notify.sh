#!/bin/bash
# Notification when Claude finishes
if [[ "$(uname)" == "Darwin" ]]; then
  # Local Mac: play sound directly
  afplay /System/Library/Sounds/Glass.aiff &
else
  # Remote (e.g. SSH via VS Code): use terminal bell
  # VS Code forwards this to the local machine as a notification
  printf '\a'
fi
