#!/bin/sh

IMG="/tmp/lockscreen.png"

# Screenshot current screen
scrot "$IMG"

# Blur + dim
convert "$IMG" -blur 0x8 -fill black -colorize 20% "$IMG"

# Lock using blurred screenshot
i3lock -i "$IMG" --nofork --no-unlock-indicator

# Clean up after unlock
rm -f "$IMG"