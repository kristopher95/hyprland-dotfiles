#!/usr/bin/env bash

mem_total_kib="$(awk '/MemTotal:/ {print $2}' /proc/meminfo)"
mem_available_kib="$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)"
mem_used_kib=$((mem_total_kib - mem_available_kib))

mem_used_gib="$(awk -v kib="$mem_used_kib" 'BEGIN { printf "%.1f", kib / 1024 / 1024 }')"

echo "[R: ${mem_used_gib}G]"
