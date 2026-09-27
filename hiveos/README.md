# GlintMiner on HiveOS

1. In HiveOS, create a **Flight Sheet**.
2. Coin: `PRL` (or the coin you want to be paid in). Wallet: your address.
3. Miner: **Custom**, then **Setup Miner Config**:
   - **Miner name:** `glint`
   - **Installation URL:** the `glint-…-hiveos.tar.gz` link from the [Releases](../../../releases) page
   - **Hash algorithm:** `pearl`
   - **Wallet and worker template:** `%WAL%` (a Pearl `prl1…` address, or `COIN:address` for other coins, e.g. `BTC:bc1q…`)
   - **Pool URL:** leave empty to let GlintMiner choose the nearest server, or enter your own `stratum+ssl://host:port`
     (for example `stratum+ssl://prl.kryptex.network:8048` to be paid in PRL through Kryptex: 2% fee, paid for every
     share, sent to your wallet from 1 PRL)
   - **Extra config arguments:** optional, e.g. `--kwh-price 0.12 --currency EUR`
4. Apply the Flight Sheet to your rig.

The rig name from HiveOS is used as the worker name. Hashrate, temperatures, fans and shares appear in the HiveOS
dashboard as usual.

Files: `h-manifest.conf`, `h-config.sh` (builds the command line), `h-run.sh` (starts the miner), `h-stats.sh`
(reports stats to HiveOS from GlintMiner's local API).
