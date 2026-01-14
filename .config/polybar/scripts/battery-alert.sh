#!/bin/bash

# Battery Alert Script for Polybar

# Configuration
LOW_BATTERY_THRESHOLD=20
CRITICAL_BATTERY_THRESHOLD=10
LOCKFILE="/tmp/battery_alert_lock"

BATTERY_PATH="/sys/class/power_supply/BAT1"
if [ ! -d "$BATTERY_PATH" ]; then
    for bat in /sys/class/power_supply/BAT*; do
        if [ -d "$bat" ]; then
            BATTERY_PATH="$bat"
            break
        fi
    done
fi

if [ ! -d "$BATTERY_PATH" ]; then
    echo "No battery found"
    exit 1
fi

BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity" 2>/dev/null || echo "0")
BATTERY_STATUS=$(cat "$BATTERY_PATH/status" 2>/dev/null || echo "Unknown")

send_notification() {
    local level=$1
    local message=$2
    local urgency=$3
    
    if [ -f "$LOCKFILE" ]; then
        local last_alert=$(stat -c %Y "$LOCKFILE" 2>/dev/null || echo 0)
        local current_time=$(date +%s)
        local time_diff=$((current_time - last_alert))
        
        if [ $time_diff -lt 300 ]; then
            return
        fi
    fi
    
    # Send notification using notify-send
    notify-send \
        --urgency="$urgency" \
        --icon="battery-low" \
        --app-name="Battery Alert" \
        "Battery Warning" \
        "$message"
    
    # Also try dunstify if available (better notification daemon)
    if command -v dunstify &> /dev/null; then
        dunstify \
            -u "$urgency" \
            -i "battery-low" \
            -a "Battery Alert" \
            "Battery Warning" \
            "$message"
    fi
    
    # Update lockfile
    touch "$LOCKFILE"
}

# Check battery status and send alerts
if [ "$BATTERY_STATUS" = "Discharging" ]; then
    if [ "$BATTERY_LEVEL" -le "$CRITICAL_BATTERY_THRESHOLD" ]; then
        send_notification "$BATTERY_LEVEL" \
            "CRITICAL: Battery at ${BATTERY_LEVEL}%! Please charge immediately." \
            "critical"
        
    elif [ "$BATTERY_LEVEL" -le "$LOW_BATTERY_THRESHOLD" ]; then
        send_notification "$BATTERY_LEVEL" \
            "Low battery: ${BATTERY_LEVEL}% remaining. Consider charging soon." \
            "normal"
    fi
fi

if [ -f "$LOCKFILE" ]; then
    file_age=$(( $(date +%s) - $(stat -c %Y "$LOCKFILE") ))
    if [ $file_age -gt 3600 ]; then
        rm -f "$LOCKFILE"
    fi
fi

# Output for polybar (optional - can show battery status)
if [ "$BATTERY_STATUS" = "Discharging" ] && [ "$BATTERY_LEVEL" -le "$LOW_BATTERY_THRESHOLD" ]; then
    echo "%{F#e06c75}⚠%{F-}"
else
    echo ""
fi
