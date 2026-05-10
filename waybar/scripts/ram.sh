#!/usr/bin/env bash
total_kb=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
avail_kb=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
used_kb=$((total_kb - avail_kb))

used_gb=$(awk -v kb="$used_kb" 'BEGIN {printf "%.2f", kb/1024/1024}')
total_gb=$(awk -v kb="$total_kb" 'BEGIN {printf "%.0f", kb/1024/1024}')

echo "[RAM: ${used_gb}GB / ${total_gb}GB]"
