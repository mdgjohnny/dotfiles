#!/bin/bash

options="⏻ Shutdown\n⟲ Reboot\n⏾ Suspend\n⇥ Logout\n🔒 Lock"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme-str 'window {width: 200;} listview {lines: 5;}')

case "$chosen" in
    "⏻ Shutdown") systemctl poweroff ;;
    "⟲ Reboot") systemctl reboot ;;
    "⏾ Suspend") systemctl suspend ;;
    "⇥ Logout") i3-msg exit ;;
    "🔒 Lock") ~/.config/i3/scripts/lock.sh ;;
esac
