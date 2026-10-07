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
HiveOS takes the miner's name from the package's file name, everything before the version: `glint-1.2.9.tar.gz` gives
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
In mainland China, add `--github-proxy https://v4.gh-proxy.org/` there so the affiliate code list and updates can be fetched ([why](faq.md#questions)).
An affiliate code goes there too: `--affiliate CODE` ([what it is](faq.md#questions)). To become an affiliate from the rig's shell, run `glint --become-affiliate --wallet <your mining wallet>` in the miner's folder (the wallet is only for the anonymous install id; nothing is sent until you type yes).

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

**And a memory underclock?**
A lower memory clock (a negative memory value in HiveOS, such as the -2000 many use for Pearl) isn't an overclock.
From 1.2.8 GlintMiner leaves it on: the card tunes and mines with it, and goes back to it whenever the card goes back
to stock. The log says *Your card's own memory underclock stays on while it tunes and mines.* A memory overclock
(a positive value) goes to factory settings for tuning like the rest of an overclock.

**What happens to my HiveOS overclock when GlintMiner stops?**
GlintMiner puts the card's own overclock and power limit back as it closes (or at its next start, after a crash). If
your overclock holds the card at a fixed clock, that part is released for tuning and GlintMiner doesn't put it back.

**Will GlintMiner notice if HiveOS applies an overclock while it runs?**
Yes (from 1.2.8). Applying an overclock in HiveOS, even just to change the fans, rewrites every card's clocks and
power limits. GlintMiner checks its cards every 30 seconds: a card in the middle of a tuning test gets the test's
settings back and runs that test again, and a tuned card gets its tune back, with a line in the log saying so. If a
tuned card's settings are changed again within the hour, GlintMiner takes it as meant and leaves them; the card says
so on the dashboard, and restarting the miner (`miner restart`) puts the tune back. It's still best to set fans before
you start a tune. GlintMiner can't see VRAM temperature (the NVIDIA driver doesn't report it on most cards); HiveOS
shows it.

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

**How do I tune just one card, or a few?**
List them after one `--tune-card`, by bus address, separated by commas with no spaces, for example
`--tune-card 0b:00.0=cool,11:00.0=cool:coolest --confirm-tuning` (plain `cool` is the rig's Cool and quiet strength,
`--cool-strength`, Cooler by default). Cards not listed keep your HiveOS overclock. Put `--tune-card`
only once (a second one, or a space inside the list, isn't read as part of it). The bus address is the grey number
under each GPU in HiveOS (`0b:00.0`, `11:00.0`, …). Before you apply it, set those cards' overclock in HiveOS to stock:
`0` for them in Core, Core lock, Memory and Power limit (one value per GPU, in HiveOS's order), so HiveOS and
GlintMiner never set the same card's clocks. **Leave the Fan as it is:** `0` there means the card's own automatic fan,
which at stock can let a card get hot enough for GlintMiner's temperature guard to stop it (tuning then can't finish).
A fixed speed of 70% or more is safest while a card tunes. Later you can tune the rest the same way, or the whole rig with
`--tune cool --confirm-tuning`: a card already tuned in that mode keeps its tune and isn't tuned again.

**Which NVIDIA driver does tuning need?**
470 or newer. Mining works on older drivers too. HiveOS rigs often run 535 or 550: from 1.2.8 GlintMiner tunes on
those with the driver's older clock controls (1.2.7 and earlier needed 555 or newer). With a driver too old, the card
says *Tuning needs a newer NVIDIA driver* and mines at stock; `nvidia-driver-update --list` shows the drivers HiveOS
offers, for example `nvidia-driver-update 570.211.01`, then reboot.

**Does GlintMiner have the rights it needs to tune?**
It checks for itself. If it can't change the card's settings, the card mines at stock, the log says *Tuning needs
administrator rights: … (on Linux, with sudo). Until then this card mines at stock.*, and the dashboard says
*Tuning can't start yet*.

**What does tuning look like in HiveOS?**
The card keeps mining the whole time, a little slower while it tunes; tuning takes about 1 to 1½ hours on a fast
card. Follow the progress and the result on GlintMiner's dashboard. More in
[While it tunes](auto-tune.md#while-it-tunes).

**My CMP 40HX mines about 45 TH/s. Can it do more?**
Usually, yes: the difference is the clock, not the miner. A CMP 40HX's hashrate follows its core clock (about 32-33
TH/s per GHz with GlintMiner), and at its factory voltage the card reaches its power limit at about 1,400 MHz, which is
the ~45 TH/s you see. At its rated 1,650 MHz it does about 52-54 TH/s; to get there within the same power the card needs
a lower voltage at that clock. In HiveOS that is a core clock lock at 1650 with a positive core offset (a published
tune for this card used +255; raise it in small steps and back off if the card errors or the rig freezes) and the power limit as high
as the card allows. A memory underclock (such as -2000) saves a few watts and doesn't cost hashrate. GlintMiner's
auto-tune (Speed) reaches the same kind of result by itself and checks each step for errors; it needs driver 470 or
newer, as above. Use one or the other, not both (see above).

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
In `/var/log/miner/glint/glint.log`. Everything GlintMiner prints goes there. Each time the miner starts, the previous
two runs' logs are kept as `glint.log.1` and `glint.log.2`, so after a restart the reason is still in `glint.log.1`. There is no `glint.log` in the miner's folder (the flight sheet passes `--no-log-file`).

**How do I send you diagnostics?**
In Hive Shell, run `/hive/miners/custom/glint/glint --diag`. It writes one file, `/home/user/glint-diag-….txt.gz`,
with the logs of the last runs, your cards, your settings and the GPU driver's error log. Your wallet and Telegram
details are blanked out, and nothing is sent anywhere. Download the file (for example with WinSCP: user `user`, your
rig's IP) and attach it to your message.

**Where is the technical detail of an error?**
On HiveOS it is on the same line, in square brackets after the plain sentence, for example the operating system's
error behind *No answer from … in time*.

**Why are the times in the log not my local time?**
They are in UTC.

## Updating and removing

**How do I update GlintMiner on HiveOS?**
When a new version is out, the dashboard and the console show its exact package link; GlintMiner never replaces
itself on HiveOS. Point the custom miner's **Installation URL** at the new version's `glint-….tar.gz` and apply the flight
sheet. We can't promise that HiveOS keeps the files in the miner's folder when it installs a new version, so keep
what matters in the flight sheet: options in **Extra config arguments** are applied at every start whatever happens to
`glint.json`. If saved tunes are lost, auto-tune simply tunes again.

**How do I stop using it?**
Apply a flight sheet that uses another miner. When GlintMiner is closed normally it puts back everything it changed
on the cards. If it was killed instead, restarting the rig clears what GlintMiner changed.

## Several cards

**Does it use every card in the rig?**
Yes, every supported NVIDIA card (RTX 20-series or newer). To leave some out, add `--devices 0,2` to **Extra config
arguments**. Allow about 1.5 GB of system memory per card.

**GlintMiner's GPU numbers don't match HiveOS's.**
GlintMiner numbers cards in CUDA's order, which on a rig with different cards can differ from the order HiveOS shows.
To see which is which, run `/hive/miners/custom/glint/glint --gpu-info` on the rig: it lists each card's number, name and PCI bus address. `--tune-card` also takes the bus address.

**How do I re-tune one card?**
On GlintMiner's dashboard: Rigs → the card's tuning panel → **Tune this card again (this mode)** (on the rig itself,
or with the remote-control code). Or in **Extra config arguments**: `--tune-card 07:00.0=efficiency --retune` (the
card's bus address or number, and the mode to tune again) tunes only that card again from stock, in that mode; its tunes
for other modes and the other cards' tunes are kept. To tune one mode again on every card and keep the others (a good
Less power tune, a Cool and quiet one to redo): `--retune cool:cooler` (or `speed`, `efficiency`, `profit`, `cool`).
`--retune` alone tunes every card again, in every mode. Remove `--retune` once the tune has begun: HiveOS passes the
Extra config arguments at every miner start, so left in, it starts the tune over from stock at every start.

**Why does a card run at lower power while another card tunes?**
A rig tunes one card at a time, which can take hours. Leaving the waiting cards at full stock power that whole time
wastes electricity and heats the rig — including the card being tuned, which can make its result less accurate. So
they run cooler until their turn: they mine a little less meanwhile (about a tenth less), and each gets its full
power back before its own turn. A card with its own core overclock or power limit keeps it. To cap the whole rig's
power while tuning, set a rig power budget. More in [Rigs with several cards](auto-tune.md#rigs-with-several-cards).

**GlintMiner keeps restarting itself while several cards tune together (`--tune-at-once`).**
Each card tuning runs at its full factory power limit; cards on a power limit of your own go there one at a time, 20
seconds apart, each in steps over about a minute, so the rig's draw rises gradually and AutoFan keeps up (the log says
at the start how much more it may draw). If the power supply still can't carry it, use `--tune-at-once 1` or
`--tune-power-budget`. Several cards measuring stock together all run at full power together, which some power
supplies and risers can't take. After three such hangs within half an hour, GlintMiner tunes the rest one card at a
time (*Several cards stopped responding while tuning together; tuning carries on one card at a time*). If cards still
keep stopping, or it restarts itself six times within 15 minutes while cards tune, tuning pauses: cards not yet tuned
mine at stock, tuned cards keep their tune, and the dashboard says why. Check the power supply and risers, then Resume
tuning (one card at a time) or Tune again on the dashboard. Restarts that keep coming with no card tuning wait longer
each time (5 minutes, up to half an hour) while the cards that still work keep mining. More in [Rigs with several
cards](auto-tune.md#rigs-with-several-cards).

## Messages and what they mean

| What you see in the log | What it means | What to do |
|---|---|---|
| *No NVIDIA GPU was found. GlintMiner needs an RTX 20-series or newer card.* | No card GlintMiner can use | Check the rig's cards and driver |
| *Your NVIDIA driver is too old for this GPU. Update to driver 570 or newer (580+ for RTX 50) and start again.* | The rig's driver is too old | Update the NVIDIA driver on the rig |
| *…is not supported: Pearl mining needs an RTX 20-series or newer* | That card is too old (GTX 10-series or older) | It is skipped; the others mine |
| *…is not supported: Pearl mining needs tensor cores (an RTX 20-series or newer)* | That card has no tensor cores (a GTX 16-series or similar) | It is skipped; the others mine |
| *The dashboard and stats API couldn't start: port 4078 is already in use…* | Another program uses the port | Stop it, or use `--api-port` |
| *Can't look up … — check this PC's internet or DNS settings.* | The rig can't look up the pool's name | Check the rig's network and DNS |
| *Your card had its own overclock; tuning starts from factory settings…* | Auto-tune is on and the card had an overclock | Expected; see [above](#auto-tune-and-hiveos-overclocking) |
| *The pool is not accepting our work (…). Pearl's rules may have changed…* | GlintMiner stopped rather than send work that would be rejected | Update GlintMiner |

More in [What the messages mean](auto-tune.md#what-the-messages-mean) and the
[troubleshooting table](faq.md#troubleshooting).
