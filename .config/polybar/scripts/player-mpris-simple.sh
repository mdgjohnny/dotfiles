#!/bin/sh

# Max length for song info (adjust as needed)
MAX_LEN=40

player_status=$(playerctl status 2> /dev/null)

truncate() {
    str="$1"
    if [ ${#str} -gt $MAX_LEN ]; then
        echo "${str:0:$((MAX_LEN-1))}…"
    else
        echo "$str"
    fi
}

if [ "$player_status" = "Playing" ]; then
    info="$(playerctl metadata artist) - $(playerctl metadata title)"
    echo "▶ $(truncate "$info")"
elif [ "$player_status" = "Paused" ]; then
    info="$(playerctl metadata artist) - $(playerctl metadata title)"
    echo "⏸ $(truncate "$info")"
fi

