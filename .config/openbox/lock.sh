#!/bin/sh

IMG="/tmp/lockscreen.png"

# Screenshot current screen
scrot "$IMG"

# Blur + dim
convert "$IMG" \
  -blur 0x8 \
  -fill black -colorize 20% \
  -gravity center \
  -fill white \
  -font DejaVu-Sans \
  -pointsize 72 \
  -annotate +0-20 "$(date '+%H:%M')" \
  -pointsize 24 \
  -fill "#dddddd" \
  -annotate +0+40 "$(date '+%A, %d %B')" \
  "$IMG"

# Lock using blurred screenshot
i3lock -i "$IMG" --nofork --no-unlock-indicator

# Clean up after unlock
rm -f "$IMG"