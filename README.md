<div align="center">

# GlintMiner

### Turn your NVIDIA graphics card into a Pearl miner, in about a minute.

**Choose how you're paid. Paste your address. Start earning.**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

### [⬇ Download GlintMiner 1.2.3](../../releases/latest)
Windows · Linux · HiveOS · free to use, 1% dev fee

**English** · [Русский](README.ru.md) · [简体中文](README.zh-CN.md)

<img src="images/dashboard-desktop.jpg" width="860" alt="The GlintMiner dashboard: is it working, what you're earning, how your card is tuned and when you get paid, at a glance">

</div>

---

GlintMiner mines **Pearl (PRL)** on NVIDIA GPUs. It is built to get the most Pearl out of every watt, and to be the
easiest miner to start: no config files, no batch scripts, no command lines to learn. It asks how you want to be paid
and where to send it, and then shows you, live, what your card is making in real money.

**New in 1.2.3:** faster mining on every card (about +1% on RTX 40, +1.8% on RTX 50, up to +3.6% more on cards
like the RTX 5090 and 3080 as work is now split evenly across the whole chip) · a smarter auto-tune (on our RTX 4090:
**+7.3% hashrate**, or stock speed on **24% less power**; Profit mode now weighs your electricity cost; each card on a
rig can have its own mode) · much smaller shares on Kryptex and HeroMiners (about 11–14 KB instead of 2 MB).

**New in 1.2:** a redesigned dashboard for phone and desktop, in English, Russian and Chinese · optional **auto-tune**
(on our RTX 4090: **+6% hashrate**, or stock speed on **24% less power**) · choose at setup to be paid in Pearl (on
HeroMiners or Kryptex), Bitcoin/USDT/USDC through Kryptex, or another coin.

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
| **Auto-tune: Speed** | **333 TH/s** (+7%) | 431 W | 0.77 |
| **Auto-tune: Efficiency** | 310 TH/s | **338 W** (−24%) | **0.92** |

<sub>GlintMiner 1.2.3 mining live on Kryptex, September 2026, one RTX 4090. Every chip is a little different, so
your card's result will be too.</sub>

- **More Pearl per watt.** Full speed at full power, and it keeps more of that speed when you limit the card's power
  for heat, noise or electricity cost.
- **1% all-in for Pearl payouts.** Our 1% fee, and HeroMiners charges no pool fee. You can watch the fee being taken.
- **Paid in the coin you want.** Mine to a Pearl wallet, or to Bitcoin, Litecoin, Dogecoin, Solana and around 25 more.
- **Know what you earn.** Daily earnings in USD, EUR, GBP or your own currency, and profit after power if you enter
  your electricity price.
- **Looks after your hardware.** Every card's temperature is watched. A card that runs hot has its power eased
  down, and one near its limit pauses until it cools. The temperature limit is automatic, from your card's own safe
  maximum (80 °C at stock and 83 °C tuned on an RTX 4090), never above it; you can set your own in Settings.
- **Get more from your card, if you want it.** Optional [auto-tune](#auto-tune-optional) finds your card's best
  stable setting while it mines: more hashrate, or the same hashrate on much less power.
- **Set it and forget it.** Watchdog, automatic pool failover, encrypted (TLS) pool connections, and plain-language
  messages when something needs your attention.

<p align="center">
  <img src="images/phone-home.jpg" width="260" alt="The dashboard on a phone: is it working, profit per day and the tuning result">
  &nbsp;&nbsp;
  <img src="images/phone-tuned.jpg" width="260" alt="A card after auto-tune: +6.3% hashrate against stock, on less power">
</p>
<p align="center"><sub>The dashboard on a phone: your earnings at a glance, and a card after auto-tune.</sub></p>

---

## New to mining? Start here

Never mined before? This takes a few minutes and needs no technical knowledge.

### What you need

1. **An NVIDIA graphics card** from the RTX 30, 40 or 50 series (for example an RTX 3060, 4070 or 5060), with a
   recent NVIDIA driver. If you play games on it, you almost certainly have one.
2. **Where to send your earnings.** You have three choices:
   - **A Pearl address** (it starts with `prl1`). You are paid in PRL, Pearl's own coin. The setup then offers two
     pools: **HeroMiners** (no pool fee) or **Kryptex** (2% fee; it pays for every share you find, so your balance
     grows steadily, and sends it to your wallet from 1 PRL).
   - **An address for a coin you already use**, such as Bitcoin, Litecoin, Dogecoin or Solana. Your crypto exchange
     or wallet app shows it as your "receive" or "deposit" address. GlintMiner mines Pearl, and unMineable converts it
     and pays you in that coin.
   - **A Kryptex account ID** (it starts with `krx`, from a free account at pool.kryptex.com, email only). Kryptex
     converts your Pearl to Bitcoin automatically, and you can withdraw it as **BTC, USDT or USDC** from your Kryptex
     account.

   Not sure which to choose?
   - **Best value:** a **Pearl address** on HeroMiners. There's no conversion and no pool fee. You can get one free
     from the Pearl wallet app (open **Receive**).
   - **Pearl, paid more evenly:** the same Pearl address on **Kryptex**. You give up 2%, and in return you're paid for
     every share instead of waiting on the pool's luck.
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

**3. Answer the setup.** Every question is a number: type it and press Enter (Enter alone picks the first choice). If you've
copied your address, GlintMiner finds it on the clipboard, so there's nothing to paste. It suggests your computer's
name for the rig and your system's currency for the electricity price, and asks whether to turn on
[auto-tune](#auto-tune-optional) (off unless you choose it).

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

If you pick a tuning mode, setup shows the risk in one sentence and turns tuning on only if you type **Y**. It tells
you the card's automatic temperature limit and, on Windows, offers to restart GlintMiner as administrator (tuning
needs it; Windows asks you to allow it). Say no and the card mines at stock; GlintMiner offers again each time it
starts.

You're mining. GlintMiner remembers your answers, so next time it starts straight away.

### What you'll see

A live view of every card: speed, temperature, power, accepted shares and **how much you're earning per day**. For
more, open the dashboard at **http://127.0.0.1:4078** while GlintMiner is running (it can open by itself when
GlintMiner starts). Its Home page answers four questions, most urgent first:

