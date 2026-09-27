<div align="center">

# GlintMiner

### Turn your NVIDIA graphics card into a Pearl miner, in about a minute.

**Choose how you're paid. Paste your address. Start earning.**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

### [⬇ Download GlintMiner 1.2.1](../../releases/latest)
Windows · Linux · HiveOS · free to use, 1% dev fee

**English** · [Русский](README.ru.md) · [简体中文](README.zh-CN.md)

<img src="images/dashboard-desktop.jpg" width="860" alt="The GlintMiner dashboard: profit per day, hashrate, cards, shares and pool at a glance">

</div>

---

GlintMiner mines **Pearl (PRL)** on NVIDIA GPUs. It is built to get the most Pearl out of every watt, and to be the
easiest miner to start: no config files, no batch scripts, no command lines to learn. It asks how you want to be paid
and where to send it, and then shows you, live, what your card is making in real money.

**New in 1.2:** a redesigned dashboard for phone and desktop, in English, Russian and Chinese · optional **auto-tune**
(on our RTX 4090: **+6% hashrate**, or stock speed on **24% less power**) · choose at setup to be paid in Pearl,
Bitcoin/USDT/USDC through Kryptex, or another coin.

## Why miners choose GlintMiner

| RTX 4090, stock clocks | **GlintMiner** | Nearest competitor |
|---|:-:|:-:|
| Hashrate @ 435 W | **304 TH/s** | 302 TH/s |
| Hashrate @ 300 W | **258 TH/s** | 235 TH/s |
| Efficiency @ 300 W | **0.86 TH/s per watt** | 0.78 |
| Fees, all-in (Pearl payouts) | **1%** (0% pool fee on HeroMiners) | 1–3% (0% miner fee, 1–3% pool fee) |
| Getting started | **paste your wallet** | edit a .bat file |

<sub>Measured September 2026 on one RTX 4090, both miners on the same card the same day. "Nearest competitor" is the
fastest other Pearl miner we tested; it has no miner fee but mines on its own pool, which charges one. Results vary
by card, driver and settings.</sub>

**With auto-tune (optional).** Let GlintMiner find the best stable setting for your card:

| RTX 4090 | Hashrate | Power | TH/s per watt |
|---|:-:|:-:|:-:|
| Stock | 308 TH/s | 445 W | 0.69 |
| **Auto-tune: Speed** | **328 TH/s** (+6%) | 414 W | 0.79 |
| **Auto-tune: Efficiency** | 307 TH/s | **337 W** (−24%) | **0.91** |

<sub>GlintMiner 1.2.0 mining live on HeroMiners, September 2026, one RTX 4090. Every chip is a little different, so
your card's result will be too.</sub>

- **More Pearl per watt.** Full speed at full power, and it keeps more of that speed when you limit the card's power
  for heat, noise or electricity cost.
- **1% all-in for Pearl payouts.** Our 1% fee, and HeroMiners charges no pool fee. You can watch the fee being taken.
- **Paid in the coin you want.** Mine to a Pearl wallet, or to Bitcoin, Litecoin, Dogecoin, Solana and around 25 more.
- **Know what you earn.** Daily earnings in USD, EUR, GBP or your own currency, and profit after power if you enter
  your electricity price.
- **Looks after your hardware.** Every card's temperature is watched. A card that runs hot has its power eased
  down, and one near its limit pauses until it cools.
