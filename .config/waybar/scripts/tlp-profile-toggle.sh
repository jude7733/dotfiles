#!/usr/bin/env bash

profiles=(power-saver balanced performance)

get_current() {
  tlpctl get 2>/dev/null
}

if [ "$1" = "set" ]; then
  current=$(get_current)
  [ -z "$current" ] && exit 0

  # find current index
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

icon=""
echo "{\"text\":\"$icon $current\",\"tooltip\":\"$current (click to switch)\",\"alt\":\"$current\",\"class\":\"$current\"}"
