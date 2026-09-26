#!/usr/bin/env bash
# Prints total hashrate (H/s), accepted and rejected shares, and per-GPU hashrate as JSON for MMPOS.
curl -s -m 5 http://127.0.0.1:4078/api/stats | jq -c '{hashrate: .hashrate_hs, accepted: .shares.accepted, rejected: .shares.rejected, gpus: [.gpus[] | {id: .ordinal, hashrate: .hashrate_hs, temp: .temp_c, power: .power_w}]}'
