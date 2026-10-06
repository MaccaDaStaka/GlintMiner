<div align="center">

# GlintMiner

### Turn your NVIDIA graphics card into a Pearl miner, in about a minute.

**Choose how you're paid. Paste your address. Start earning.**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 20 | 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2020%20%7C%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

### [⬇ Download GlintMiner 1.2.8](../../releases/latest)
Windows · Linux · HiveOS · free to use, 1% dev fee

**English** · [Русский](README.ru.md) · [简体中文](README.zh-CN.md)

<img src="images/dashboard-desktop.jpg" width="860" alt="The GlintMiner dashboard: is it working, what you're earning, how your card is tuned and when you get paid, at a glance">

</div>

---

GlintMiner mines **Pearl (PRL)** on NVIDIA GPUs. It is built to get the most Pearl out of every watt, and to be the
easiest miner to start: no config files, no batch scripts, no command lines to learn. It asks how you want to be paid
and where to send it, then shows you, live, what your card is making in real money.

**New in 1.2.8:** **RTX 50 cards mine faster**: each card tries the ways of mining at start and keeps the fastest ·
**RTX 20 series and CMP 40HX** mine · **updates from the dashboard**, signature-checked, with automatic rollback · big
rigs tune without running hot, with an optional rig power budget · *Compare modes* · works on networks that block DNS,
via secure DNS · a card whose driver stops responding is paused instead of restarting everything · **affiliate codes**:
support whoever referred you at no extra cost, or become an affiliate yourself. [All changes](CHANGELOG.md)

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

**On a user's rig.** Six RTX 3090s and an RTX 4070 Ti on HiveOS, the same overclock for all three miners:

| 6× RTX 3090 + RTX 4070 Ti | **GlintMiner** | Other miner A | Other miner B |
|---|:-:|:-:|:-:|
| Hashrate | **930 TH/s** | 913 TH/s | 900 TH/s |
| Power | **1,536 W** | 1,629 W | 1,629 W |
| TH/s per watt | **0.61** | 0.56 | 0.55 |
| RTX 4070 Ti alone | **152 TH/s** at 180 W | 147 TH/s | 147 TH/s |

<sub>A user's own readings from HiveOS, September 2026, shared with his permission: each miner on the same rig with
the same clocks and power limits. Readings taken at a moment; results vary by card, driver and settings.</sub>

**With auto-tune (optional).** Let GlintMiner find the best stable setting for your card:

| RTX 4090 | Hashrate | Power | TH/s per watt |
|---|:-:|:-:|:-:|
| Stock | 310 TH/s | 443 W | 0.70 |
| **Auto-tune: Most hashrate** | **332 TH/s** (+7%) | 430 W | 0.77 |
| **Auto-tune: Less power** | 310 TH/s | **338 W** (−24%) | **0.92** |

<sub>GlintMiner mining live on Kryptex, September 2026, one RTX 4090. Every chip is a little different, so your card's
result will be too.</sub>

**Stock hashrate by card (1.2.8).** No tuning, each card at its own default power limit:

| Card | Hashrate | Power limit | TH/s per watt |
|---|:-:|:-:|:-:|
| RTX 5090 | 423–426 TH/s | 600 W | 0.71 |
| RTX 5080 | 223 TH/s | 360 W | 0.62 |
| RTX 5070 | 129 TH/s | 250 W | 0.52 |
| RTX 5060 | 77 TH/s | 145 W | 0.53 |
| RTX 4090 | 315 TH/s | 450 W | 0.70 |
| RTX 4070 | 118 TH/s | 200 W | 0.59 |
| RTX 4060 Ti | 89 TH/s | 160 W | 0.56 |
| RTX 3070 | 81 TH/s | 220 W | 0.37 |
| RTX 3060 | 48 TH/s | 170 W | 0.28 |
| RTX 2070 SUPER | 63 TH/s | 215 W | 0.29 |

<sub>Rented cards at their own default power limit, every share verified by a pool. An RTX 5090 with a 575 W limit
makes about 395 TH/s. Hashrate varies a few % by card and cooling.</sub>

- **More Pearl per watt.** Full speed at full power, and it keeps more of that speed when you limit the card's power
  for heat, noise or electricity cost.
