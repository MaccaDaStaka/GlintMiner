<div align="center">

# GlintMiner

### Turn your NVIDIA graphics card into a Pearl miner, in about a minute.

**Paste your wallet. Press Enter. Start earning.**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

**English** · [Русский](README.ru.md) · [简体中文](README.zh-CN.md)

</div>

---

GlintMiner mines **Pearl (PRL)** on NVIDIA GPUs. It is built to get the most Pearl out of every watt, and to be the
easiest miner to start: no config files, no batch scripts, no command lines to learn. It asks one question, where to
send your earnings, and then shows you, live, what your card is making in real money.

## Why miners choose GlintMiner

| | **GlintMiner** | WildRig | SRBMiner | RGMiner | BzMiner |
|---|:-:|:-:|:-:|:-:|:-:|
| Developer fee | **1%** | 0%\* | 2% | 2% | 2% |
| Pool fee, Pearl payouts | **0%** (HeroMiners) | 1–3%\* (Pearlhash) | your pool | your pool | your pool |
| RTX 4090 @ 435 W | **304 TH/s** | 302 | 301 | ~300 | 294 |
| RTX 4090 @ 300 W | **258 TH/s** | 235 | | | |
| Efficiency @ 300 W | **0.86 TH/s per W** | 0.78 | | | |
| Getting started | **paste your wallet** | edit a .bat | edit a .bat | edit a .bat | edit a config |

<sub>Our measurements, September 2026: one RTX 4090 at stock clocks, WildRig 0.51.3, SRBMiner 3.6.9, RGMiner 1.0.9b,
BzMiner v100.36. Blank = not measured. \*WildRig's 0% fee applies on the Pearlhash pool, which charges its own pool fee
(1% on its site, 3% on independent trackers). Results vary by card, driver and settings.</sub>

- **More Pearl per watt.** Level with the fastest miners at full power, and around 10% ahead when the card is
  power-limited for heat, noise or electricity cost.
- **1% all-in for Pearl payouts.** Our 1% fee, and HeroMiners charges no pool fee. You can watch the fee being taken.
- **Paid in the coin you want.** Mine to a Pearl wallet, or to Bitcoin, Litecoin, Dogecoin, Solana and around 25 more.
- **Know what you earn.** Daily earnings in USD, EUR, GBP or your own currency, and profit after power if you enter
  your electricity price.
- **Looks after your hardware.** Every card's temperature is watched. A card that runs hot has its power eased
  down, and one near its limit pauses until it cools.
- **Set it and forget it.** Watchdog, automatic pool failover, encrypted (TLS) pool connections, and plain-language
  messages when something needs your attention.

---

## New to mining? Start here

Never mined before? This takes a few minutes and needs no technical knowledge.

### What you need

1. **An NVIDIA graphics card** from the RTX 30, 40 or 50 series (for example an RTX 3060, 4070 or 5060), with a
   recent NVIDIA driver. If you play games on it, you almost certainly have one.
2. **A wallet address**, which is where your earnings are sent. You have two choices:
   - **A Pearl address** (it starts with `prl1`). You are paid in PRL, Pearl's own coin.
   - **An address for a coin you already use**, such as Bitcoin, Litecoin, Dogecoin or Solana. Your crypto exchange
     or wallet app shows it as your "receive" or "deposit" address. GlintMiner mines Pearl and you are paid in that coin.

   Not sure which to choose? If you already hold Bitcoin or another popular coin, use that address. It is the
   quickest way to start.

### Three steps

**1. Download.** Open the [Releases](../../releases) page and download the file for your computer:

| Your computer | Download |
|---|---|
| Windows 10 / 11 | `glint-…-windows.zip` |
| Linux | `glint-…-linux.tar.gz` |
| HiveOS rig | `glint-…-hiveos.tar.gz` |

**2. Unzip and run.** Unzip it to a folder of your choice, for example `C:\GlintMiner`, and double-click
`glint.exe`. On Linux, run `./glint`.

**3. Answer the setup.**

```
  Welcome to GlintMiner. One thing is needed: where to send what you mine.

  Paste your wallet address: bc1q...
  -> BTC address, mining on unMineable.
  Name for this rig (shown on the pool) [rig1]:
  Electricity price per kWh, for profit after power (e.g. 0.12; Enter to skip): 0.15
```

You're mining. GlintMiner remembers your answers, so next time it starts straight away.

### What you'll see

A live view of every card: speed, temperature, power, accepted shares and **how much you're earning per day**. For
charts and history, open your browser at **http://127.0.0.1:4078** while GlintMiner is running.

### When do I get paid?

