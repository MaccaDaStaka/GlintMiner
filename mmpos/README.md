# GlintMiner on MMPOS

Add GlintMiner as a custom miner in MMPOS using the Linux release archive from the [Releases](../../../releases)
page, with `mmp-external.conf` and `mmp-stats.sh` from this folder. In your mining profile, set the wallet to a
Pearl `prl1…` address, or `COIN:address` to be paid in another coin (e.g. `BTC:bc1q…`).

Stats (hashrate, shares, per-GPU temperature and power) are read from GlintMiner's local API at
`http://127.0.0.1:4078/api/stats`.