- **Get more from your card, if you want it.** Optional [auto-tune](#auto-tune-optional) finds your card's best
  stable setting while it mines: more hashrate, or the same hashrate on much less power.
- **Set it and forget it.** Watchdog, automatic pool failover, encrypted (TLS) pool connections, and plain-language
  messages when something needs your attention.

<p align="center">
  <img src="images/phone-home.jpg" width="260" alt="The dashboard on a phone: profit per day, hashrate, power and shares">
  &nbsp;&nbsp;
  <img src="images/phone-tuned.jpg" width="260" alt="A card after auto-tune: +6.3% hashrate against stock, with every result checked">
</p>
<p align="center"><sub>The dashboard on a phone: your earnings at a glance, and a card after auto-tune.</sub></p>

---

## New to mining? Start here

Never mined before? This takes a few minutes and needs no technical knowledge.

### What you need

1. **An NVIDIA graphics card** from the RTX 30, 40 or 50 series (for example an RTX 3060, 4070 or 5060), with a
   recent NVIDIA driver. If you play games on it, you almost certainly have one.
2. **Where to send your earnings.** You have three choices:
   - **A Pearl address** (it starts with `prl1`). You are paid in PRL, Pearl's own coin.
   - **An address for a coin you already use**, such as Bitcoin, Litecoin, Dogecoin or Solana. Your crypto exchange
     or wallet app shows it as your "receive" or "deposit" address. GlintMiner mines Pearl, and unMineable converts it
     and pays you in that coin.
   - **A Kryptex account ID** (it starts with `krx`, from a free account at pool.kryptex.com, email only). Kryptex
     converts your Pearl to Bitcoin automatically, and you can withdraw it as **BTC, USDT or USDC** from your Kryptex
     account.

   Not sure which to choose?
   - **Best value:** a **Pearl address**. There's no conversion and no pool fee on HeroMiners. You can get one free
     from the Pearl wallet app (open **Receive**).
   - **Want Bitcoin or a stablecoin with no effort:** a **Kryptex account**. Kryptex charges 2% and doesn't publish its
     conversion rate, but by our estimate it's likely to pay noticeably more than converting through unMineable.
   - **Want another coin straight to your own wallet:** use that coin's address. unMineable converts for a 1% fee,
     and GlintMiner shows unMineable's own estimate of what you'll receive.

### Three steps

**1. Download.** Open the [latest release](../../releases/latest) and download the file for your computer:

| Your computer | Download |
|---|---|
| Windows 10 / 11 | `glint-…-windows.zip` |
| Linux | `glint-…-linux.tar.gz` |
| HiveOS rig | `glint-…-hiveos.tar.gz` |

**2. Unzip and run.** Unzip it to a folder of your choice, for example `C:\GlintMiner`, and double-click
`glint.exe`. On Linux, run `./glint`.

> The first time, Windows may show **"Windows protected your PC"**. It does this for new programs that haven't been
> downloaded widely yet. Click **More info**, then **Run anyway**. You only need to do this once.

**3. Answer the setup.**

```
  Welcome to GlintMiner. How do you want to be paid?

    1) Pearl (PRL) to your Pearl wallet          best value: no pool fee, no conversion
    2) Bitcoin, USDT or USDC via a free Kryptex account   Kryptex converts for you (2% fee)
    3) Another coin (LTC, DOGE, SOL, ETH...) to your own wallet   unMineable converts (1% fee)

  Choose 1, 2 or 3 [1]: 1
  Paste your Pearl address (starts with prl1; get one free in the Pearl wallet app, Receive): prl1...
  -> Paid in PRL to your Pearl wallet, mining on HeroMiners (no pool fee).
  Name for this rig (shown on the pool) [rig1]:
  Electricity price per kWh, for profit after power (e.g. 0.12; Enter to skip): 0.15
```

You're mining. GlintMiner remembers your answers, so next time it starts straight away.

### What you'll see

A live view of every card: speed, temperature, power, accepted shares and **how much you're earning per day**. For
charts, history and payouts, open the dashboard at **http://127.0.0.1:4078** while GlintMiner is running (it can open by
itself when GlintMiner starts). It works on a phone too, speaks English, Russian and Chinese, and keeps this rig's
estimate separate from your wallet's balance and payments on the pool.

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
- **Your settings stay with you.** Everything is saved in `glint.json` next to the program.
- **Stock settings unless you choose otherwise.** Out of the box GlintMiner never touches clocks, voltages or fans. It
  only eases the power limit down when a card runs hot. Optional **auto-tune** (below) changes clocks only if you turn
  it on. Everything GlintMiner changes is put back when it closes.

## Several GPUs and several rigs

- **One PC, several cards.** GlintMiner uses every supported NVIDIA card in the PC automatically, and you can mix
  models (say, a 3080 and a 4070). Each card gets its own line in the live view and the dashboard, with its own
  hashrate, temperature, power and shares. The cards share one pool connection, so the pool sees one worker per PC.