Your mining pool keeps a running balance for you and sends it to your wallet once it passes the pool's minimum
payout. For a single card this can take a day or more; newly found blocks take a few hours to confirm before they
count. The dashboard shows your balance and every payment made to you.

> **Tip:** leave it running. Pools pay for steady work, and a card that mines around the clock earns far more than
> one started and stopped every evening.

---

## The 1% developer fee, in the open

- About one second in every hundred, per card, mines for the developer. Your pool sees a steady hashrate, without
  the minute-long gaps some miners create.
- The live view and dashboard show the fee rate and the exact amount taken so far. Nothing else is taken, ever.
- If the fee server can't be reached you keep mining normally. The missed amount is made up gradually later,
  capped at about an hour's worth.

## Built to be trusted

- **Every share is checked on your machine** with Pearl's own verifier before it is sent. If the Pearl network
  changes its rules, GlintMiner stops and asks you to update rather than sending work that would be rejected.
- **No surprises.** GlintMiner tells you when a new version exists, and never downloads or installs anything by
  itself.
- **Your settings stay with you.** Everything is saved in `glint.json` next to the program, in plain text you can
  read.
- **Stock GPU settings.** GlintMiner never overclocks your card. Profit mode, which is optional, only tries lower
  power limits and picks the one that earns the most.

## For rig owners and power users

Everything the setup asks can also be given on the command line:

```
glint --wallet prl1... --worker rig1
glint --wallet BTC:bc1q... --kwh-price 0.12 --currency EUR
glint --wallet prl1... --devices 0,1 --api-bind 0.0.0.0 --plain
```

| Option | What it does |
|---|---|
| `--worker NAME` | Rig name shown on the pool |
| `--pool URL` | Use your own pool instead of the automatic choice |
| `--devices 0,1` | Mine on selected GPUs only |
| `--kwh-price`, `--currency` | Show profit after electricity |
| `--profit-mode` | Find the most profitable power limit (run as administrator) |
| `--api-bind 0.0.0.0` | View the dashboard from other devices on your network |
| `--telegram-token`, `--telegram-chat` | Get alerts on Telegram |
| `--plain` | Plain log lines, for services and rig operating systems |
| `--save` | Save these options to `glint.json` |

Diagnostics: `--self-test`, `--gpu-info`, `--bench 60`, `--benchmarks`. Full list: `glint --help`.

- **HiveOS:** add a custom miner using the `glint-…-hiveos.tar.gz` link from Releases. Put your wallet in the
  *Wallet and worker template* field; any extra options go in *Extra config arguments*. See [`hiveos/`](hiveos).
- **MMPOS:** see [`mmpos/`](mmpos).
- **Docker:** see [`docker/`](docker). Needs the NVIDIA Container Toolkit.
- **Linux service:** a ready `systemd` unit is in [`glint.service`](glint.service).
- **Stats API** for your own monitoring: `GET http://127.0.0.1:4078/api/stats` (JSON).

## Verify your download

Every release lists a SHA-256 checksum for each file in `SHA256SUMS.txt`. To check yours:

- **Windows:** `certutil -hashfile glint.exe SHA256`
- **Linux:** `sha256sum glint`

Antivirus programs often flag cryptocurrency miners as a category, even genuine ones. If yours does, compare the
checksum with the one on the Releases page. Only download GlintMiner from this repository.

## Requirements

- NVIDIA RTX 30-series or newer (compute capability 8.0+) with a current NVIDIA driver
- Windows 10/11 64-bit, or Linux x86-64 (glibc 2.17+)
- About 1.5 GB of system memory per GPU
- No CUDA toolkit or other software to install

## FAQ

**Is it safe for my graphics card?**
GlintMiner runs your card at its standard settings and never overclocks it. It watches temperatures continuously,
eases the power down if a card runs hot, and pauses a card that gets close to its limit until it cools.

**Can I use my PC while mining?**
Yes, though games and video editing will feel slower while it runs. Close GlintMiner (Ctrl+C or close the window)
whenever you want the full card back.

**How much will I earn?**
That depends on your card, the Pearl price and network difficulty, which all change over time. GlintMiner shows
your real earnings per day, live, from the moment it starts.

**I have several rigs on one wallet.**
Give each rig its own `--worker` name. Your pool's stats page then lists every rig separately.

**Something isn't working.**
Run `glint --self-test` and open an [issue](../../issues) with the output, your card and your driver version.

## Support

Found a bug or have an idea? Open an [issue](../../issues). Please include your GPU, driver version and the
relevant lines from `glint.log`.

## Licence

GlintMiner is free to use for personal and commercial mining. The binaries are closed-source. See
[LICENSE.txt](LICENSE.txt), and `THIRD_PARTY_NOTICES.txt` for the open-source components it uses.
