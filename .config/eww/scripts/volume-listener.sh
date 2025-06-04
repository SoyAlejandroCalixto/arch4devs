wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'

# Listen for volume changes and return the current volume percentage.
pactl subscribe | grep --line-buffered "Event 'change' on sink" | while IFS= read -r _; do
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if echo "$volume" | grep -q "MUTED"; then
        echo 0
    else
        echo "$volume" | awk '{print int($2 * 100)}'
    fi
done