- **1% all-in for Pearl payouts.** Our 1% fee, and HeroMiners charges no pool fee. You can watch the fee being taken.
- **Paid in the coin you want.** Pearl to your own wallet, Bitcoin/USDT/USDC through Kryptex, or Bitcoin, Litecoin,
  Dogecoin, Solana and around 25 more through unMineable.
- **Know what you earn.** Daily earnings in your currency, and profit after power if you enter your electricity price.
- **Looks after your hardware.** Every card's temperature is watched against its own safe limit, read from the card.
  A card that runs hot has its power eased down; one near its limit pauses until it cools.
- **Get more from your card, if you want it.** Optional [auto-tune](docs/auto-tune.md) finds your card's best stable
  setting while it mines: usually 4–9% more hashrate, the same hashrate on less power (up to nearly half less,
  depending on the card), or a clearly cooler and quieter card at 70–90% of its speed on a quarter to over half less
  power, with what each strength aims for on your card shown in watts. *Compare modes* on the dashboard shows
  every mode side by side for your cards, with TH/s, watts and profit a day at your electricity price. On a rig the cards tune one at a time, and a card waiting its turn keeps your overclock or runs
  at reduced power (with an optional power budget for the whole rig).
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

You need an **NVIDIA RTX 20, 30, 40 or 50-series card** with a recent driver, and **somewhere to be paid**:

| You have | You're paid in | Fees on top of the 1% dev fee |
|---|---|---|
| A **Pearl address** (`prl1…`, free from the Pearl wallet app) | PRL, on HeroMiners | **none** (best value) |
| The same Pearl address, on Kryptex | PRL, paid for every share, from 1 PRL | 2% |
| A **Kryptex account** (`krx…`, free at pool.kryptex.com) | BTC, withdrawable as BTC, USDT or USDC | 2% |
| An address for **another coin** (BTC, LTC, DOGE, SOL, …) | That coin, through unMineable | 1% |

**1. Download** the file for your computer from the [latest release](../../releases/latest): `…-windows.zip`,
`…-linux.tar.gz`, or `glint-….tar.gz` for a HiveOS rig.

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
- If the fee's servers can't be reached, the fee is paid through your own pool's server instead. If that fails too,
  you keep mining and 1% of the time is left idle instead. If the fee can't connect at all for 24 hours while your own
  pool works, mining pauses until it can (the [FAQ](docs/faq.md) says what to allow, and how to use secure DNS). A
  short outage is made up gradually later, capped at about an hour's worth: never more than 1% overall.
- The fee's shares carry an anonymous label: the card models and counts, the payout type, the GlintMiner version and
  whether the cards are tuned (for example `g4687ad-hmv125s-4090x1`), so the developer can see how GlintMiner is used.
  Never your wallet, rig name, IP address or location.

