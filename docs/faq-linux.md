# GlintMiner on Linux: FAQ

[← Back to the FAQ](faq.md) · **English** · [Русский](faq-linux.ru.md) · [简体中文](faq-linux.zh-CN.md)

Questions that come up when you mine with GlintMiner on a Linux desktop or server, answered for how GlintMiner works
today. Rig operating systems have their own pages: [HiveOS](faq-hiveos.md), [MMPOS](faq-mmpos.md) and
[Docker](faq-docker.md).

- [Requirements](#requirements)
- [Installing and first run](#installing-and-first-run)
- [Running it in the background](#running-it-in-the-background)
- [Root rights](#root-rights)
- [Auto-tune on Linux](#auto-tune-on-linux)
- [Temperature and power](#temperature-and-power)
- [The dashboard on a desktop or a headless rig](#the-dashboard-on-a-desktop-or-a-headless-rig)
- [Logs](#logs)
- [Updating and uninstalling](#updating-and-uninstalling)
- [Several cards](#several-cards)
- [Messages and what they mean](#messages-and-what-they-mean)

---

## Requirements

**Which Linux does it run on?**
64-bit x86 Linux with glibc 2.17 or newer, which covers practically every distribution still in use. Besides glibc
it needs nothing but the NVIDIA driver: no CUDA toolkit, no OpenSSL, no Python.

**Which NVIDIA driver do I need?**
NVIDIA's own driver (from nvidia.com or your distribution's NVIDIA packages), version 550 or newer, and 580 or newer
for RTX 50 cards. GlintMiner loads two libraries that come with it: `libcuda.so.1` for mining and `libnvidia-ml.so.1`
for temperatures, power and tuning. The open-source nouveau driver can't mine.

**Which cards?**
NVIDIA RTX 20, 30, 40 and 50-series (compute capability 7.5 with tensor cores, or 8.0 and newer), and the CMP 40HX
mining card. GTX 16-series cards and the CMP 30HX have no tensor cores and can't mine. `glint --gpu-info` lists what
GlintMiner sees.

**How much memory?**
About 1.5 GB of system memory (RAM) per card.

## Installing and first run

**Which file do I download?**
`glint-…-linux.tar.gz` from the [latest release](https://github.com/MaccaDaStaka/GlintMiner/releases/latest). It
unpacks to a `glint` folder with the `glint` program, the READMEs and these guides, the changelog, the licence files,
a systemd unit (`glint.service`), and the files for [MMPOS](faq-mmpos.md) (`mmpos/`) and [Docker](faq-docker.md)
(`docker/`).

**How do I start it?**

```
tar xzf glint-*-linux.tar.gz
cd glint
./glint
```

The first time, it asks how you want to be paid and a few more questions ([Getting started](getting-started.md)).
Setup needs a terminal. Started without one and without a wallet, GlintMiner stops with *no wallet configured: run
glint in a terminal for the setup, or pass --wallet ADDRESS*. With `--wallet` on the command line it skips setup and
saves your options to `glint.json` the first time.

**Setup didn't find my address on the clipboard.**
On Linux GlintMiner reads the clipboard only inside a desktop session, with `wl-paste` (Wayland) or `xclip` or `xsel`
(X11). Over SSH, or without one of those tools, just paste the address when setup asks for it.

**Where does GlintMiner keep its files?**
Next to the `glint` program: `glint.json` (settings and saved tunes), `glint.log`, `glint-history.jsonl` and
`glint-benchmarks.json`. `glint.json` is readable only by the user who saved it, because it can hold a Telegram bot
token. With `--config /path/rig.json` they go next to that file instead.

**The dashboard didn't open in my browser.**
GlintMiner opens it (with `xdg-open`) only when it runs in a desktop session and without `--plain`. On a server, or
over SSH, open the address yourself; see [the dashboard](#the-dashboard-on-a-desktop-or-a-headless-rig) below.

## Running it in the background

**How do I run it as a service that starts at boot?**
The download includes a systemd unit, `glint.service`:

1. Put the `glint` folder's contents in `/opt/glint`.
2. Copy `glint.service` to `/etc/systemd/system/` and put your wallet (and worker name) in its `ExecStart` line.
3. Run `systemctl enable --now glint`.

GlintMiner then starts at boot and systemd starts it again 10 seconds after it stops for any reason. The unit runs it
as root, so the temperature guard and auto-tune can change the card's settings, and with `--plain`, so its output
reads cleanly in the journal.

**I changed a setting on the dashboard, but after a restart the service uses the old one.**
Options on the command line win over `glint.json` at every start. Whatever is in the unit's `ExecStart` line (the
wallet, the worker name, plain console) is applied each time, so change those in the unit, then run `systemctl
daemon-reload` and `systemctl restart glint`. Settings you don't put on the command line are kept from the dashboard.

**How do I stop it?**
In a terminal, press **Ctrl+C**. As a service, `systemctl stop glint`. GlintMiner also stops cleanly when it gets
SIGTERM or SIGHUP (closing the terminal). Each way, it first puts back everything it changed on the cards.

**What if it is killed with `kill -9` or the machine loses power?**
The next start tidies up first: before any card mines, cards that auto-tune had changed are put back, and the log says
*auto-tune: GlintMiner didn't close cleanly last time; 1 card(s) put back to stock*. A power limit that only the
temperature guard had lowered isn't part of that record, so it may not return to what it was until the machine
restarts.

**Can I run it in `screen` or `tmux` instead?**
Yes; it behaves like in any terminal. Detach and it keeps mining.

## Root rights

**Do I need root?**
Not to mine. Root is needed only to change a card's settings:

- to ease a card's power limit down when it runs hot,
- for profit mode (`--profit-mode`),
- for [auto-tune](auto-tune.md).

The *hard stop*, which pauses a card near its shutdown point, works without root. Setup tells you when tuning needs
it: *Tuning needs root (sudo): until then your card simply mines at stock.*

**How do I run it with root rights?**
`sudo ./glint`, or as the systemd service above (which runs as root). On Linux GlintMiner can't restart itself with
root rights the way it offers to on Windows.

**After using `sudo` once, it fails with "Permission denied" as a normal user.**
Files GlintMiner saved while running as root belong to root, and `glint.json` is readable only by its owner. Run it
the same way every time, or give the files back to your user, for example `sudo chown $USER glint.json glint.log
glint-history.jsonl`.

## Auto-tune on Linux

The full guide is [Auto-tune](auto-tune.md). These are the Linux-specific parts.

**How do I turn it on?**
At setup, on the dashboard (**Settings → Tuning**), or with `sudo ./glint --tune speed --confirm-tuning` (or
`efficiency`, `cool`, or `profit` with `--kwh-price`). `--confirm-tuning` confirms you accept the risk; it is saved.

**Does auto-tune need a desktop, X or nvidia-settings?**
No. GlintMiner makes its changes through the NVIDIA driver's management library, so it works on a headless machine.
It needs root and NVIDIA driver 470 or newer (older than 555, GlintMiner uses the driver's older clock controls; from
1.2.8); with an older driver the card says *Tuning needs a newer NVIDIA driver: update it and start GlintMiner again.
Until then this card mines at stock.*

**Does GlintMiner notice other overclocking tools on Linux?**
It looks for running tuning programs only on Windows. On Linux, an overclock already on the card (from
nvidia-settings, a script or another tool) is noticed when a tune starts: GlintMiner puts the card to factory
settings first, logs *Your card had its own overclock; tuning starts from factory settings and puts yours back when
GlintMiner closes.*, and puts your settings back when it closes. Something that changes the card's clocks *during* a
tune isn't noticed and spoils the result, so don't run such scripts or tools while it tunes.

**Can I use my own overclock on some cards and auto-tune on others?**
Yes. A card whose mode is **Off** is left exactly as it is. Set it per card on the dashboard, or with
`--tune-card 0=speed,1=off` (a card can be named by its number or its PCI bus address, like `01:00.0`).

**The card crashed while tuning and GlintMiner restarted.**
That's the tune finding the card's limit. GlintMiner logs *a GPU stopped responding; restarting GlintMiner*, starts
a fresh copy of itself and carries on. Under systemd, the unit's `Restart=always` makes sure it comes back whatever
happens. If cards keep stopping while several tune at once (`--tune-at-once`), the rest of the tune goes one card at a
time, and tuning pauses if they still do ([how](auto-tune.md#rigs-with-several-cards)). Restarts that keep coming
with no card tuning wait longer each time, up to half an hour, while the cards that still work keep mining.

## Temperature and power

**How does GlintMiner manage temperature?**
It watches every card's temperature all the time. Above the card's limit it eases the power limit down (with root).
Near the card's shutdown point it pauses that card until it has cooled (with or without root). The limit is read
from your card by default; you can set your own in **Settings → Temperature and power**. More in
[Temperature limits](auto-tune.md#temperature-limits).

**The log says the power limit "cannot be changed".**
*GPU 0: 84 C is over the 80 C limit, but the power limit cannot be changed. Run GlintMiner as administrator to let it
manage temperature.* On Linux that means: run it as root.

**Does it control my fans?**
No. GlintMiner never changes fan speeds. If a card runs with its fan at 100% and is still hot, the log says *check
airflow and dust*.

## The dashboard on a desktop or a headless rig

**Where is the dashboard?**
At **http://127.0.0.1:4078** on the machine that mines. By default it answers only there.

**How do I open it from another computer?**
Start GlintMiner with `--api-bind 0.0.0.0` (or **Settings → Dashboard → Who can open it** → *Other devices*, then
restart) and open `http://<machine-ip>:4078`. From other devices it is view-only; add `--api-allow-remote-control` to
allow changes from them too, only on a network you trust. If you run a firewall, let TCP port 4078 in from your own
network only. To reach it from anywhere, use Tailscale ([Phone access](phone-access.md#from-anywhere-with-tailscale)).

**The page shows only the word "forbidden".**
You opened it by a name that contains a dot, like `http://rig.lan:4078`. To protect you from malicious web pages,
GlintMiner answers only to an IP address, a plain machine name (`http://rig:4078`), a `.local` name, or a Tailscale
name ending in `.ts.net`.

**The log says "The dashboard and stats API couldn't start".**
The rest of the line says why, for example *port 4078 is already in use (another miner, or a second GlintMiner?);
choose another with --api-port*. Mining carries on without the dashboard.

## Logs

**Where is the log?**
In `glint.log` next to the program (next to the `--config` file if you use one). Each line starts with the time as a
Unix timestamp, then the message; `date -d @1759132800` turns a timestamp into a date. When the file has grown past
8 MB, GlintMiner starts it afresh at the next start. As a service, `journalctl -u glint` shows its output too.

**Why are the console times different from my clock?**
They are in UTC, not your local time.

**What's in `glint.log` that isn't on the screen?**
The technical detail. The console and dashboard show a short sentence saying what happened and what to do; the web
addresses, system error codes and error details go to `glint.log`. If you turn the log file off (`--no-log-file`), the
detail is printed on the console instead, in square brackets after the sentence.

**How do I share my log when asking for help?**
Copy the lines around the problem (for example `tail -n 200 glint.log`) and include them with the output of
`./glint --self-test` in your [issue](faq.md#getting-help). Remove your wallet address first if you'd rather not share
it.

## Updating and uninstalling

**How will I know there's a new version?**
GlintMiner checks GitHub at start and once a day, and says *A newer GlintMiner (…) is available at
https://github.com/MaccaDaStaka/GlintMiner/releases* in the log and on the dashboard. It never downloads or installs
anything by itself.

**How do I update?**
Click **Update now** on the dashboard, or run `glint --update` (GlintMiner needs to be able to write to its own folder;
the service in `/opt/glint` can). It checks the release's signature, swaps the program and restarts. By hand: stop
GlintMiner, replace the `glint` program with the one from the new `glint-…-linux.tar.gz`, and start it again
(as a service: `systemctl restart glint`). Keep `glint.json` and the other files: your settings, saved tunes and
history carry on.

**How do I uninstall it?**
Stop it and delete its folder. If you set it up as a service, first run `systemctl disable --now glint` and delete
`/etc/systemd/system/glint.service`. GlintMiner installs nothing else.

## Several cards

**Does it use all my cards?**
Yes, every supported NVIDIA card, and you can mix models. Choose with `--devices 0,2` or **Settings → Mining → Cards
to use**. More in [Several GPUs and several rigs](advanced.md#several-gpus-and-several-rigs).

**Why is GlintMiner's "GPU 1" a different card from nvidia-smi's GPU 1?**
GlintMiner numbers cards in CUDA's order, which on a machine with different cards can differ from nvidia-smi's.
`glint --gpu-info` shows each card's number with its name and PCI bus address, so you can match them up.

## Messages and what they mean

| What you see | What it means | What to do |
|---|---|---|
| *No NVIDIA driver was found. Install the current GeForce driver from nvidia.com and start again.* | `libcuda.so.1` couldn't be loaded | Install NVIDIA's driver (not nouveau) |
| *No NVIDIA GPU was found. GlintMiner needs an RTX 20-series or newer card.* | The driver sees no card GlintMiner can use | Check `nvidia-smi` and `glint --gpu-info` |
| *Your NVIDIA driver is too old for this GPU. Update to driver 570 or newer (580+ for RTX 50) and start again.* | The driver predates your card or GlintMiner | Update the driver |
| *…is not supported: Pearl mining needs an RTX 20-series or newer* | That card is too old (GTX 10-series or older) | That card is skipped; the others mine |
| *…is not supported: Pearl mining needs tensor cores (an RTX 20-series or newer)* | That card has no tensor cores (a GTX 16-series or similar) | That card is skipped; the others mine |
| *The GPU ran out of memory. Close other GPU programs (games, other miners) and start again.* | Something else is using the card's memory | Close it and start again |
| *no wallet configured: run glint in a terminal for the setup, or pass --wallet ADDRESS* | Started without a terminal and without settings | Run it once in a terminal, or add `--wallet` |
| *reading …/glint.json: Permission denied* | The file belongs to root (see above) | Run it the same way each time, or `chown` the file |
| *Can't look up … — check this PC's internet or DNS settings.* | The pool's name can't be looked up | Check the network and DNS |
| *Couldn't set up a secure connection to …; check this PC's date and time, and any antivirus or firewall that inspects traffic.* | The encrypted connection failed | Correct the clock (NTP); check anything that intercepts traffic |
| *The pool is not accepting our work (…). Pearl's rules may have changed (a network upgrade): this version needs an update.* | GlintMiner stopped rather than send work that would be rejected | [Update](#updating-and-uninstalling) |
| *Tuning needs administrator rights: close GlintMiner and start it again with right-click, Run as administrator (on Linux, with sudo).* | Tuning is on without root | Run it as root |

GlintMiner connects out to your pool (HeroMiners on port 1200, Kryptex on 8048, unMineable on 4444 or 3333) and to
websites on port 443 for prices, your pool figures and the update check. If you filter outgoing traffic, allow those.
More answers in [What the messages mean](auto-tune.md#what-the-messages-mean) and the
[troubleshooting table](faq.md#troubleshooting).
