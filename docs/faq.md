# FAQ and troubleshooting

[← Back to the README](../README.md) · **English** · [Русский](faq.ru.md) · [简体中文](faq.zh-CN.md)

- [Platform FAQs](#platform-faqs)
- [Questions](#questions)
- [Troubleshooting](#troubleshooting)
- [Verify your download](#verify-your-download)
- [Hotter cards after tuning](#hotter-cards-after-tuning)
- [Getting help](#getting-help)

---

## Platform FAQs

Answers for your platform: installing, running at boot or in the background, the rights it needs, auto-tune there,
the dashboard, logs, updating and removing.

- **[Windows](faq-windows.md)**
- **[Linux](faq-linux.md)**
- **[HiveOS](faq-hiveos.md)**
- **[MMPOS](faq-mmpos.md)**
- **[Docker](faq-docker.md)**

## Questions

**Is it safe for my graphics card?**
At its default settings GlintMiner never changes clocks, voltages or fans. It watches every card's temperature all
the time, eases the power limit down if a card runs hot (this needs administrator rights), and pauses a card that gets
close to its shutdown point until it cools. Clocks change only if you turn on [auto-tune](auto-tune.md), and
everything is put back when GlintMiner closes.

**My rig takes hours to tune. Does it run every card at full power all that time?**
No. Cards tune one at a time, about 1–2 hours each. A card waiting its turn keeps your own overclock if it has one,
or mines at three quarters of its default power limit until its turn; the dashboard says how long the whole rig takes.
To cap the rig's total while it tunes, set a power budget (**Settings → Temperature and power**, or
`--tune-power-budget`). See [rigs with several cards](auto-tune.md#rigs-with-several-cards).

**How much will I earn?**
That depends on your card, the Pearl price and the network difficulty, which all change over time. GlintMiner shows
your real earnings per day, live, from the moment it starts, and profit after power if you enter your electricity
price. The dashboard's Earnings page also projects the next 7 and 30 days at today's figures.

**Why is the pool showing less (or 0) for my rig?**
Pools report an average over the last 30 minutes or so and refresh every few minutes. Just after you start (or
restart) GlintMiner, the pool can show your rig at 0 or at its old figure for 10–30 minutes. Luck also moves the
pool's figure up and down from hour to hour; over a day it evens out. GlintMiner's own hashrate is measured directly
on your card.

**Can I use my PC while mining?**
Yes, though games and video editing feel slower while it runs, and they slow the mining too. Close GlintMiner (close
the window or Ctrl+C) whenever you want the full card back. Don't use the PC for heavy work while
[auto-tune](auto-tune.md#before-you-start) is tuning.

**Do I need to run it as administrator?**
No. It mines fine without. Administrator (root on Linux) rights are needed only to lower a card's power limit when it
runs hot, and for auto-tune.

**What's the 1% dev fee, exactly?**
About one second in every hundred, per card, mines for the developer. It's shown live, with the exact amount taken so
far, and nothing else is ever taken. See [the README](../README.md#the-1-developer-fee-in-the-open).

**Why does GlintMiner connect to HeroMiners (or another pool) now and then?**
That's the 1% dev fee, which mines on its own connection to its own pools (HeroMiners, with Kryptex as backup), apart
from your pool and your wallet. The log starts each of its lines with *dev fee (1%)* and shows only its changes
(connected, reconnecting, left idle); the routine detail goes to `glint.log`. If its pools are blocked, the fee goes
through your own pool's server with the fee's address; if that fails too, 1% of the time is left idle. It's never more
than 1%.

**The console says "fee pools unreachable: 1% of time left idle".**
The fee's servers (and the fee's backup on your own pool's server) can't be reached, often because a firewall or
DNS filter blocks them, so the fee's 1% of the time is left idle instead of mined: blocking them saves nothing. Allow
`pearl.herominers.com` and `prl.kryptex.network` (or your own pool's server) and the fee is mined again. If it stays
blocked for a day, mining pauses until it can connect (next question).

**Mining is paused: "the developer fee can't connect".**
If the dev fee has had no working connection for 24 hours (neither its own servers nor its backup on your pool's
server) while your own pool worked, GlintMiner pauses mining on every card and says so in the console, the log and
the dashboard. It keeps trying the fee's servers in the background, and mining carries on by itself as soon as the fee
can connect through any of them; nothing needs restarting. Restarting GlintMiner doesn't start the 24 hours over;
they start over as soon as the fee connects. When your own pool can't be reached either (the internet is down),
that's an outage, not a block: it never counts towards the 24 hours, and mining is never paused for the fee then.

If the message says *this PC's clock is wrong (it reads ...)*, nothing is blocked: the fee's servers prove who they
are with certificates that are only valid between two dates, and a PC whose date is far off sees them as expired or
not yet valid (your own pool still works, as miners don't check pool certificates). Set the correct date, time and
time zone (best: let the PC set the time automatically); the fee connects at its next try and mining carries on.

To fix it, let the fee through:
- Allow `pearl.herominers.com:1200` and `prl.kryptex.network:8048` (or your own pool's server, which the fee's backup
  uses) in your firewall, router, antivirus or DNS filter (Pi-hole, AdGuard, a parental filter).
- On a network that blocks or poisons DNS (mainland China, some workplaces), the fee already looks its servers up by
  secure DNS when the usual lookup fails. `--dns-over-https on` (or `"dns_over_https": "on"` in `glint.json`) tries
  secure DNS first, for the fee and your own pool; `auto` uses it for your pool only when the usual addresses fail.
- `glint --net-test pearl.herominers.com:1200` (and `prl.kryptex.network:8048`) shows whether the server can be
  reached and what your network's DNS and each secure DNS resolver answer.

Until it connects, the console says *Dev fee 1%: can't connect for a day: mining paused until it can*.

**GitHub is blocked on my network (mainland China).**
GlintMiner fetches two things from GitHub: the affiliate code list (only when you entered a code) and updates. Where
github.com, raw.githubusercontent.com and api.github.com can't be reached, the log says once *GitHub can't be reached
from this network*, an affiliate code shows as *not recognised* (its list couldn't be fetched) and update checks fail.
Set a GitHub proxy: `--github-proxy https://v4.gh-proxy.org/` (HiveOS and mmpOS: in the extra arguments),
`"github_proxy": "https://v4.gh-proxy.org/"` in `glint.json`, or **Settings → Mining → GitHub proxy** on the dashboard.
GlintMiner then asks the proxy for the same GitHub links (the full link goes after the proxy's address). The proxy is
only a way through: the code list is still checked against its own signing key and its issue date, and an update
against the signed `SHA256SUMS.txt` and the package's checksum: what gets installed is signature-checked, whatever
the proxy sends. A proxy could still announce an update that doesn't exist (it would fail those checks), so while one
is set an update offer shows only the version, marked *(via GitHub proxy)*, without release notes. It must be an
`https://` address. GlintMiner never uses a proxy you didn't set; `--github-proxy off` removes it.

**What is an affiliate code?**
The code of someone who referred you to GlintMiner. Enter it in setup, in **Settings → Affiliate code**, with
`--affiliate CODE` (HiveOS and mmpOS: in the extra arguments; `--affiliate off` removes it) or as `"affiliate"` in
`glint.json`; it takes effect when GlintMiner restarts. You still pay 1%: a quarter of it (0.25% of the time) mines to
the affiliate's PRL wallet instead of the developer's, so it never costs you more. Codes come from a list in a public repository of
their own ([GlintMiner-affiliates](https://github.com/MaccaDaStaka/GlintMiner-affiliates)), signed with a key used only
for code lists and checked on your rig; nothing about you is sent for it. If the dashboard or log says the code
is *not recognised*, it isn't in that list (check the spelling, or ask whoever gave it to you): the whole 1% then goes
to the developer. If the affiliate's share can't connect, it goes to the developer too: never idle time, never more
fee. The dashboard shows *Affiliate: CODE* and the console *affiliate: CODE* while it works. You can't use your own
code: on a rig that mines to the code's own wallet the whole 1% goes to the developer. If GlintMiner can't reach
GitHub for 14 days it says *the affiliate list is out of date*, and the whole 1% goes to the developer until it can.

**How do I become an affiliate?**
In **Settings → Become an affiliate**, or `glint --become-affiliate` on a rig without a screen. You earn a quarter of
the fee from every rig that uses your code, paid by the pool to your PRL wallet. You see exactly what is sent before
it goes: the PRL payout wallet you give, your Discord username if you give it, the install's anonymous id and the
GlintMiner version; nothing is sent until you tick the confirmation (or type `yes`). The Discord username is optional,
but it is how you get the Affiliate role and channel on [Discord](https://discord.gg/dXBTwVzJNy) (2–32 characters:
lower-case letters, digits, `_` and `.`). Give your username, not your display name: click your profile picture on
Discord; the username is the smaller grey name, like `cri_ver`. The developer checks each request by hand. You don't need Discord to
hear back: while your request waits, GlintMiner asks about every hour how it stands (sending only the install's id and
the request's token), and once approved your code shows up by itself in the log and as a notice on the dashboard's
Home page (with a Copy button), and on Discord too if you gave your username (the bot gives you the role). The code
list is signed and published automatically within about 5 minutes; running miners pick it up when they start or within a day. The dashboard (or
`--become-affiliate` again) shows whether it is waiting, approved or not.

**Does GlintMiner update itself?**
Only if you let it. By default it tells you when a new version is out and installs it when you click **Update now**;
with automatic updates on (Settings → Updates) it installs at a moment no card is in the middle of a tune. Either way
only a release signed with GlintMiner's release key is installed, and a version that doesn't run properly on your rig
is rolled back. [Updates](../README.md#updates), [how to update](getting-started.md#updating).

**I have several rigs on one wallet.**
Give each its own worker name (`--worker rig2`, or Settings → Mining). The pool lists every rig separately, and the
dashboard shows them all on the Earnings page.

**Does it work on AMD or older NVIDIA cards?**
No. It needs an NVIDIA RTX 20, 30, 40 or 50-series card (compute capability 7.5 or newer, with tensor cores). GTX
cards, including the GTX 16-series, aren't supported.

**Does it collect my data?**
No personal data. The fee's shares carry an anonymous label (card models and counts, payout type, version, whether
tuned), and from 1.2.8 GlintMiner sends an anonymous check-in every 15 minutes (the same id, version, OS, cards,
hashrate, power, temperatures, share counts, GPU errors, how and why the last run ended, self-restarts in the last 24 h, auto-tune's state, mode, stage and time left, dev-fee
state, update setting, driver version, the affiliate code if you entered one). Never your wallet, rig name, pool, IP address, location or tuning settings. [What exactly is sent, and why](../README.md#anonymous-check-in); turn the check-in off with
`--no-telemetry` or `"telemetry": false` in `glint.json`. From 1.2.9 it also sends short excerpts of its own log
(around errors and restarts, and a short tail once an hour), redacted on your PC first: wallet, worker, pool, IP
addresses, folders and tokens are replaced. [What exactly](../README.md#diagnostic-logs-from-129); turn that part off
with `--no-log-share`, `"log_share": false` or Settings → Console. The dashboard runs on your PC.

## Troubleshooting

| What you see | Likely cause | What to do |
|---|---|---|
| **"Windows protected your PC"** | Windows SmartScreen, for programs not yet downloaded widely | **More info → Run anyway** (once) |
| **Antivirus removed or blocked it** | Antivirus flags crypto miners as a category | [Verify the download](#verify-your-download), then allow it in your antivirus |
| **GlintMiner finds no card to mine on** | Not an RTX 20/30/40/50 card, or the NVIDIA driver is missing or old | Update the NVIDIA driver; check `glint --gpu-info` |
| **Hashrate lower than expected** | Other programs using the card (games, video or animated wallpapers, browser tabs with video, AI apps), or the card is hot | Close them; check the temperature on the dashboard; keep the card's airflow clear |
| **The console says the pool can't be reached** | Internet or DNS trouble, or a firewall | Check the PC's internet; GlintMiner retries and fails over by itself. `glint --net-test host:port` tests a pool |
| **Shares rejected** | Rare; usually an unstable overclock from another tool | Reset other overclocking tools to default. GlintMiner checks every share before sending it |
| **Stale shares right after a new job** | A slower card or an older processor took a moment to move to the pool's new job, and the pool already counted that work as stale | Use the latest version: from 1.2.9 a card moves to a new job as soon as it is ready, and new jobs are prepared sooner. If the log says the processor is too busy, close what keeps it busy |
| **"Tuning can't start yet"** | Not running as administrator | Close GlintMiner, right-click, **Run as administrator** |
| **"MSI Afterburner is running"** (or another tool) | That tool can change clocks during a tune | Close it; tuning starts by itself |
| **Tuned result looks low** | The PC was busy during the tune | Leave the PC idle and **Tune again** (Rigs) |
| **A card is paused: "driver stopped responding — restart the PC to bring this card back"** | The card's driver hasn't answered for half an hour (after a GPU error); the other cards keep mining | Restart the PC. If the driver answers again by itself (Windows can reset it), the card mines again without one |
| **The card is paused: "close to its shutdown point"** | The card is very hot | Improve airflow, clean the fans, or set a lower temperature limit; it resumes when cooler |
| **The dashboard won't open from my phone** | Not allowed yet, or the firewall | See [Phone access](phone-access.md#if-it-doesnt-open) |
| **The pool shows my rig at 0** | The pool lags 10–30 minutes | Wait; see the question above |
| **The screen goes black or the PC freezes while tuned** | The tune is too tight for this card on this day | GlintMiner backs the tune off by itself at the next start. If it happens again, turn tuning off or choose Less power |

Still stuck? Run `glint --self-test` and see [Getting help](#getting-help).

## Verify your download

Every release lists a SHA-256 checksum for each file in `SHA256SUMS.txt` on the release page. To check yours:

- **Windows** (in PowerShell or Command Prompt, in the folder with the file):
  `certutil -hashfile glint-1.2.9-windows.zip SHA256` (or `glint.exe`)
- **Linux:** `sha256sum glint-1.2.9-linux.tar.gz` (or `glint`)

First check that `SHA256SUMS.txt` itself is GlintMiner's: from 1.2.8 it is signed (see [Verify your download](../README.md#verify-your-download) in the README). The result must match the line for that file in `SHA256SUMS.txt`. If it doesn't, don't run it: download it again from
the [Releases page](https://github.com/MaccaDaStaka/GlintMiner/releases). Only download GlintMiner from this
repository.

## Hotter cards after tuning

**My cards ran hotter and drew more power after tuning overnight. Why?**
Auto-tune only runs when you turn a mode on; it is off by default. Most hashrate (`speed`) is the mode that aims for
the most Pearl, and to get it a card may be given more power than stock, up to the card's own maximum unless you allow
less. On a rig it tunes one card at a time, over hours; the cards waiting their turn run at reduced power, or keep
their own settings (on HiveOS, your overclock), so a rig looks cooler while it tunes and draws more once every card
runs its tune. Temperature limits still apply the whole time: a card that reaches its limit is eased down and keeps
its tune.

What to do:

- **Allow less extra power.** **Settings → Temperature and power → Extra power for Most hashrate** (or
  `--speed-power-raise none|low|medium|max`): *None* never goes above stock power. It applies to cards already tuned
  too, without tuning again.
- **Keep your own HiveOS overclock.** Set tuning to **Off** (**Settings → Tuning → Off**, or `--tune off`; on HiveOS
  take `--tune` out of **Extra config arguments**). A card whose mode is Off is left exactly as HiveOS set it, and
  turning tuning off puts back everything GlintMiner changed straight away.
- **Run cooler.** Choose **Less power** (the same hashrate on less power) or **Cool and quiet** (clearly less power,
  heat and fan noise for some hashrate) instead of Most hashrate. **Best earnings** picks between Most hashrate and
  Less power by your electricity price.
- **See what each mode does.** On the dashboard, **Why?** next to a waiting card's *reduced power* tag explains it,
  and **Compare modes** (next to a card's mode on Rigs, or in Settings → Tuning) shows every mode side by side for
  your cards: TH/s, watts and profit a day at your electricity price. It only shows; it changes nothing.

More in [Auto-tune](auto-tune.md#rigs-with-several-cards).

## Getting help

Open an [issue](https://github.com/MaccaDaStaka/GlintMiner/issues) with:

- your graphics card(s) and NVIDIA driver version,
- your operating system,
- the output of `glint --self-test`,
- the relevant lines from `glint.log` (next to the program).

Please remove your wallet address from anything you paste if you'd rather not share it.

Help and community: [Discord](https://discord.gg/dXBTwVzJNy). For help with your own rig, press **Get help** in
#private-help to open a private thread.
