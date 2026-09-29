# FAQ and troubleshooting

[← Back to the README](../README.md) · **English** · [Русский](faq.ru.md) · [简体中文](faq.zh-CN.md)

- [Platform FAQs](#platform-faqs)
- [Questions](#questions)
- [Troubleshooting](#troubleshooting)
- [Verify your download](#verify-your-download)
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

**Does GlintMiner update itself?**
No. It tells you when a new version is out, and never downloads or installs anything by itself.
[How to update](getting-started.md#updating).

**I have several rigs on one wallet.**
Give each its own worker name (`--worker rig2`, or Settings → Mining). The pool lists every rig separately, and the
dashboard shows them all on the Earnings page.

**Does it work on AMD or older NVIDIA cards?**
No. It needs an NVIDIA RTX 30, 40 or 50-series card (compute capability 8.0 or newer).

**Does it collect my data?**
No. The fee's shares carry an anonymous label (card models and counts, payout type, version, whether tuned), never
your wallet, rig name, IP address or location. The dashboard runs on your PC and only GlintMiner talks to your pool
and a price site.

## Troubleshooting

| What you see | Likely cause | What to do |
|---|---|---|
| **"Windows protected your PC"** | Windows SmartScreen, for programs not yet downloaded widely | **More info → Run anyway** (once) |
| **Antivirus removed or blocked it** | Antivirus flags crypto miners as a category | [Verify the download](#verify-your-download), then allow it in your antivirus |
| **GlintMiner finds no card to mine on** | Not an RTX 30/40/50 card, or the NVIDIA driver is missing or old | Update the NVIDIA driver; check `glint --gpu-info` |
| **Hashrate lower than expected** | Other programs using the card (games, video or animated wallpapers, browser tabs with video, AI apps), or the card is hot | Close them; check the temperature on the dashboard; keep the card's airflow clear |
| **The console says the pool can't be reached** | Internet or DNS trouble, or a firewall | Check the PC's internet; GlintMiner retries and fails over by itself. `glint --net-test host:port` tests a pool |
| **Shares rejected** | Rare; usually an unstable overclock from another tool | Reset other overclocking tools to default. GlintMiner checks every share before sending it |
| **"Tuning can't start yet"** | Not running as administrator | Close GlintMiner, right-click, **Run as administrator** |
| **"MSI Afterburner is running"** (or another tool) | That tool can change clocks during a tune | Close it; tuning starts by itself |
| **Tuned result looks low** | The PC was busy during the tune | Leave the PC idle and **Tune again** (Rigs) |
| **The card is paused: "close to its shutdown point"** | The card is very hot | Improve airflow, clean the fans, or set a lower temperature limit; it resumes when cooler |
| **The dashboard won't open from my phone** | Not allowed yet, or the firewall | See [Phone access](phone-access.md#if-it-doesnt-open) |
| **The pool shows my rig at 0** | The pool lags 10–30 minutes | Wait; see the question above |
| **The screen goes black or the PC freezes while tuned** | The tune is too tight for this card on this day | GlintMiner backs the tune off by itself at the next start. If it happens again, turn tuning off or choose Efficiency |

Still stuck? Run `glint --self-test` and see [Getting help](#getting-help).

## Verify your download

Every release lists a SHA-256 checksum for each file in `SHA256SUMS.txt` on the release page. To check yours:

- **Windows** (in PowerShell or Command Prompt, in the folder with the file):
  `certutil -hashfile glint-1.2.5-windows.zip SHA256` (or `glint.exe`)
- **Linux:** `sha256sum glint-1.2.5-linux.tar.gz` (or `glint`)

The result must match the line for that file in `SHA256SUMS.txt`. If it doesn't, don't run it: download it again from
the [Releases page](https://github.com/MaccaDaStaka/GlintMiner/releases). Only download GlintMiner from this
repository.

## Getting help

Open an [issue](https://github.com/MaccaDaStaka/GlintMiner/issues) with:

- your graphics card(s) and NVIDIA driver version,
- your operating system,
- the output of `glint --self-test`,
- the relevant lines from `glint.log` (next to the program).

Please remove your wallet address from anything you paste if you'd rather not share it.
