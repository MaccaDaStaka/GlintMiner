#!/usr/bin/env bash
# HiveOS stats: reads http://127.0.0.1:4078/api/stats. Hashrate in kH/s (1 H = 1 Pearl multiply-accumulate).
port=4078
[[ -f $CUSTOM_CONFIG_FILENAME ]] && p=$(grep -oE -- '--api-port [0-9]+' "$CUSTOM_CONFIG_FILENAME" | awk '{print $2}') && [[ -n $p ]] && port=$p
stats_raw=$(curl -s -m 5 "http://127.0.0.1:$port/api/stats")
if [[ -z $stats_raw ]]; then
  khs=0; stats="null"
else
  khs=$(echo "$stats_raw" | jq -r '.hashrate_hs / 1000')
  stats=$(echo "$stats_raw" | jq -c --arg algo pearl '{
    hs: [.gpus[].hashrate_hs / 1000], hs_units: "khs",
    temp: [.gpus[].temp_c // 0], fan: [.gpus[].fan_pct // 0],
    uptime: (.uptime_s | floor), ver: .version, ar: [.shares.accepted, .shares.rejected, .shares.stale],
    algo: $algo, bus_numbers: [.gpus[].ordinal] }')
fi
