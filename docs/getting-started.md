# Getting started

[← Back to the README](../README.md) · **English** · [Русский](getting-started.ru.md) · [简体中文](getting-started.zh-CN.md)

Never mined before? This guide takes you from nothing to mining in a few minutes. You don't need any technical
knowledge, config files or command lines.

- [What you need](#what-you-need)
- [Choosing how you're paid](#choosing-how-youre-paid)
- [Download](#download)
- [Run it](#run-it)
- [The setup, question by question](#the-setup-question-by-question)
- [What you'll see](#what-youll-see)
- [When do I get paid?](#when-do-i-get-paid)
- [Updating](#updating)
- [Stopping and uninstalling](#stopping-and-uninstalling)

---

## What you need

1. **An NVIDIA graphics card from the RTX 30, 40 or 50 series**, for example an RTX 3060, 3080, 4070, 4090, 5060 or
   5090. If you play recent games on it, you almost certainly have one. Older cards (GTX, RTX 20) and AMD or Intel
   cards aren't supported.
2. **A recent NVIDIA driver.** If yours is more than a year old, update it from nvidia.com or the NVIDIA app first.
3. **Windows 10/11 (64-bit) or Linux.** Or a rig running HiveOS or MMPOS.
4. **About 1.5 GB of free memory (RAM) per graphics card.**
5. **Somewhere to be paid** (next section).

There is nothing else to install: no CUDA toolkit, no Python, no drivers beyond your normal NVIDIA one.

## Choosing how you're paid

GlintMiner mines **Pearl (PRL)**. You choose how you receive it:

| Option | You give | You receive | Fees on top of the 1% dev fee |
|---|---|---|---|
| **Pearl on HeroMiners** | A Pearl address (`prl1…`) | PRL, to your wallet | None |
| **Pearl on Kryptex** | A Pearl address (`prl1…`) | PRL, to your wallet, paid for every share | 2% |
| **Bitcoin/USDT/USDC via Kryptex** | A Kryptex account (`krx…` or your email) | BTC, withdrawable as BTC, USDT or USDC | 2% |
| **Another coin via unMineable** | That coin's address (Bitcoin, Litecoin, Dogecoin, Solana and about 25 more) | That coin, to your wallet | 1% |

**Which should I pick?**

- **Best value: a Pearl address on HeroMiners.** No conversion and no pool fee. Get a free Pearl address from the
  Pearl wallet app: open **Receive** and copy it.
- **Pearl, paid more evenly: the same address on Kryptex.** You give up 2%, and in return Kryptex pays you for every
  share you find, so your balance grows steadily instead of depending on the pool's luck. It sends your PRL to your
  wallet from 1 PRL.
- **Bitcoin or a stablecoin with no effort: a Kryptex account.** Make a free account at pool.kryptex.com (email only).
  Kryptex converts your Pearl to Bitcoin automatically and you withdraw BTC, USDT or USDC from your account. Kryptex
  charges 2% and doesn't publish its conversion rate, but by our estimate it's likely to pay noticeably more than
  converting through unMineable.
- **Another coin straight to your own wallet: use that coin's address.** Your exchange or wallet app shows it as your
  *Receive* or *Deposit* address. unMineable converts for a 1% fee, and GlintMiner shows unMineable's own estimate of
  what you'll receive.

If an address could belong to several coins (for example a `0x…` address), write the coin first, like
`USDT:0x…` or `DOGE:D…`. You can change how you're paid later in **Settings → Wallet and payout**.

## Download

Open the [latest release](https://github.com/MaccaDaStaka/GlintMiner/releases/latest) and download the file for your
computer:

| Your computer | Download |
|---|---|
| Windows 10 / 11 | `glint-…-windows.zip` |
| Linux | `glint-…-linux.tar.gz` |
| HiveOS rig | `glint-…-hiveos.tar.gz` (see [HiveOS](../hiveos/README.md)) |
| MMPOS rig | the Linux file (see [MMPOS](../mmpos/README.md)) |
| Docker | the Linux file (see [Docker](../docker/README.md)) |

Only download GlintMiner from this repository's Releases page. To check your download is genuine, see
[Verify your download](faq.md#verify-your-download).

## Run it

**Windows:** unzip the file to a folder of your choice, for example `C:\GlintMiner`, and double-click `glint.exe`.

> The first time, Windows may show **"Windows protected your PC"**. It shows this for new programs that haven't been
> downloaded widely yet. Click **More info**, then **Run anyway**. You only need to do this once.
>
> Your antivirus may also flag it. Antivirus programs flag cryptocurrency miners as a category, including genuine
> ones. If yours does, check the file's checksum ([how](faq.md#verify-your-download)) and allow it.

**Linux:** unpack it and run `./glint` in a terminal.

```
tar xzf glint-*-linux.tar.gz
cd glint
./glint
```

## The setup, question by question

The first time, GlintMiner asks a few questions. Every question is a number: type it and press **Enter** (Enter on
its own picks the first choice, shown in brackets).

```
  Welcome to GlintMiner. How do you want to be paid?
    1) Pearl to your Pearl wallet (HeroMiners, no fee)
    2) Pearl to your Pearl wallet (Kryptex, 2%, steady pay per share)
    3) Bitcoin/USDT/USDC via a Kryptex account (2%)
    4) Another coin to your own wallet (unMineable, 1%)
  Type 1-4 and press Enter [1]: 1

  Found a Pearl address on your clipboard:
    prl1pn0q...4syvu78w
    1) Use it
    2) Paste a different one
  Type 1 or 2 and press Enter [1]: 1
  -> Paid in PRL to your Pearl wallet, mining on HeroMiners (no pool fee).

  Name this rig on the pool:
    1) GAMING-PC (this computer)
    2) rig1
    3) Type one
  Type 1-3 and press Enter [1]: 1

  Electricity price (for profit after power)?
    1) Skip, set it later in the dashboard
    2) Enter it now  (currency from your system: EUR)
  Type 1 or 2 and press Enter [1]: 2
  Price per kWh (e.g. 0.12): 0.25
  Currency of that price:
    1) EUR
    2) USD
    3) GBP
    4) Other (type 3 letters)
  Type 1-4 and press Enter [1]: 1

  Tune your card? (you can change this any time)
  Tuning needs administrator rights: if you turn it on, setup can restart GlintMiner as administrator.
    1) Off, stock clocks (default)
    2) Speed: more hashrate
    3) Efficiency: less power
    4) Profit: the most profit after power
  Type 1-4 and press Enter [1]: 1

  Open the dashboard (charts, earnings, settings) in your browser at start?
    1) Yes
    2) No
  Type 1 or 2 and press Enter [1]: 1

  All set. Mining...
```

What each question is for:

- **How do you want to be paid?** See [Choosing how you're paid](#choosing-how-youre-paid).
- **Your address.** If you copied it before starting, GlintMiner finds it on the clipboard, so there's nothing to
  paste. It checks the address before using it.
- **Rig name.** How this PC appears on the pool's website. Use a different name on each PC if you have several.
- **Electricity price.** Optional. With it, GlintMiner shows profit after power, not just income. Your bill shows the
  price per kWh. The currency also sets how your earnings are shown.
- **Tune your card?** Optional and off by default. If you pick a mode, setup shows the risk in one sentence and turns
  tuning on only if you type **Y**. On Windows it offers to restart GlintMiner as administrator, which tuning needs.
  Say no and the card mines at stock. Read [Auto-tune](auto-tune.md) first.
- **Open the dashboard at start?** The dashboard is a web page served by GlintMiner on your own PC, with charts,
  earnings and settings.

GlintMiner saves your answers in `glint.json` next to the program, so next time it starts mining straight away. You can
change any of them later in the dashboard's **Settings**.

## What you'll see

**The console** (the black window) shows a live table: each card's hashrate, temperature, power, accepted shares, and
**how much you're earning per day**, plus the dev fee taken so far.

**The dashboard** is at **http://127.0.0.1:4078** in your browser while GlintMiner is running. Its Home page answers
four questions, most urgent first:

- **Is it working?** Green when all is well, or amber or red with the reason and the one thing to do.
- **What am I earning?** Profit per day after electricity (or income, if you haven't entered a price), today so far
  and the last 7 days.
- **Is my card at its best?** Whether auto-tune is on and what it gained, or its progress while it tunes.
- **When do I get paid?** Your balance on the pool, how close it is to the next payout, and your last payment.

The full tour is in [The dashboard](dashboard.md). You can also [watch it from your phone](phone-access.md).

> **Give it a few minutes.** Hashrate settles within a minute or two. Your pool's website and the pool figures on the
> dashboard lag behind by 10–30 minutes, because pools report averages. Your first payment can take a day or more
> (below).

## When do I get paid?

Your pool keeps a running balance for you and sends it to your wallet once it passes the pool's minimum payout:

- **HeroMiners (Pearl):** pays when your balance passes its minimum. Newly found blocks take a few hours to confirm
  before they count, so for one card the first payment can take a day or more.
- **Kryptex (Pearl):** credits you for every share, matures the credit, and sends it to your wallet from 1 PRL. The
  dashboard shows what is ready to pay, what is still maturing, and your rig as Kryptex sees it.
- **Kryptex account:** your balance builds up in your Kryptex account, which is private to you; check and withdraw it
  on kryptex.com.
- **unMineable:** pays in your coin once you pass that coin's minimum; the dashboard shows unMineable's figures.

The dashboard's **When do I get paid?** card shows your balance, about when the next payout comes and every payment
made to you (the latest few, with a link to the pool's full history).

> **Tip:** leave it running. Pools pay for steady work, and a card that mines around the clock earns far more than one
> started and stopped every evening.

## Updating

GlintMiner tells you when a new version is out (in the console and on the dashboard). It never downloads or installs
anything by itself. To update:

1. Close GlintMiner.
2. Download the new file from the [latest release](https://github.com/MaccaDaStaka/GlintMiner/releases/latest).
3. Unzip it into the same folder, replacing the files. Your settings (`glint.json`), history and benchmarks aren't in
   the zip, so they stay.
4. Start `glint.exe` again. It carries on mining with your settings.

On Linux, replace `glint`. On HiveOS, point the custom miner's installation URL at the new version.

## Stopping and uninstalling

- **To stop,** close the window or press **Ctrl+C**. Everything GlintMiner changed on your cards (power limits, and
  clocks if you use auto-tune) is put back as it closes.
- **To uninstall,** stop it and delete the folder. GlintMiner installs nothing else: no services, no registry
  entries, no background programs. (If you set it up as a Linux service or on a rig OS, remove it there too.)
