# GlintMiner on HiveOS

1. In HiveOS, create a **Flight Sheet**.
2. Coin: `PRL` (or the coin you want to be paid in). Wallet: your address.
3. Miner: **Custom**, then **Setup Miner Config**:
   - **Miner name:** `glint`
   - **Installation URL:** the link to the HiveOS package, `glint-<version>.tar.gz` (not the `-linux` one), from the
     [Releases](../../../releases) page
   - **Hash algorithm:** `pearl`
   - **Wallet and worker template:** `%WAL%` (a Pearl `prl1…` address, or `COIN:address` for other coins, e.g. `BTC:bc1q…`)
   - **Pool URL:** leave empty to let GlintMiner choose the nearest server, or enter your own `stratum+ssl://host:port`
     (for example `stratum+ssl://prl.kryptex.network:8048` to be paid in PRL through Kryptex: 2% fee, paid for every
     share, sent to your wallet from 1 PRL)
   - **Extra config arguments:** optional, e.g. `--kwh-price 0.12 --currency EUR` (in mainland China, also
     `--github-proxy https://v4.gh-proxy.org/`, so the affiliate code list and updates can be fetched)
4. Apply the Flight Sheet to your rig.

The rig name from HiveOS is used as the worker name. Hashrate, temperatures, fans and shares appear in the HiveOS
dashboard by themselves: nothing to enable. GlintMiner serves its stats on the rig at `127.0.0.1:4078` and
`h-stats.sh` reads them. If you change the port, do it with `--api-port` in *Extra config arguments* (the stats
script follows that; a port changed on the dashboard's settings page isn't followed).

To open GlintMiner's own dashboard from another computer on your network, add `--api-bind 0.0.0.0` to *Extra config
arguments* and browse to `http://<rig-ip>:4078`. It is view-only from there; add `--api-allow-remote-control` as well
to change settings from that computer.

Files: `h-manifest.conf`, `h-config.sh` (builds the command line), `h-run.sh` (starts the miner), `h-stats.sh`
(reports stats to HiveOS from GlintMiner's local API).
