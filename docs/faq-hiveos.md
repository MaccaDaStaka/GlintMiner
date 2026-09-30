# GlintMiner on HiveOS: FAQ

[← Back to the FAQ](faq.md) · **English** · [Русский](faq-hiveos.ru.md) · [简体中文](faq-hiveos.zh-CN.md)

Questions that come up when you run GlintMiner as a HiveOS custom miner, answered for how GlintMiner and its HiveOS
package work today. The step-by-step setup is in the [HiveOS guide](../hiveos/README.md).

- [Setting it up](#setting-it-up)
- [What the flight sheet controls](#what-the-flight-sheet-controls)
- [Stats in HiveOS](#stats-in-hiveos)
- [Auto-tune and HiveOS overclocking](#auto-tune-and-hiveos-overclocking)
- [Temperature and power](#temperature-and-power)
- [GlintMiner's own dashboard](#glintminers-own-dashboard)
- [Logs](#logs)
- [Updating and removing](#updating-and-removing)
- [Several cards](#several-cards)
- [Messages and what they mean](#messages-and-what-they-mean)

---

## Setting it up

**Which file do I use?**
`glint-….tar.gz` from the [Releases](https://github.com/MaccaDaStaka/GlintMiner/releases) page: its link goes
in the custom miner's **Installation URL**. It holds the `glint` program and the four HiveOS files: `h-manifest.conf`,
`h-config.sh` (builds the command line), `h-run.sh` (starts the miner) and `h-stats.sh` (reports stats to HiveOS).

**What goes in the flight sheet?**
Miner name `glint`, hash algorithm `pearl`, wallet and worker template `%WAL%`, and optionally a Pool URL and extra
arguments. Step by step in the [HiveOS guide](../hiveos/README.md).

**Which wallet can I use?**
A Pearl address (`prl1…`) to be paid in PRL on HeroMiners, a Kryptex account (`krx…` or its email) to be paid in
BTC through Kryptex, or `COIN:address` (for example `BTC:bc1q…`) to be paid in that coin through unMineable. To be
paid in PRL through Kryptex instead of HeroMiners, add `stratum+ssl://prl.kryptex.network:8048` as the Pool URL.
[Which should I pick?](getting-started.md#choosing-how-youre-paid)

**The miner doesn't start and says "CUSTOM_TEMPLATE (wallet) is empty".**
The flight sheet's wallet and worker template is empty. Set it to `%WAL%` and make sure the flight sheet's wallet has
an address.

**Nothing happens, and `miner` says "There is no screen to be attached matching miner"; or HiveOS says the custom miner name should be "glint-1.2.6".**
HiveOS takes the miner's name from the package's file name, everything before the version: `glint-1.2.7.tar.gz` gives
`glint`, the folder inside the package. Packages up to 1.2.6 were named `glint-…-hiveos.tar.gz`, which HiveOS reads as a
miner called `glint-1.2.6`, so they can't be installed as a HiveOS custom miner. Use the HiveOS package named
`glint-<version>.tar.gz` and set the **Miner name** to `glint`. Also check the template is `%WAL%` alone (GlintMiner
adds the rig name itself; `%WAL%.%WORKER_NAME%` makes the address invalid) and that a Pool URL, if you set one, starts
with `stratum+ssl://`. `miner log` shows why a start failed.

**Does GlintMiner ask any setup questions on HiveOS?**
No. HiveOS gives it the wallet and rig name on the command line, so it starts mining straight away.

## What the flight sheet controls

**Which command line does HiveOS start GlintMiner with?**
`h-config.sh` builds it from the flight sheet:

```
--wallet <your wallet> --worker <rig name> --plain --no-log-file --config /hive/miners/custom/glint/glint.json
```

plus `--pool <Pool URL>` when you set one, plus your **Extra config arguments**.

**What name does my rig have on the pool?**
The rig's name in HiveOS, used as the worker name. Pools take letters, digits, `-` and `_`, so anything else
(spaces, `#`, `.`) is dropped: a rig called `my rig#1` mines as `myrig1`.

**I changed my wallet (or worker, or console setting) on GlintMiner's dashboard, and it went back after a restart.**
Options on the command line win over GlintMiner's settings file at every start. On HiveOS the flight sheet always
sets the wallet, the worker name, the plain console and no log file, and the pool when you gave one. Change those in
the flight sheet. Settings that aren't on the command line (electricity price, temperature limit, tuning mode set on
the dashboard, Telegram alerts) are kept.

**Where are GlintMiner's settings kept on the rig?**
In `/hive/miners/custom/glint/glint.json`. Saved tunes, the history behind the dashboard's charts and benchmark
results are kept in the same folder.

**How do I add other options?**
Put any GlintMiner options in **Extra config arguments**, for example `--kwh-price 0.12 --currency EUR`. The full list
is in [All options](advanced.md#all-options).

## Stats in HiveOS

**Do I need to set anything up for HiveOS to show hashrate and temperatures?**
No. `h-stats.sh` reads GlintMiner's stats from `http://127.0.0.1:4078/api/stats` on the rig and gives HiveOS the
hashrate, temperatures, fan speeds, accepted, rejected and stale shares, uptime and version.

**Can I change GlintMiner's port?**
Yes, but only with `--api-port` in **Extra config arguments**: `h-stats.sh` reads the port from there. A port changed
on GlintMiner's dashboard isn't followed, and HiveOS would show no stats.

**HiveOS shows 0 hashrate, but the miner is running.**
Just after a start, the first figures take a minute or two. If it stays at 0, open the miner's log and look for *The
dashboard and stats API couldn't start*: another program already uses the port, and the stats can't be read. Close
the other program, or give GlintMiner another port with `--api-port`.

**Why does my pool show less than HiveOS?**
Pools report a 30-minute average and lag 10–30 minutes behind. GlintMiner's figure is measured on your cards. See
[the FAQ](faq.md#questions).

## Auto-tune and HiveOS overclocking

**Should I use HiveOS overclocking and GlintMiner's auto-tune together?**
No, choose one per card. With auto-tune on, GlintMiner puts a card that has its own overclock (for example the
overclock HiveOS sets for the rig) to factory settings before it tunes, and again each time it starts and puts a
saved tune back on. So while GlintMiner runs, the card mines with GlintMiner's tune, not your HiveOS overclock. The
log says so: *Your card had its own overclock; tuning starts from factory settings and puts yours back when
GlintMiner closes.*

**What happens to my HiveOS overclock when GlintMiner stops?**
GlintMiner puts the card's own overclock and power limit back as it closes (or at its next start, after a crash). If
your overclock holds the card at a fixed clock, that part is released for tuning and GlintMiner doesn't put it back.

**Will GlintMiner notice if HiveOS applies an overclock while it tunes?**
No. GlintMiner looks for other tuning programs only on Windows, so an overclock applied during a tune goes
unnoticed and spoils the result. Don't change the rig's overclock while a card is tuning.

**What if auto-tune is off?**
Then GlintMiner never touches clocks, and your HiveOS overclock works as it always has. The only thing GlintMiner may
change is the power limit, lowered when a card runs hot and put back when GlintMiner stops.

**How do I turn auto-tune on for a HiveOS rig?**
Add `--tune speed --confirm-tuning` to **Extra config arguments** (or `efficiency`, `cool`, or `profit` together with
`--kwh-price`). `--confirm-tuning` says you accept the risk; read [The risk, plainly](auto-tune.md#the-risk-plainly)
first. Because it is in the flight sheet, that mode applies at every start. You can also turn it on from GlintMiner's
dashboard on another computer, if you allow changes from there (see
[the dashboard](#glintminers-own-dashboard) below).

**Can I tune some cards and keep my HiveOS overclock on others?**
Yes. A card whose mode is **Off** is left exactly as HiveOS set it. For example `--tune speed --confirm-tuning
--tune-card 01:00.0=off` tunes every card except the one at PCI bus `01:00.0`. Naming the card by its bus address
avoids confusion, because GlintMiner's card numbers can differ from HiveOS's (see [Several cards](#several-cards)).

**Does GlintMiner have the rights it needs to tune?**
It checks for itself. If it can't change the card's settings, the card mines at stock, the log says *Tuning needs
administrator rights: … (on Linux, with sudo). Until then this card mines at stock.*, and the dashboard says
*Tuning can't start yet*.

**What does tuning look like in HiveOS?**
The card keeps mining the whole time, a little slower while it tunes; tuning takes about 1 to 1½ hours on a fast
card. Follow the progress and the result on GlintMiner's dashboard. More in
[While it tunes](auto-tune.md#while-it-tunes).

## Temperature and power

**Does GlintMiner fight HiveOS over fans?**
No. GlintMiner never changes fan speeds, so HiveOS stays in charge of them.

**How does GlintMiner handle a hot card?**
Above the card's temperature limit it eases the power limit down, and near the card's shutdown point it pauses that
card until it has cooled; the others keep mining. It puts every power limit it changed back when it stops. Set the
limit on the dashboard (**Settings → Temperature and power**) or leave it automatic, read from the card. More in
[Temperature limits](auto-tune.md#temperature-limits).

## GlintMiner's own dashboard

**Can I see GlintMiner's dashboard for a HiveOS rig?**
Yes, from another computer on your network: add `--api-bind 0.0.0.0` to **Extra config arguments** and open
`http://<rig-ip>:4078`. It shows earnings, payouts and the tuning result that HiveOS doesn't.

**Why can't I change anything on it?**
From any device other than the rig itself the dashboard is view-only. To allow changes from your computer, add
`--api-allow-remote-control` as well. Only do that on a network you trust: anyone who can reach the page can then
change settings.

**The page shows only the word "forbidden".**
Open it by the rig's IP address, a plain name without dots, a `.local` name or a Tailscale `.ts.net` name. Names in
other domains (like `rig.lan`) are refused, to protect you from malicious web pages.

**Can I watch it from my phone when I'm away?**
Yes, with Tailscale on the rig and your phone. See [Phone access](phone-access.md#from-anywhere-with-tailscale).

## Logs

**Where is GlintMiner's log on HiveOS?**
In `/var/log/miner/glint/glint.log`. Everything GlintMiner prints goes there. It is started afresh each time the
miner starts. There is no `glint.log` in the miner's folder (the flight sheet passes `--no-log-file`).

**Where is the technical detail of an error?**
On HiveOS it is on the same line, in square brackets after the plain sentence, for example the operating system's
error behind *No answer from … in time*.

**Why are the times in the log not my local time?**
They are in UTC.

## Updating and removing

**How do I update GlintMiner on HiveOS?**
Point the custom miner's **Installation URL** at the new version's `glint-….tar.gz` and apply the flight
sheet. We can't promise that HiveOS keeps the files in the miner's folder when it installs a new version, so keep
what matters in the flight sheet: options in **Extra config arguments** are applied at every start whatever happens to
`glint.json`. If saved tunes are lost, auto-tune simply tunes again.

**How do I stop using it?**
Apply a flight sheet that uses another miner. When GlintMiner is closed normally it puts back everything it changed
on the cards. If it was killed instead, restarting the rig clears what GlintMiner changed.

## Several cards

**Does it use every card in the rig?**
Yes, every supported NVIDIA card (RTX 30-series or newer). To leave some out, add `--devices 0,2` to **Extra config
arguments**. Allow about 1.5 GB of system memory per card.

**GlintMiner's GPU numbers don't match HiveOS's.**
GlintMiner numbers cards in CUDA's order, which on a rig with different cards can differ from the order HiveOS shows.
To see which is which, run `/hive/miners/custom/glint/glint --gpu-info` on the rig: it lists each card's number, name and PCI bus address. `--tune-card` also takes the bus address.

## Messages and what they mean

| What you see in the log | What it means | What to do |
|---|---|---|
| *No NVIDIA GPU was found. GlintMiner needs an RTX 30-series or newer card.* | No card GlintMiner can use | Check the rig's cards and driver |
| *Your NVIDIA driver is too old for this GPU. Update to driver 550 or newer (580+ for RTX 50) and start again.* | The rig's driver is too old | Update the NVIDIA driver on the rig |
| *…is not supported: Pearl mining needs an RTX 30-series or newer* | That card is too old | It is skipped; the others mine |
| *The dashboard and stats API couldn't start: port 4078 is already in use…* | Another program uses the port | Stop it, or use `--api-port` |
| *Can't look up … — check this PC's internet or DNS settings.* | The rig can't look up the pool's name | Check the rig's network and DNS |
| *Your card had its own overclock; tuning starts from factory settings…* | Auto-tune is on and the card had an overclock | Expected; see [above](#auto-tune-and-hiveos-overclocking) |
| *The pool is not accepting our work (…). Pearl's rules may have changed…* | GlintMiner stopped rather than send work that would be rejected | Update GlintMiner |

More in [What the messages mean](auto-tune.md#what-the-messages-mean) and the
[troubleshooting table](faq.md#troubleshooting).