**Affiliate codes.** If someone referred you, enter their code in setup, in Settings → Affiliate code, with
`--affiliate CODE` (HiveOS and mmpOS: in the extra arguments; `--affiliate off` removes it) or as `"affiliate"` in
`glint.json`. You still pay 1%: a quarter of it (0.25% of the time) mines to the affiliate's PRL wallet instead of the
developer's. It never costs you more, and the fee works exactly as above. Codes come from a list in a public repository of
their own, [GlintMiner-affiliates](https://github.com/MaccaDaStaka/GlintMiner-affiliates), signed with a key used only
for code lists (never for updates, and the release key is never taken for a code list); GlintMiner checks the
signature itself and looks
for a newer list (at start and once a day) only when you have entered a code. The list is downloaded whole and looked
up on your rig: nothing about you is sent for it. A code that isn't in the list is "not recognised" and the whole 1%
goes to the developer. The affiliate's share mines on the dev fee's own servers, logged in with the affiliate's wallet
and the worker name `glint` (nothing of your rig shows on their pool page); if it can't connect, or the pool refuses
the affiliate's wallet, that share goes to the developer instead.

**Become an affiliate.** Bring other miners and earn a quarter of the fee from every rig that uses your code, paid by
the pool to your PRL wallet. Ask in Settings → Become an affiliate, or with `glint --become-affiliate` on a rig without
a screen. Before anything is sent you see exactly what goes: the PRL payout wallet you give (it can be a different one
from the wallet you mine to), your Discord username if you give it, the install's anonymous id and the GlintMiner
version; it is sent only after you tick the confirmation (or type `yes`). The Discord username is optional, but it is
how you get the Affiliate role and channel on [Discord](https://discord.gg/dXBTwVzJNy): when the developer approves
your request (each one is checked by hand), the Discord bot gives you the role, and you get your code. The code list is
signed and published automatically when your request is approved, within minutes; running miners pick it up when they
start or within a day. The dashboard (or `--become-affiliate` again) shows whether it is waiting, approved or not.

## Anonymous check-in

From 1.2.8, about 2 minutes after it starts and then every 15 minutes, GlintMiner sends the developer a short
anonymous check-in over HTTPS:

- **What is sent:** the install's anonymous id (the same `g4687ad` as in the fee label: a hash of your payout address,
  not the address), a random id for this run (new at every start), the GlintMiner version, the operating system and
  platform (Windows, Linux, HiveOS, mmpOS, Docker), card models and counts (`4090 ×1`), the total hashrate and board
  power (and so TH/s per watt), the payout type (HeroMiners, Kryptex, unMineable, other pool), how long it has been
  running, and:
  - **per card:** its short model name (`4090`), hashrate, power, temperature, fan speed, the share of time it waited
    for the CPU, and whether it is tuned, tuning, waiting its turn or at stock, with its auto-tune mode;
  - **per card while it tunes:** its stage in plain words (measuring stock, finding its efficiency point, testing
    settings, confirming one, measuring the result, waiting its turn, backed off, paused, tuned, off), the share done,
    the time left and so far, the watts its Cool strength aims for, and how many steps it backed off (a count only);
    for the rig, the longest time left and the share done;
  - **health:** your accepted, rejected, stale and invalid share counts since the start, the number of GPU errors and
    how many GlintMiner recovered from by itself, how the previous run ended (cleanly, crashed, restarted itself after a
    GPU fault, stopped with an error, or stopped from outside), why in one word (a GPU stopped responding while
    tuning or otherwise, a GPU error, an update, a rollback, new settings, a stop by you or the system, a crash, or
    unknown) with the GPU's number when a GPU was the cause, how many times GlintMiner restarted itself in the last
    24 hours, the longest the cards kept mining a job after the pool had sent a newer one (a processor too busy to
    prepare new work in time) and, after a crash, the place in GlintMiner's code as a file name and line
    (`tune.rs:812`), never the error text;
  - **auto-tune's outcome:** off, tuning, tuned or partly tuned, the mode (Most hashrate, Less power, Best earnings, Cool and quiet and
    its strength) and how many cards are tuned, tuning, waiting or at stock;
  - **the dev fee's state:** paying through its own pool, paying through your pool (its own servers unreachable),
    idle because no fee server can be reached, reconnecting; the fee shares accepted and the share of work it took;
  - **updates:** your update setting (ask, automatic, off) and whether an update was rolled back;
  - the NVIDIA driver version and the CUDA version it supports;
  - the affiliate code your rig mines a share of the fee for, if you entered a recognised one (the code only, never the
    affiliate's wallet).
- **What is never sent:** your wallet, worker or rig name, pool address or login, Telegram details, host name, folder
  names, location, or any tuning detail (clocks, offsets, power limits, voltages, tuning steps). Your IP address is
  not stored; the server only uses it, in memory, to limit abuse. GlintMiner writes the same list in its log at start.
  The only time GlintMiner sends a wallet is the affiliate sign-up above: the payout wallet you type there, and only
  after you confirm it.
- **Why:** fee shares are rare (one every 10 to 60 minutes per rig), so they can't tell the developer how many rigs
  run which versions and cards, or whether the dev fee arrives. A rig that checks in but sends no fee shares shows a
  fee problem to look into.
- **How to turn it off:** start GlintMiner with `--no-telemetry` (HiveOS: in the flight sheet's extra config
  arguments; mmpOS: on the START line), or set `"telemetry": false` in `glint.json`. Mining is the same either way. A failed check-in is never
  shown and never slows mining.

## Built to be trusted

- **Every share is checked on your machine** with Pearl's own verifier before it is sent. If the Pearl network
  changes its rules, GlintMiner stops and asks you to update rather than sending work that would be rejected.
- **Stock settings unless you choose otherwise.** Out of the box GlintMiner never touches clocks, voltages or fans. It
  only eases the power limit down when a card runs hot. Auto-tune changes clocks only if you turn it on, and
  everything GlintMiner changes is put back when it closes, or on the next start after a crash.
- **No surprises.** Updates install only when you say so (or turn on automatic updates), and only a release signed
  with GlintMiner's release key; a version that doesn't run properly is rolled back. See [Updates](#updates).
- **Your settings stay with you,** in `glint.json` next to the program. Nothing is installed elsewhere.
- **Checksums for every file.** [Verify your download](docs/faq.md#verify-your-download) against `SHA256SUMS.txt`.

## Updates

GlintMiner checks GitHub once a day for a new version. What it does then is your choice (Settings → Updates, or
`--auto-update ask|auto|off`):

- **Ask** (the default): the dashboard and the console say *GlintMiner X is available*, with a few lines from its
  release notes, and you pick **Update now**, **Later** (asked again in about a day) or **Skip this version**.
- **Auto**: it installs the new version at a moment no card is in the middle of a tune, then restarts (about a minute
  without mining). If a tune keeps a card busy for a whole day, it asks instead.
- **Off**: no checks. **Check for updates now** (Settings → Updates) and `glint --update` still work.

Every update is checked before anything changes. `SHA256SUMS.txt` must carry a valid signature from GlintMiner's
release key, which is built into the program (a key that comes with a download is never trusted); the package and the
program inside it must match their lines in that file; the version must be newer than yours; and the new program is
started once to confirm it runs and is that version. If any check fails, nothing changes and GlintMiner says so. Your
settings, wallet, saved tunes and history stay, and an update never changes the dev fee.

The previous program is kept next to the new one (`glint.prev.exe`, or `glint.prev` on Linux). If the new version
fails at start, or stops again and again in its first 15 minutes, GlintMiner puts the previous one back, starts it and
tells you: *Update to X didn't run properly on this rig, so GlintMiner went back to Y.* That version isn't offered
again.

On **HiveOS** and **mmpOS** the system's own package manager installs GlintMiner, so it doesn't replace itself there:
it shows the exact package link to put in the flight sheet (or the custom miner). In **Docker** it tells you which
version to rebuild the image with.

From the command line: `glint --update` checks, verifies, installs and starts the new version (if GlintMiner is
already running on the PC, that copy updates itself); `glint --update 1.2.9` installs that release, an older one too
(1.2.8 or later: releases are signed from 1.2.8); add `--no-start` to install only.

## Verify your download

From 1.2.8 on, every release's `SHA256SUMS.txt` comes with `SHA256SUMS.txt.sig`, a signature made with GlintMiner's
release key. The public key is [glint-release.allowed_signers](glint-release.allowed_signers) in this repository:

```
glintminer namespaces="glintminer-release" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKatI61DofSq+DBJwEBpSf+j8vHqs33B4rCFOXYfOrBv
```

(key fingerprint `SHA256:LyJl6LdjKgkaI9MkBbkTsN0HHu6m12bRPrbpBWWqaPI`). Download both files and the key file into one folder, then run, with OpenSSH 8.1 or newer
(built into Linux, macOS and Windows 10/11; on Windows in Command Prompt, not PowerShell):

```
ssh-keygen -Y verify -f glint-release.allowed_signers -I glintminer -n glintminer-release -s SHA256SUMS.txt.sig < SHA256SUMS.txt
```

It must print `Good "glintminer-release" signature for glintminer`. Then check your download against its line in
`SHA256SUMS.txt` ([how](docs/faq.md#verify-your-download)). If either check fails, don't run it.

## Requirements

- NVIDIA RTX 20-series or newer (compute capability 7.5+ with tensor cores) with a current NVIDIA driver
- Windows 10/11 64-bit, or Linux x86-64 (glibc 2.17+); HiveOS, MMPOS and Docker are supported
- About 1.5 GB of system memory per GPU
- Nothing else to install: no CUDA toolkit or runtime
- For auto-tune: administrator (Windows) or root (Linux) rights. Without them GlintMiner simply mines at stock

## Support

Found a bug or have an idea? Open an [issue](../../issues) with your GPU, driver version, the output of
`glint --self-test` and the relevant lines from `glint.log`. More in [Getting help](docs/faq.md#getting-help).

Help and community: [Discord](https://discord.gg/dXBTwVzJNy). For help with your own rig, press **Get help** in
#private-help to open a private thread.

## Licence

GlintMiner is free to use for personal and commercial mining. The binaries are closed-source. See
[LICENSE.txt](LICENSE.txt), and `THIRD_PARTY_NOTICES.txt` for the open-source components it uses.
