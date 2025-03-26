#!/bin/bash
echo "[🚀] Starting NovaLab container..."

dotnet /app/Novalab.Server/Novalab.Server.dll &

count=${WORKER_COUNT:-1}
for i in $(seq 1 $count); do
  echo "[🔧] Launching worker-$i"
  WORKER_ID="worker-$(printf "%02d" $i)" python3 /app/worker/worker.py &
done

wait
