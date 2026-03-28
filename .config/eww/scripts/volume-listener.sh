get_volume() {
  volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

  if [[ "$volume" == *MUTED* ]]; then
    echo 0
  else
    awk '{print int($2 * 100)}' <<< "$volume"
  fi
}

get_volume

pactl subscribe | grep --line-buffered -E "Event 'change' on sink|Evento 'cambiar' en destino" | while IFS= read -r _; do
  get_volume
done
