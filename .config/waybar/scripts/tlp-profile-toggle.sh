#!/usr/bin/env bash

profiles=(power-saver balanced performance)

get_current() {
  tlpctl get 2>/dev/null
}

get_icon() {
  case "$1" in
  power-saver) echo " 󰾆 " ;;
  balanced) echo " 󰾅 " ;;
  performance) echo " 󰓅 " ;;
  *) echo "" ;;
  esac
}

if [ "$1" = "set" ]; then
  current=$(get_current)
  [ -z "$current" ] && exit 0

  idx=-1
  for i in "${!profiles[@]}"; do
    if [ "${profiles[$i]}" = "$current" ]; then
      idx=$i
      break
    fi
  done
  [ "$idx" -lt 0 ] && idx=0

  next_idx=$(((idx + 1) % ${#profiles[@]}))
  next="${profiles[$next_idx]}"

  tlpctl set "$next"

  # wait until the new profile is active
  for _ in {1..10}; do
    sleep 0.1
    new=$(get_current)
    if [ "$new" = "$next" ]; then
      break
    fi
  done

  exit 0
fi

current=$(get_current)
if [ -z "$current" ]; then
  echo '{"text":"N/A","tooltip":"no tlpctl","alt":"none","class":"none"}'
  exit 0
fi

icon=$(get_icon "$current")
text="$icon"

echo "{\"text\":\"$text\",\"tooltip\":\"$current (click to switch)\",\"alt\":\"$current\",\"class\":\"$current\"}"
