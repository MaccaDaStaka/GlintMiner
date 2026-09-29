<div align="center">

# GlintMiner

### Turn your NVIDIA graphics card into a Pearl miner, in about a minute.

**Choose how you're paid. Paste your address. Start earning.**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

### [⬇ Download GlintMiner 1.2.6](../../releases/latest)
Windows · Linux · HiveOS · free to use, 1% dev fee

**English** · [Русский](README.ru.md) · [简体中文](README.zh-CN.md)

<img src="images/dashboard-desktop.jpg" width="860" alt="The GlintMiner dashboard: is it working, what you're earning, how your card is tuned and when you get paid, at a glance">

</div>

---

GlintMiner mines **Pearl (PRL)** on NVIDIA GPUs. It is built to get the most Pearl out of every watt, and to be the
easiest miner to start: no config files, no batch scripts, no command lines to learn. It asks how you want to be paid
and where to send it, then shows you, live, what your card is making in real money.

**New in 1.2.6:** **Coolest and quietest**, a new tuning choice for the most hashrate per watt (a tester's RTX 3070:
half the power at 87% of the speed) · **pause while you game**: on Windows, mining stops when a game uses the card and
carries on a minute after · **a schedule**: another mode, or a pause, at the times of day you choose · setup asks what
you want (best earnings, most hashrate, less power, coolest and quietest) · a card whose driver fails while it tunes
recovers by itself · the next payout counts every rig on your wallet. [All changes](CHANGELOG.md)

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
| Stock | 310 TH/s | 443 W | 0.70 |
| **Auto-tune: Most hashrate** | **332 TH/s** (+7%) | 430 W | 0.77 |
| **Auto-tune: Less power** | 310 TH/s | **338 W** (−24%) | **0.92** |

<sub>GlintMiner mining live on Kryptex, September 2026, one RTX 4090. Every chip is a little different, so your card's
result will be too.</sub>

- **More Pearl per watt.** Full speed at full power, and it keeps more of that speed when you limit the card's power
  for heat, noise or electricity cost.
- **1% all-in for Pearl payouts.** Our 1% fee, and HeroMiners charges no pool fee. You can watch the fee being taken.
- **Paid in the coin you want.** Pearl to your own wallet, Bitcoin/USDT/USDC through Kryptex, or Bitcoin, Litecoin,
  Dogecoin, Solana and around 25 more through unMineable.
- **Know what you earn.** Daily earnings in your currency, and profit after power if you enter your electricity price.
- **Looks after your hardware.** Every card's temperature is watched against its own safe limit, read from the card.
  A card that runs hot has its power eased down; one near its limit pauses until it cools.
- **Get more from your card, if you want it.** Optional [auto-tune](docs/auto-tune.md) finds your card's best stable
  setting while it mines: more hashrate, or the same hashrate on much less power.
