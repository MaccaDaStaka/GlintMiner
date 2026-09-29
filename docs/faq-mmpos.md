# GlintMiner on MMPOS: FAQ

[← Back to the FAQ](faq.md) · **English** · [Русский](faq-mmpos.ru.md) · [简体中文](faq-mmpos.zh-CN.md)

Questions that come up when you run GlintMiner as an MMPOS custom miner, answered for how GlintMiner and its MMPOS
files work today. How to add a custom miner is MMPOS's own process; the files GlintMiner provides are described in
the [MMPOS guide](../mmpos/README.md).

- [Setting it up](#setting-it-up)
- [What the start command controls](#what-the-start-command-controls)
- [Stats in MMPOS](#stats-in-mmpos)
- [Auto-tune and MMPOS overclocking](#auto-tune-and-mmpos-overclocking)
- [Dashboard, logs and updates](#dashboard-logs-and-updates)

---

## Setting it up

**Which files do I use?**
The Linux release, `glint-…-linux.tar.gz` from the [Releases](https://github.com/MaccaDaStaka/GlintMiner/releases)
page. It contains the `glint` program and an `mmpos/` folder with the two MMPOS files: `mmp-external.conf` (the
miner's name, version, algorithm, start command and stats address) and `mmp-stats.sh` (reports stats to MMPOS).

**Which wallet can I use?**
In your mining profile, a Pearl address (`prl1…`) to be paid in PRL on HeroMiners, a Kryptex account (`krx…` or its
email) to be paid in BTC through Kryptex, or `COIN:address` (for example `BTC:bc1q…`) to be paid in that coin
through unMineable. [Which should I pick?](getting-started.md#choosing-how-youre-paid)

**Does GlintMiner ask setup questions on MMPOS?**
No. The wallet and worker name come on the command line, so it starts mining straight away and saves them to
`glint.json` next to the `glint` program the first time.

## What the start command controls

**Which command line does MMPOS start GlintMiner with?**
The `START` line in `mmp-external.conf`:

```
./glint --plain --no-log-file --wallet %WALLET% --worker %WORKER% --api-port 4078
```

MMPOS puts your profile's wallet and worker name in place of `%WALLET%` and `%WORKER%`.

**Which pool does it use? My profile's pool seems to be ignored.**
The start command passes no pool, so GlintMiner picks the pool from your wallet, as everywhere else: the nearest
HeroMiners server for a Pearl address, Kryptex for a Kryptex account, unMineable for `COIN:address`. To be paid in
PRL through Kryptex instead, add `--pool stratum+ssl://prl.kryptex.network:8048` to the `START` line.

**How do I add other options, like my electricity price or auto-tune?**
Add them to the `START` line, for example `--kwh-price 0.12 --currency EUR`. The full list is in
[All options](advanced.md#all-options). Options on the command line win over `glint.json` at every start, so a
setting you also change on the dashboard goes back to the command line's value at the next start. On MMPOS that is
the wallet, the worker name, the port, the plain console and no log file.

**Can I change the port?**
Keep it at 4078. Both the `START` line and `mmp-stats.sh` use 4078, and a port changed on the dashboard is replaced by
`--api-port 4078` at every start.

## Stats in MMPOS

**What does MMPOS get from GlintMiner?**
`mmp-stats.sh` reads `http://127.0.0.1:4078/api/stats` on the rig and reports the total hashrate (in H/s), accepted
and rejected shares, and each card's hashrate, temperature and power.

**MMPOS shows no stats.**
Look in the miner's output for *The dashboard and stats API couldn't start*: another program uses port 4078, so the
stats can't be read. Stop that program. Just after a start, the first figures take a minute or two.

## Auto-tune and MMPOS overclocking

**Should I use MMPOS overclocking and GlintMiner's auto-tune together?**
No, choose one per card. With auto-tune on, GlintMiner puts a card that has its own overclock to factory settings
before it tunes, and again each time it starts and puts a saved tune back on. While GlintMiner runs, the card mines
with GlintMiner's tune, not your MMPOS overclock. It puts your overclock and power limit back as it closes (if your
overclock holds the card at a fixed clock, that part isn't put back). Don't change the rig's overclock while a card
is tuning: GlintMiner doesn't notice changes made during a tune on Linux, and they spoil the result.

**What if auto-tune is off?**
GlintMiner never touches clocks. It only eases a card's power limit down when the card runs hot, and puts it back
when it stops.

**How do I turn auto-tune on?**
Add `--tune speed --confirm-tuning` (or `efficiency`, `cool`, or `profit` with `--kwh-price`) to the `START` line. Read
[Auto-tune](auto-tune.md) first. A card you want to keep on your MMPOS overclock can be left out with
`--tune-card 01:00.0=off` (by its PCI bus address, which `./glint --gpu-info` shows).

**Does GlintMiner have the rights to tune on MMPOS?**
It checks for itself. Without them the card mines at stock and the log says *Tuning needs administrator rights: …
(on Linux, with sudo). Until then this card mines at stock.*

## Dashboard, logs and updates

**Can I open GlintMiner's dashboard?**
Yes, from another computer: add `--api-bind 0.0.0.0` to the `START` line and open `http://<rig-ip>:4078`. It is
view-only from there; `--api-allow-remote-control` allows changes too, only on a network you trust. More in
[Headless rigs](phone-access.md#headless-rigs-hiveos-mmpos-linux).

**Where is the log?**
The start command passes `--no-log-file`, so there is no `glint.log`. Everything goes to the miner's console output,
with the technical detail of an error in square brackets after the plain sentence. Times are in UTC.

**How do I update?**
Replace the `glint` program with the one from the new Linux release, the same way you installed it, and keep
`glint.json` next to it: your settings and saved tunes carry on. GlintMiner tells you in its output when a new version
is out (*A newer GlintMiner (…) is available at …*); it never updates itself.

**Is there anything MMPOS-specific about temperatures or fans?**
GlintMiner never changes fan speeds, so MMPOS stays in charge of them. Its temperature guard works as everywhere
else: see [Temperature limits](auto-tune.md#temperature-limits).
