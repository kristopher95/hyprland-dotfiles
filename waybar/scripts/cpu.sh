#!/usr/bin/env bash

read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
prev_total=$((user + nice + system + idle + iowait + irq + softirq + steal))
prev_idle=$((idle + iowait))

sleep 0.5

read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_all=$((idle + iowait))

diff_total=$((total - prev_total))
diff_idle=$((idle_all - prev_idle))

usage=$((100 * (diff_total - diff_idle) / diff_total))

echo "[CPU: ${usage}%]"
