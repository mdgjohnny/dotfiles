#!/bin/bash
# ~/.config/i3/scripts/lock.sh
# Epic lock screen with blur effects and custom styling

# Create temp directory
tmpbg='/tmp/screen.png'

# Take screenshot
scrot "$tmpbg"

# Blur the screenshot (adjust blur strength as needed)
imagick "$tmpbg" -scale 10% -scale 1000% "$tmpbg"

# Optional: Add a semi-transparent overlay for dimming effect
imagick "$tmpbg" -fill black -colorize 25% "$tmpbg"

# Add your custom lock image overlay (create this image or find a cool one)
# imagick"$tmpbg" ~/.config/i3/lock-icon.png -gravity center -composite -matte "$tmpbg"

# Standard i3lock command (works with vanilla i3lock)
# i3lock -i "$tmpbg" -t -e -f

# Alternative static background version
# i3lock -i ~/Pictures/lockscreen.jpg -t -e -f

# Clean up
rm "$tmpbg"

# BONUS: If you want the fancy colors, install i3lock-color from AUR:
# yay -S i3lock-color
# Then uncomment this block and comment the simple version above:

i3lock \
--insidever-color=ffffff1c \
--ringver-color=ffffff00 \
--insidewrong-color=ffffff1c \
--ringwrong-color=ffffff00 \
--inside-color=ffffff1c \
--ring-color=ffffff3e \
--line-color=ffffff00 \
--separator-color=22222260 \
--verif-color=ffffff00 \
--wrong-color=ff000000 \
--time-color=ffffffff \
--date-color=ffffffff \
--layout-color=ffffff00 \
--keyhl-color=d23c3dff \
--bshl-color=d23c3dff \
--screen 1 \
--blur 5 \
--clock \
--indicator \
--time-str="%H:%M:%S" \
--date-str="%A, %m %Y" \
--keylayout 1 \
--image="$tmpbg" \
--tiling