- **Games come first.** On Windows, mining pauses by itself while you play and carries on a minute after, with your
  card at factory settings for the game. A [schedule](docs/auto-tune.md#the-schedule) can run a quieter mode at night
  or pause at your peak electricity hours.
- **Set it and forget it.** Watchdog, automatic pool failover, encrypted pool connections, and plain-language messages
  when something needs you. Watch it from [your phone](docs/phone-access.md), anywhere.

<p align="center">
  <img src="images/phone-home.jpg" width="260" alt="The dashboard on a phone: is it working, profit per day and the tuning result">
  &nbsp;&nbsp;
  <img src="images/phone-tuned.jpg" width="260" alt="A card after auto-tune: +6.3% hashrate against stock, on less power">
</p>
<p align="center"><sub>The dashboard on a phone: your earnings at a glance, and a card after auto-tune.</sub></p>

---

## Start mining in three steps

You need an **NVIDIA RTX 30, 40 or 50-series card** with a recent driver, and **somewhere to be paid**:

| You have | You're paid in | Fees on top of the 1% dev fee |
|---|---|---|
| A **Pearl address** (`prl1…`, free from the Pearl wallet app) | PRL, on HeroMiners | **none** (best value) |
| The same Pearl address, on Kryptex | PRL, paid for every share, from 1 PRL | 2% |
| A **Kryptex account** (`krx…`, free at pool.kryptex.com) | BTC, withdrawable as BTC, USDT or USDC | 2% |
| An address for **another coin** (BTC, LTC, DOGE, SOL, …) | That coin, through unMineable | 1% |

**1. Download** the file for your computer from the [latest release](../../releases/latest): `…-windows.zip`,
`…-linux.tar.gz`, or `…-hiveos.tar.gz` for a HiveOS rig.

**2. Unzip and run** `glint.exe` (Linux: `./glint`). If Windows says *"Windows protected your PC"*, click **More info →
Run anyway**; it does this for new programs that haven't been downloaded widely yet.

**3. Answer a few questions.** Each one is a number: type it and press Enter. If you've copied your address,
GlintMiner finds it on the clipboard. Then it mines, and remembers your answers for next time.

Your dashboard is at **http://127.0.0.1:4078**: is it working, what you're earning, how your card is tuned and when you
get paid. The full walkthrough, with every setup question and how payouts work, is in
**[Getting started](docs/getting-started.md)**.

> **Tip:** leave it running. Pools pay for steady work, and a card that mines around the clock earns far more than
> one started and stopped every evening.

## Documentation

| Guide | What's in it |
|---|---|
| **[Getting started](docs/getting-started.md)** | Choosing how you're paid, the setup step by step, when you get paid, updating and uninstalling |
| **[The dashboard](docs/dashboard.md)** | Every screen explained: Home, Earnings, Rigs and Settings |
| **[Auto-tune](docs/auto-tune.md)** | The five choices, how to tune for the best result, what happens while it tunes, how it keeps your card safe |
| **[Phone access](docs/phone-access.md)** | Watching your miner from your phone, at home or anywhere with Tailscale |
| **[For rig owners and power users](docs/advanced.md)** | Every command-line option, several GPUs and rigs, pools, HiveOS, MMPOS, Docker, systemd, the stats API |
| **[FAQ and troubleshooting](docs/faq.md)** | Common questions, fixes for common problems, verifying your download, getting help |
| **Platform FAQs:** [Windows](docs/faq-windows.md) · [Linux](docs/faq-linux.md) · [HiveOS](docs/faq-hiveos.md) · [MMPOS](docs/faq-mmpos.md) · [Docker](docs/faq-docker.md) | Answers for each platform: running at boot or as a service, the rights it needs, auto-tune there, logs, updating and removing |
| **[HiveOS](hiveos/README.md)** · **[MMPOS](mmpos/README.md)** · **[Docker](docker/README.md)** | Setting GlintMiner up on each |
| **[Changelog](CHANGELOG.md)** | What changed in every version |

## The 1% developer fee, in the open

- About one second in every hundred, per card, mines for the developer. Your pool sees a steady hashrate, without
  the minute-long gaps some miners create.
- The console and dashboard show the fee rate and the exact amount taken so far. Nothing else is taken, ever.
- If the fee server can't be reached you keep mining normally. The missed amount is made up gradually later, capped
  at about an hour's worth.
- The fee's shares carry an anonymous label: the card models and counts, the payout type, the GlintMiner version and
  whether the cards are tuned (for example `g4687ad-hmv125s-4090x1`), so the developer can see how GlintMiner is used.
  Never your wallet, rig name, IP address or location.

## Built to be trusted

- **Every share is checked on your machine** with Pearl's own verifier before it is sent. If the Pearl network
  changes its rules, GlintMiner stops and asks you to update rather than sending work that would be rejected.
- **Stock settings unless you choose otherwise.** Out of the box GlintMiner never touches clocks, voltages or fans. It
  only eases the power limit down when a card runs hot. Auto-tune changes clocks only if you turn it on, and
  everything GlintMiner changes is put back when it closes, or on the next start after a crash.
- **No surprises.** It tells you when a new version exists, and never downloads or installs anything by itself.
- **Your settings stay with you,** in `glint.json` next to the program. Nothing is installed elsewhere.
- **Checksums for every file.** [Verify your download](docs/faq.md#verify-your-download) against `SHA256SUMS.txt`.

## Requirements

- NVIDIA RTX 30-series or newer (compute capability 8.0+) with a current NVIDIA driver
- Windows 10/11 64-bit, or Linux x86-64 (glibc 2.17+); HiveOS, MMPOS and Docker are supported
- About 1.5 GB of system memory per GPU
- Nothing else to install: no CUDA toolkit or runtime
- For auto-tune: administrator (Windows) or root (Linux) rights. Without them GlintMiner simply mines at stock

## Support

Found a bug or have an idea? Open an [issue](../../issues) with your GPU, driver version, the output of
`glint --self-test` and the relevant lines from `glint.log`. More in [Getting help](docs/faq.md#getting-help).

## Licence

GlintMiner is free to use for personal and commercial mining. The binaries are closed-source. See
[LICENSE.txt](LICENSE.txt), and `THIRD_PARTY_NOTICES.txt` for the open-source components it uses.
