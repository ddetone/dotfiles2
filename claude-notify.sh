#!/bin/bash
# Play a notification sound (macOS or Linux with audio)
if [[ "$(uname)" == "Darwin" ]]; then
  afplay /System/Library/Sounds/Glass.aiff &
elif command -v paplay &>/dev/null; then
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga &
elif command -v aplay &>/dev/null; then
  aplay /usr/share/sounds/sound-icons/glass-water-1.wav &
fi
