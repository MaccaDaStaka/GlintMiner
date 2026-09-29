#!/usr/bin/env bash
# HiveOS stats: reads http://127.0.0.1:4078/api/stats. Hashrate in kH/s (1 H = 1 Pearl multiply-accumulate).
# bus_numbers are the cards' PCI bus numbers (from pci_bus_id, e.g. 0000:0a:00.0 -> 10), so HiveOS puts each figure
# on the right card; the CUDA order can differ from it on a mixed rig.
port=4078
[[ -f $CUSTOM_CONFIG_FILENAME ]] && p=$(grep -oE -- '--api-port [0-9]+' "$CUSTOM_CONFIG_FILENAME" | awk '{print $2}') && [[ -n $p ]] && port=$p
stats_raw=$(curl -s -m 5 "http://127.0.0.1:$port/api/stats")
if [[ -z $stats_raw ]]; then
  khs=0; stats="null"
else
  khs=$(echo "$stats_raw" | jq -r '.hashrate_hs / 1000')
  stats=$(echo "$stats_raw" | jq -c --arg algo pearl '{
    hs: [.gpus[].hashrate_hs / 1000], hs_units: "khs",
    temp: [.gpus[] | .temp_c // 0], fan: [.gpus[] | .fan_pct // 0],
    uptime: (.uptime_s | floor), ver: .version, ar: [.shares.accepted, .shares.rejected, .shares.stale],
    algo: $algo,
    bus_numbers: [.gpus[] | (.pci_bus_id // "" | split(":") | if length >= 2 then .[length-2] else "" end) as $b
      | if $b == "" then .ordinal else ($b | ascii_downcase | explode | reduce .[] as $c (0; . * 16 + (if $c >= 97 then $c - 87 else $c - 48 end))) end] }')
fi
