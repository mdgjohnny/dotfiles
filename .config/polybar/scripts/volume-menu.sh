#!/bin/bash

# Volume control menu using rofi
choice=$(echo -e "🔊 +10%\n🔉 +5%\n🔈 -5%\n🔇 -10%\n🔇 Mute/Unmute\n🎛️ Open Mixer" | rofi -dmenu -p "Volume Control" -theme-str 'window {width: 300px;}')

case "$choice" in
    "🔊 +10%")
        pamixer -i 10
        ;;
    "🔉 +5%")
        pamixer -i 5
        ;;
    "🔈 -5%")
        pamixer -d 5
        ;;
    "🔇 -10%")
        pamixer -d 10
        ;;
    "🔇 Mute/Unmute")
        pamixer -t
        ;;
    "🎛️ Open Mixer")
        pavucontrol &
        ;;
esac
