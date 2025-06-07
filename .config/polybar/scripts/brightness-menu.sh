#!/bin/bash

# Debug notification
notify-send "Brightness Script" "Script is running..."

# Brightness control menu using rofi
choice=$(echo -e "☀️ +20%\n🔆 +10%\n🔅 -10%\n🌑 -20%\n🌞 Max (100%)\n🌙 Min (5%)" | rofi -dmenu -p "Brightness Control" -theme-str 'window {width: 300px;}')

case "$choice" in
    "☀️ +20%")
        brightnessctl set +20%
        notify-send "Brightness" "Increased by 20%"
        ;;
    "🔆 +10%")
        brightnessctl set +10%
        notify-send "Brightness" "Increased by 10%"
        ;;
    "🔅 -10%")
        brightnessctl set 10%-
        notify-send "Brightness" "Decreased by 10%"
        ;;
    "🌑 -20%")
        brightnessctl set 20%-
        notify-send "Brightness" "Decreased by 20%"
        ;;
    "🌞 Max (100%)")
        brightnessctl set 100%
        notify-send "Brightness" "Set to maximum"
        ;;
    "🌙 Min (5%)")
        brightnessctl set 5%
        notify-send "Brightness" "Set to minimum"
        ;;
esac