- **Choose which cards mine.** `--devices 0,2` uses only those cards (numbered as in `glint --gpu-info`).
- **A card that fails doesn't stop the rest.** If one card can't start, the others mine on and the live view says
  why. If a card stops responding, GlintMiner restarts itself and carries on.
- **Every card is looked after on its own.** The temperature guard watches each card separately.
- **Several PCs.** Run GlintMiner on each one with its own worker name (`--worker rig2`), all to the same wallet.
  Your pool's stats page lists each PC separately.
- **Memory.** Allow about 1.5 GB of system memory per GPU.
- **Headless rigs.** Use the HiveOS, MMPOS or Docker packages, or the systemd service (below). Add
  `--api-bind 0.0.0.0` to open the dashboard from another device on your network. From there it's view-only; add
  `--api-allow-remote-control` too if you want to change settings from those devices.

## Auto-tune (optional)

Every graphics chip is a little different. Auto-tune finds the best stable setting for **your** card, automatically,
while it mines, and keeps only a setting that stays error-free under Pearl's own verifier, with a safety margin. On our
RTX 4090, **Speed** found **+6% hashrate on 30 W less power**, and **Efficiency** kept stock hashrate on **about a
quarter less power** (337 W instead of 445 W).

| Mode | What it aims for |
|---|---|
| **Off** (default) | Stock settings |
| **Speed** | The highest hashrate your card can hold with zero errors |
| **Efficiency** | Stock hashrate on as little power as possible (cooler and quieter) |
| **Profit** | The most money after electricity (needs your electricity price) |

Turn it on in the dashboard (**Settings → Tuning**), or with `glint --tune speed --confirm-tuning` (or `efficiency`,
`profit`). `--confirm-tuning` is needed once, to confirm you accept the risk below; `--tune off` turns it off. It needs
GlintMiner to run as administrator (Windows) or root (Linux). The first search takes about an hour while the card keeps
mining; the result is saved and re-applied at every start.

**The risk, plainly:** auto-tune runs your card outside its factory settings. It backs off at the first error, never
overclocks memory, never goes above your card's own power maximum, and puts everything back when GlintMiner closes
(or on the next start after a crash). But an unstable setting can still crash the miner or, rarely, the display
driver. You turn it on at your own risk, and it stays off unless you do.

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
| `--tune MODE` | Auto-tune: `speed`, `efficiency`, `profit` or `off` (run as administrator; add `--confirm-tuning` the first time) |
| `--retune` | Forget the saved tune and search again |
| `--api-bind 0.0.0.0` | View the dashboard from other devices on your network (view-only) |
| `--api-allow-remote-control` | Also allow changes from those devices (only on a network you trust) |
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
- For auto-tune: administrator (Windows) or root (Linux) rights and a recent NVIDIA driver; without them GlintMiner
  simply mines at stock settings

## FAQ

**Is it safe for my graphics card?**
At its default settings GlintMiner never changes clocks or voltages. It watches temperatures continuously, eases the
power limit down if a card runs hot (this needs GlintMiner run as administrator), and pauses a card that gets close to
its limit until it cools. Clocks change only if you turn on auto-tune. Everything is restored when you close it.

**Can I use my PC while mining?**
Yes, though games and video editing will feel slower while it runs. Close GlintMiner (Ctrl+C or close the window)
whenever you want the full card back.

**How much will I earn?**
That depends on your card, the Pearl price and network difficulty, which all change over time. GlintMiner shows
your real earnings per day, live, from the moment it starts.

**How do I update to a new version?**
GlintMiner tells you when one is out; there's nothing to uninstall. Close GlintMiner, download the new zip from the
[latest release](../../releases/latest), and unzip it into the same folder, replacing the files. Your settings
(`glint.json`), history and benchmarks aren't in the zip, so they stay. Start `glint.exe` again and it carries on
mining with your settings. (Linux: replace `glint`. HiveOS: update the custom miner's download link to the new
version.)

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
