#!/bin/bash

setxkbmap br -model pc105

xmodmap -e "keycode 199 = Control_L NoSymbol Control_L"
xmodmap -e "keycode 105 = Control_R NoSymbol Control_R"

xmodmap -e "add control = Control_L Control_R"

echo "Keyboard layout and ctrl key mappings restored"
