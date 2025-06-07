#!/bin/bash
touchpad_id=$(xinput list | grep -i touchpad | grep -o 'id=[0-9]*' | cut -d'=' -f2)
state=$(xinput list-props $touchpad_id | grep "Device Enabled" | cut -f3)
if [ $state -eq 1 ]; then
    xinput disable $touchpad_id
    notify-send 'Touchpad DISABLED'
else
    xinput enable $touchpad_id
    notify-send 'Touchpad ENABLED'
fi
