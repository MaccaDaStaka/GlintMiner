# For rig owners and power users

[← Back to the README](../README.md) · **English** · [Русский](advanced.ru.md) · [简体中文](advanced.zh-CN.md)

Everything the setup asks can also be given on the command line, and everything here can be saved so GlintMiner
starts with it every time.

- [Command line](#command-line)
- [All options](#all-options)
- [Diagnostics](#diagnostics)
- [Several GPUs and several rigs](#several-gpus-and-several-rigs)
- [Pools and payouts](#pools-and-payouts)
- [HiveOS, MMPOS, Docker and Linux services](#hiveos-mmpos-docker-and-linux-services)
- [Stats API](#stats-api)
- [Files GlintMiner keeps](#files-glintminer-keeps)

---

## Command line

```
glint --wallet prl1... --worker rig1
glint --wallet prl1... --pool stratum+ssl://prl.kryptex.network:8048
glint --wallet krx... --worker rig1
glint --wallet BTC:bc1q... --kwh-price 0.12 --currency EUR
glint --wallet prl1... --devices 0,1 --api-bind 0.0.0.0 --plain
glint --wallet prl1... --tune speed --confirm-tuning --save
```

Options given on the command line are used for that run. Add `--save` to write them to `glint.json`, so a plain
`glint` (or a double-click) uses them from then on.

**The wallet decides the route:**

| `--wallet` | Mines on | Paid in |
|---|---|---|
| `prl1…` (a Pearl address) | HeroMiners, nearest server (0% pool fee) | PRL |
| `prl1…` with `--pool stratum+ssl://prl.kryptex.network:8048` | Kryptex (2%, pays per share) | PRL |
| `krx…` or the email of a Kryptex account | Kryptex | BTC, withdrawable as BTC, USDT or USDC |
| `COIN:address`, e.g. `BTC:bc1q…`, `DOGE:D…`, `SOL:…` | unMineable (1%) | That coin |

## All options

| Option | What it does |
|---|---|
| `--wallet ADDRESS` | Where you're paid (see the table above) |
| `--coin TICKER` | The coin for an address that fits several (for example a `0x…` address: ETH, USDT, …) |
| `--worker NAME` | This rig's name on the pool (letters, digits, `-` and `_`) |
| `--pool URL` | Use this pool instead of the automatic choice (`stratum+ssl://host:port`) |
| `--devices 0,1` | Mine on these GPUs only (numbered as in `glint --gpu-info`); default: all |
| `--kwh-price 0.12`, `--currency EUR` | Your electricity price and currency, for profit after power |
| `--profit-mode` | Find the power limit that earns the most, once a day (needs `--kwh-price` and administrator rights) |
| `--tune MODE` | Auto-tune: `speed`, `efficiency`, `profit` or `off` (administrator rights; `--confirm-tuning` the first time) |
| `--confirm-tuning` | Confirms you accept auto-tune's risk (saved) |
| `--tune-card 0=speed,1=efficiency,2=off` | A mode for each card (`default` follows `--tune`); cards not listed follow `--tune` |
| `--tune-exclude 0,2` | Keep these cards at stock while the others tune |
| `--retune` | Forget the saved tunes and tune every card again from stock |
| `--tune-reset` | Forget saved tunes, per-card modes and exclusions, and turn tuning off |
| `--tune-ignore-tools` | Tune even while MSI Afterburner or a similar tool is running (it may change clocks mid-tune) |
| `--share-diff N` | Kryptex only: the share difficulty to ask for (0 = automatic) |
| `--api-port 4078` | The dashboard's port |
| `--api-bind 0.0.0.0` | Open the dashboard to your network (view-only from other devices) |
| `--api-allow-remote-control` | Also allow changes from those devices (only on a network you trust) |
| `--open-dashboard`, `--no-open-dashboard` | Open the dashboard in your browser at start, or don't |
| `--telegram-token TOKEN`, `--telegram-chat ID` | Alerts on Telegram when a card stops or the pool is lost |
| `--plain` | Plain log lines instead of the live table (services, rig OSes, screen readers) |
| `--no-log-file` | Don't write `glint.log` |
| `--save` | Write these options to `glint.json` |
| `--config PATH` | Use another settings file (default: `glint.json` next to `glint`) |

The full list is always in `glint --help`. Auto-tune in depth: [Auto-tune](auto-tune.md).

## Diagnostics

| Command | What it does |
|---|---|
| `glint --self-test` | Checks the card, driver and the mining code end to end, then exits. Include its output in bug reports |
| `glint --gpu-info` | Lists your NVIDIA cards with their numbers, memory, driver and compute capability |
| `glint --bench 60` | Mines offline for 60 seconds and reports the hashrate (the result is saved) |
| `glint --benchmarks` | Shows saved benchmark results |
| `glint --pools ADDRESS` | Shows which pool and route an address would use |
| `glint --net-test host:port` | Tests the connection to a pool server |

## Several GPUs and several rigs

- **One PC, several cards.** GlintMiner uses every supported NVIDIA card in the PC automatically, and you can mix
  models (say a 3080 and a 4070). Each card has its own line in the console and the dashboard, with its own hashrate,
  temperature, power and shares. The cards share one pool connection, so the pool sees one worker per PC.
- **Choose which cards mine:** `--devices 0,2`, or Settings → Mining → Cards to use.
- **One card failing doesn't stop the rest.** If a card can't start, the others mine on and the console says why. If
  a card stops responding, GlintMiner restarts itself and carries on.
- **Every card is looked after on its own:** the temperature guard and auto-tune treat each card separately. See
  [Rigs with several cards](auto-tune.md#rigs-with-several-cards).
- **Several PCs:** run GlintMiner on each with its own worker name (`--worker rig2`), all to the same wallet. Your
  pool lists each PC separately, and the dashboard's Earnings page shows every rig on the wallet.
- **Memory:** allow about 1.5 GB of system memory (RAM) per GPU.

## Pools and payouts

- **Automatic pool choice.** For a Pearl address GlintMiner picks the nearest HeroMiners server and fails over to
  another if it becomes unreachable. Connections are encrypted (TLS).
- **Your own pool:** `--pool stratum+ssl://host:port`, or Settings → Mining → Pool override.
- **Smaller shares on HeroMiners and Kryptex.** A Pearl share is about 2 MB. On HeroMiners, GlintMiner sends them
  compressed (about 14 KB each); if a HeroMiners server ever refuses them, it sends that server's shares uncompressed
  for the rest of the run. On Kryptex they're compressed (about 11 KB) whenever Kryptex agrees at login. Less traffic,
  and fewer stale shares on a slow connection.
- **Share difficulty on Kryptex.** A big rig (above 500 TH/s) automatically asks Kryptex for a higher share difficulty,
  about one share every 30 seconds, so it doesn't flood the pool. Set your own with `--share-diff N`. Kryptex's
  default is 2097152; the formula is *hashrate in H/s × seconds per share ÷ 4294967296*. Your earnings don't change:
  each share simply counts for more.

## HiveOS, MMPOS, Docker and Linux services

- **HiveOS:** add a custom miner with the `glint-…-hiveos.tar.gz` link from Releases. Step by step, including stats and
  opening the dashboard from another computer: [HiveOS](../hiveos/README.md).
- **MMPOS:** [MMPOS](../mmpos/README.md).
- **Docker:** [Docker](../docker/README.md). Needs the NVIDIA Container Toolkit on the host.
- **Linux service (systemd):** copy [`glint.service`](../glint.service) to `/etc/systemd/system/`, put your wallet in
  it, and run `systemctl enable --now glint`. GlintMiner then starts at boot and restarts if it ever stops. Use
  `--plain` for services, so the log reads cleanly in `journalctl -u glint`.
- **Auto-tune on Linux** needs root, since changing clocks does.

## Stats API

GlintMiner serves JSON on the dashboard's port, for your own monitoring and for rig OSes:

- `GET http://127.0.0.1:4078/api/stats`: total and per-card hashrate (H/s), temperatures, fans, power, shares
  (accepted, rejected, stale), uptime, version, the earnings estimate and the pool's wallet figures.

It answers on `127.0.0.1` only, unless you start GlintMiner with `--api-bind 0.0.0.0`. Hashrate is in H/s, where 1 H
is one Pearl multiply-accumulate.

## Files GlintMiner keeps

All next to the program (or next to the file given with `--config`):

| File | What's in it |
|---|---|
| `glint.json` | Your settings and saved tunes. Keep it when you update; delete it to start the setup again |
| `glint.log` | The log: what happened and when, with the technical detail of any error. Include the relevant lines in bug reports |
| `glint-history.jsonl` | A minute-by-minute record of hashrate, power and earnings, for the dashboard's charts and totals |
| `glint-benchmarks.json` | Results of `--bench` |

None of these contain passwords. `glint.json` contains your payout address and, if you set them, your Telegram bot
token and chat id.
