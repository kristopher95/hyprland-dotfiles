#!/usr/bin/env bash

IFS=',' read -r usage mem_used mem_total temp <<< "$(
    nvidia-smi \
        --query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu \
        --format=csv,noheader,nounits 2>/dev/null | head -n1
)"

if [[ -n "$usage" ]]; then
    echo "[GPU: ${usage}% | VRAM: ${mem_used}MB / ${mem_total}MB | ${temp}°C]"
else
    echo "[GPU: N/A]"
fi
