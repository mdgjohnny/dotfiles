#!/bin/bash

# Battery Alert Script for Polybar

# Configuration
LOW_BATTERY_THRESHOLD=20
CRITICAL_BATTERY_THRESHOLD=10
LOCKFILE="/tmp/battery_alert_lock"

# Get battery info
BATTERY_PATH="/sys/class/power_supply/BAT1"
# If BAT0 doesn't exist, try BAT1 or other common names
if [ ! -d "$BATTERY_PATH" ]; then
    for bat in /sys/class/power_supply/BAT*; do
        if [ -d "$bat" ]; then
            BATTERY_PATH="$bat"
            break
        fi
    done
fi

# Check if battery exists
if [ ! -d "$BATTERY_PATH" ]; then
    echo "No battery found"
    exit 1
fi

# Get battery percentage and status
BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity" 2>/dev/null || echo "0")
BATTERY_STATUS=$(cat "$BATTERY_PATH/status" 2>/dev/null || echo "Unknown")

# Function to send notification
send_notification() {
    local level=$1
    local message=$2
    local urgency=$3
    
    # Avoid spam notifications
    if [ -f "$LOCKFILE" ]; then
        local last_alert=$(stat -c %Y "$LOCKFILE" 2>/dev/null || echo 0)
        local current_time=$(date +%s)
        local time_diff=$((current_time - last_alert))
        
        # Don't send notification if less than 5 minutes have passed
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
        
        # Optional: Play warning sound
        # if command -v paplay &> /dev/null; then
        #     paplay /usr/share/sounds/alsa/Front_Left.wav 2>/dev/null &
        # fi
        
    elif [ "$BATTERY_LEVEL" -le "$LOW_BATTERY_THRESHOLD" ]; then
        send_notification "$BATTERY_LEVEL" \
            "Low battery: ${BATTERY_LEVEL}% remaining. Consider charging soon." \
            "normal"
    fi
fi

# Clean up old lockfile (older than 1 hour)
if [ -f "$LOCKFILE" ]; then
    local file_age=$(( $(date +%s) - $(stat -c %Y "$LOCKFILE") ))
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