- **Is it working?** One line: green when all is well, or amber or red with the reason and the one thing to do.
- **What am I earning?** Profit per day after electricity (or income, if you haven't entered a price), today so far
  and the last 7 days.
- **Is my card at its best?** Whether auto-tune is on and what it gained (for example "Tuned +6.3%"), or its progress
  and time left while it tunes.
- **When do I get paid?** Your balance on the pool, how close it is to the next payout, about when that comes, and
  your last payment.

**Earnings** has the daily figures, a projection and your pool payments; **Rigs** has every card and the tuning
controls; **Settings** has how you're paid, electricity price, tuning, temperature limit, who can open the dashboard
and language. It works on a phone too, speaks English, Russian and Chinese, and keeps this rig's estimate separate from
your wallet's balance and payments on the pool.

### When do I get paid?

Your mining pool keeps a running balance for you and sends it to your wallet once it passes the pool's minimum
payout. For a single card this can take a day or more; newly found blocks take a few hours to confirm before they
count. The dashboard's **When do I get paid?** shows your balance, about when the next payout comes and every payment
made to you. For Pearl on Kryptex it shows Kryptex's own figures: what is ready to pay and what is still maturing,
how close you are to the 1 PRL payout, and your rig's hashrate as Kryptex sees it. A Kryptex account's balance is
private to your account, so you check that on kryptex.com.

> **Tip:** leave it running. Pools pay for steady work, and a card that mines around the clock earns far more than
> one started and stopped every evening.

---

## The 1% developer fee, in the open

- About one second in every hundred, per card, mines for the developer. Your pool sees a steady hashrate, without
  the minute-long gaps some miners create.
- The live view and dashboard show the fee rate and the exact amount taken so far. Nothing else is taken, ever.
- If the fee server can't be reached you keep mining normally. The missed amount is made up gradually later,
  capped at about an hour's worth.
- The fee's shares carry an anonymous label: the card models and counts, the payout type, the GlintMiner version and
  whether the cards are tuned (for example `g4687ad-hmv123s-4090x1`), so the developer can see how GlintMiner is used.
  Never your wallet, rig name, IP address or location.

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

## Check your miner from your phone, anywhere (Tailscale)

[Tailscale](https://tailscale.com) (free for personal use) links your own devices privately, so your phone can open
the dashboard from anywhere without opening your PC to the internet.

1. Install Tailscale on the mining PC and on your phone, and sign in to the same account on both.
2. In the dashboard, go to **Settings → Dashboard → Who can open it**, choose **Other devices, e.g. your phone at home
   or via Tailscale — view only**, save, and restart GlintMiner. Other devices get a view-only dashboard (add
   `--api-allow-remote-control` if you want to change settings from them too).
3. Let the dashboard's port through the firewall, for Tailscale only.
   - **Windows:** open PowerShell as administrator and run:
     ```
     New-NetFirewallRule -DisplayName "GlintMiner dashboard (Tailscale)" -Direction Inbound -Protocol TCP -LocalPort 4078 -RemoteAddress 100.64.0.0/10 -Action Allow
     ```
     If Windows asks about the firewall when GlintMiner starts, don't tick Public networks.
   - **Linux / HiveOS:** Tailscale usually handles this itself. If you use ufw: `ufw allow in on tailscale0 to any port 4078`.
4. On your phone, open `http://100.x.y.z:4078` (the PC's Tailscale address, shown in the Tailscale app), or
   `http://your-pc-name:4078`, or its full `your-pc-name.your-tailnet.ts.net` name.

**Never forward port 4078 on your router.** That would open the dashboard to the whole internet.

Other ways to keep an eye on it:
- **Your pool's website:** search for your wallet address to see your hashrate and balance.
- **Telegram alerts:** a message when a card stops or the pool is lost (`--telegram-token` and `--telegram-chat`, or
  Settings → Telegram alerts).

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
| **Profit** | The most money after electricity: runs the Speed or the Efficiency result, whichever earns more at today's prices (needs your electricity price) |

Turn it on in the dashboard (**Settings → Tuning**), or with `glint --tune speed --confirm-tuning` (or `efficiency`,
`profit`). `--confirm-tuning` is needed once, to confirm you accept the risk below; `--tune off` turns it off. It needs
GlintMiner to run as administrator (Windows) or root (Linux); on Windows, GlintMiner offers to restart itself as
administrator when tuning is on. Tuning takes about an hour on a fast card (about 25 minutes in Efficiency mode), and
the card keeps mining meanwhile. The dashboard shows its progress and time left, then the outcome (for example
**Tuned +6.3%**); the result is saved and re-applied at every start. While a card is tuned, its automatic temperature
limit is the card's own safe maximum.

Profit mode finds both results first (so its first run takes longer), then looks at the coin price and your
electricity price every half hour and switches only when the other result earns clearly more. In Speed mode, a card
that later runs clearly cooler than when it was tuned (a cold night, a better case) is tuned a little further, at most
once a day, and keeps its saved result as the fallback.

**A mode for each card.** On a rig with several cards, each card can have its own mode: for example Speed on one card,
Efficiency on another, and another kept at stock. Cards you don't set follow the rig's mode. Set it in **Settings →
Tuning** (the list of cards under the rig's mode) or on each card in **Rigs**, where you can also tune one card again
or pause it while the others keep mining with their tunes. The Home screen sums it up, for example *2 of 3 cards
tuned: GPU 0 +6.4%, GPU 1 −22% power; GPU 2 at stock*. On the command line:
`glint --tune-card 0=speed,1=efficiency,2=off --confirm-tuning`. A card keeps its mode when the cards are renumbered
(it's stored by the card's slot), and switching a card back to a mode it was tuned in re-uses that result.

**The risk, plainly:** auto-tune runs your card outside its factory settings. It backs off at the first error, never
overclocks memory, never goes above your card's own power maximum, and puts everything back when GlintMiner closes
(or on the next start after a crash). But an unstable setting can still crash the miner or, rarely, the display
driver. You turn it on at your own risk, and it stays off unless you do.

## For rig owners and power users

Everything the setup asks can also be given on the command line:

```
glint --wallet prl1... --worker rig1
glint --wallet prl1... --pool stratum+ssl://prl.kryptex.network:8048
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
| `--tune-card 0=speed,1=efficiency,2=off` | A mode for each card (`default` = follow `--tune`); cards not listed follow `--tune` |
| `--retune` | Forget the saved tunes and tune every card again |
| `--tune-exclude 0,2` | Keep these cards at stock while the others tune (same as `--tune-card 0=off,2=off`) |
| `--tune-reset` | Forget saved tunes, per-card modes and exclusions, and turn tuning off |
| `--share-diff N` | Kryptex only: the share difficulty to ask for (0 = automatic) |
| `--api-bind 0.0.0.0` | View the dashboard from other devices on your network (view-only) |
| `--api-allow-remote-control` | Also allow changes from those devices (only on a network you trust) |
| `--telegram-token`, `--telegram-chat` | Get alerts on Telegram |
| `--plain` | Plain log lines, for services and rig operating systems |
| `--save` | Save these options to `glint.json` |
| `--config PATH` | Use another settings file (default: `glint.json` next to `glint`) |

Diagnostics: `--self-test`, `--gpu-info`, `--bench 60`, `--benchmarks`. Full list: `glint --help`.

**On HeroMiners**, shares are sent compressed too (about 14 KB instead of 2 MB each): if a HeroMiners server ever
refuses them, GlintMiner sends that server's shares uncompressed for the rest of the run.

**On Kryptex**, shares are sent compressed (about 11 KB instead of 2 MB each) whenever Kryptex agrees at login: less
traffic and fewer stale shares on a slow connection. A big rig (above 500 TH/s) automatically asks Kryptex for a higher
share difficulty, about one share every 30 seconds, so it doesn't flood the pool with shares; set your own with
`--share-diff N` (Kryptex's default is 2097152; its formula is hashrate in H/s × seconds per share ÷ 4294967296). Your
earnings don't change: each share simply counts for more.

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

**Is it slower than it should be?**
Close other apps that use the graphics card while you mine, like animated or video wallpapers, games or video
editors: they take a share of the card and it mines slower (auto-tune also reads them as a slower card).

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
