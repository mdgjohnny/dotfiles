#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# Bar is the name set in the polybar config, so if you change it, you have to change it here too.

polybar bar

echo "Bars launched..."
