#!/bin/bash
# Rotate Kitty background wallpaper from a folder
# Usage: ./rotate-wallpaper.sh [wallpaper_dir] [interval_seconds]
#
# Examples:
#   ./rotate-wallpaper.sh ~/Pictures/wallpapers 300   # rotate every 5 min
#   ./rotate-wallpaper.sh                              # one-time random pick

WALLPAPER_DIR="${1:-$HOME/Pictures/wallpapers}"
INTERVAL="${2:-0}"  # 0 = single change, >0 = loop with interval

if [[ ! -d "$WALLPAPER_DIR" ]]; then
    echo "Error: Directory '$WALLPAPER_DIR' does not exist"
    exit 1
fi

set_random_wallpaper() {
    local img
    img=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

    if [[ -n "$img" ]]; then
        kitty @ --to unix:/tmp/kitty set-background-image "$img"
        echo "Set wallpaper: $img"
    else
        echo "No images found in $WALLPAPER_DIR"
        exit 1
    fi
}

# Single change or loop
if [[ "$INTERVAL" -eq 0 ]]; then
    set_random_wallpaper
else
    echo "Rotating wallpapers every ${INTERVAL}s from $WALLPAPER_DIR"
    while true; do
        set_random_wallpaper
        sleep "$INTERVAL"
    done
fi
