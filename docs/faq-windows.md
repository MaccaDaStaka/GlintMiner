# GlintMiner on Windows: FAQ

[← Back to the FAQ](faq.md) · **English** · [Русский](faq-windows.ru.md) · [简体中文](faq-windows.zh-CN.md)

Questions that come up when you mine with GlintMiner on Windows 10 or 11, answered for how GlintMiner works today.

- [Installing and first run](#installing-and-first-run)
- [Running it](#running-it)
- [Administrator rights](#administrator-rights)
- [Auto-tune on Windows](#auto-tune-on-windows)
- [Temperature and power](#temperature-and-power)
- [The dashboard and your phone](#the-dashboard-and-your-phone)
- [Logs](#logs)
- [Updating and uninstalling](#updating-and-uninstalling)
- [Several cards](#several-cards)
- [Messages and what they mean](#messages-and-what-they-mean)
- [Getting the best hashrate](#getting-the-best-hashrate)

---

## Installing and first run

**Which file do I download?**
`glint-…-windows.zip` from the [latest release](https://github.com/MaccaDaStaka/GlintMiner/releases/latest). It holds
`glint.exe`, the READMEs, these guides, the changelog and the licence files. There is no installer: you unzip it and
run `glint.exe`.

**Where should I unzip it?**
Into a folder of its own that your Windows account can write to, for example `C:\GlintMiner`. GlintMiner keeps
everything next to `glint.exe`: your settings (`glint.json`), the log (`glint.log`), the history behind the charts
(`glint-history.jsonl`) and benchmark results. A folder like `C:\Program Files` isn't a good home, because a program
started normally can't write there.

**Do I need to install CUDA or anything else?**
No. GlintMiner uses the NVIDIA driver you already have. You need Windows 10 or 11 (64-bit), an RTX 30, 40 or
50-series card and a recent driver: 550 or newer, and 580 or newer for RTX 50 cards.

**Windows says "Windows protected your PC". Is that a problem?**
No. Windows SmartScreen shows this for new programs that haven't been downloaded widely yet. Click **More info**,
then **Run anyway**. You only need to do this once.

**My antivirus removed or blocked `glint.exe`.**
Antivirus programs flag cryptocurrency miners as a category, including genuine ones. First check that your file is
the real one ([Verify your download](faq.md#verify-your-download)), then allow it in your antivirus and unzip it again
if it was removed.

**How did setup know my address, rig name and currency?**
It reads the text on your clipboard and offers it only if it is a valid address for the payout you chose (nothing
else is taken from the clipboard). The rig name it suggests is your computer's name, and the currency comes from your
Windows region setting. You can change all of them in setup, or later in the dashboard's **Settings**.

**The window showed an error and "Press Enter to close."**
When GlintMiner can't carry on, it prints the reason and waits for Enter, so the window doesn't vanish before you
can read it. The common reasons and what to do are under [Messages and what they mean](#messages-and-what-they-mean).

## Running it

**How do I stop GlintMiner?**
Close its window or press **Ctrl+C**. Everything it changed on your cards (a power limit it lowered, and clocks if
you use auto-tune) is put back as it closes. When Windows closes it for you (signing out or shutting down),
GlintMiner uses the few seconds Windows allows to put the cards back too.

**What happens if I end it from Task Manager (or `taskkill /F`)?**
It has no chance to tidy up, so the next start does it first: before any card mines, cards that auto-tune had
changed are put back, and the log says *auto-tune: GlintMiner didn't close cleanly last time; 1 card(s) put back to
stock*. A power limit that only the temperature guard had lowered isn't part of that record, so it may not return to
what it was until the PC restarts. Closing the window normally avoids both.

**Until then, the tune stays on the card.** Don't play games or run other GPU-heavy programs after ending GlintMiner
from Task Manager: a setting tuned for mining (above all *Coolest and quietest*, which runs the card at its lowest
voltage) can make a game crash or the screen go black. Start GlintMiner again and close it normally, or restart the
PC, first. **To game, leave GlintMiner running (it pauses by itself, below) or close it with its window's X or
Ctrl+C.**

**Can I game while GlintMiner runs?**
Yes. With **Pause while I game** (on by default), when a game uses the card mining stops within about 10 seconds
and the cards go back to factory settings, so the game has the whole card and never runs on a mining tune. A minute
after you quit the game (or while it sits minimised), mining carries on and the tune goes back on. Home shows
**Paused while you play** with the game's name. GlintMiner tells a game from everyday use by how much of the card's
graphics engine a program uses (the figures Task Manager shows), so the desktop, a browser or a video don't pause it.
Other heavy programs count too (a 3D editor, another miner): press **Don't pause for it** on Home to let one be, or
edit the list, or turn the pause off, in **Settings → Gaming and schedule**. `--no-game-pause` turns it off from the
command line. It needs the GPU usage counters Windows 10 (1709 or later) and 11 have.

**Can it mine differently at night, or not at all at peak times?**
Yes: **Settings → Gaming and schedule → Use a schedule**. Pick times of day and a mode for each (Coolest and
quietest overnight, a pause during your peak electricity hours, and so on). A card only switches to a mode it has
already tuned in, so the schedule never starts a tune. See [the schedule](auto-tune.md#the-schedule).

**Can GlintMiner start by itself when Windows starts?**
GlintMiner has no autostart setting and installs nothing, so you set it up in Windows:

- **Without auto-tune:** put a shortcut to `glint.exe` in your Startup folder (press Win+R, type `shell:startup`,
  press Enter).
- **With auto-tune:** tuning needs administrator rights, and a normal Startup shortcut doesn't have them. Each time
  it starts without them, GlintMiner asks *Tuning is on, but it needs administrator rights. Restart GlintMiner as
  administrator now?*. With nobody there to answer, it waits a minute and then mines at stock (*No answer: mining at
  stock this time*), so the card isn't tuned. To start tuned, create a task in Task Scheduler that runs `glint.exe`
  at log on with **Run with highest privileges** ticked.

**Can it run as a Windows service or hidden in the background?**
No. GlintMiner has no Windows service mode; it runs in its console window. Minimise the window if you don't want to
see it. (On Linux it can run as a service; see the [Linux FAQ](faq-linux.md).)

**Why do the times in the console differ from my clock?**
The console's times (`[14:02:37]`) are in UTC, not your local time.

**The live table doesn't look right in my console window.**
On older console windows GlintMiner draws the table without colours. If it still looks wrong, turn on **Settings →
Console and logs → Plain console** (or start it with `--plain`) and restart GlintMiner: you then get plain log lines
instead of the table.

## Administrator rights

**Do I have to run it as administrator?**
No. It mines the same without. Administrator rights are needed only to change a card's settings:

- to ease a card's power limit down when it runs hot,
- for profit mode (**Settings → Temperature and power → Profit mode**),
- for [auto-tune](auto-tune.md).

The *hard stop*, which pauses a card near its shutdown point, works without administrator rights.

**How do I run it as administrator?**
Right-click `glint.exe` and choose **Run as administrator**. Or let GlintMiner do it: when tuning is on and it
isn't running as administrator, setup (and, later, every start) offers *Restart GlintMiner as administrator now?*.
Choose **1**, allow it when Windows asks, and GlintMiner opens again as administrator in a new window while the old
one closes. Choose **2** and it mines at stock this time; with no answer for a minute, it does the same. If you turn down Windows' request, it says *Not restarted
(the request was declined): mining at stock. Tuning starts when you run GlintMiner as administrator.*

**The dashboard says "Tuning can't start yet".**
Tuning is on, but GlintMiner isn't running as administrator. Your card mines at factory settings meanwhile, which is
completely fine. Close GlintMiner, right-click it, choose **Run as administrator**, and tuning starts by itself.

## Auto-tune on Windows

The full guide is [Auto-tune](auto-tune.md). These are the Windows-specific parts.

**Which programs stop a tune from starting?**
While one of these is running, a tune doesn't start: MSI Afterburner, EVGA Precision X1, ASUS GPU Tweak, GIGABYTE
AORUS Engine, GIGABYTE Graphics Engine, ZOTAC FireStorm, Palit ThunderMaster and GALAX Xtreme Tuner. They can apply
their own clocks at any moment, which spoils a tune's measurements. The card keeps mining at stock and the dashboard,
console and log say which program to close, for example *MSI Afterburner is running. Close it (and turn off its
'apply overclocking at startup'), then tuning starts by itself.* GlintMiner looks again every minute.

**What if I open MSI Afterburner while a card is tuning?**
That card goes back to stock and carries on tuning once the program is closed. A card that has already finished
tuning keeps mining with its tune.

**Is RivaTuner's on-screen display a problem?**
No. RivaTuner Statistics Server on its own doesn't change clocks, and GlintMiner leaves it alone.

**I really want to keep my tool open while tuning.**
Start GlintMiner with `--tune-ignore-tools` (or set `"tune_ignore_tools": true` in `glint.json`). Only do this if
you know your tool won't change the card's clocks during the tune.

**I already overclocked my card (in MSI Afterburner or the NVIDIA app). What happens?**
Before it tunes, GlintMiner puts the card to factory settings, so the tune starts from real stock, and the log says
*Your card had its own overclock; tuning starts from factory settings and puts yours back when GlintMiner closes.*
Your own settings come back when GlintMiner closes, or at the next start after a crash. For the best result, also
turn off the NVIDIA app's automatic tuning ([Before you start](auto-tune.md#before-you-start)).

**The screen went black for a moment (or the driver reset) while it was tuning.**
That's the tune finding the card's limit. GlintMiner logs *a GPU stopped responding; restarting GlintMiner*,
starts itself again, puts the card back to a safe setting and carries on. It doesn't open another browser tab when
it does this. If the whole PC froze or crashed soon after a tune was applied, the next start uses a safer setting.

**Can I play games while it tunes?**
Please don't. A tune measures differences of about 1%, so games, video, local AI apps and animated wallpapers make
the result worse. Leave the PC idle; overnight is ideal. Once the card is tuned you can use the PC as usual.

**It says "This card's maker doesn't allow tuning it (common on laptops)".**
Some cards, many laptops among them, allow next to no change. The card mines at stock and GlintMiner doesn't try to
tune it.

## Temperature and power

**How does GlintMiner keep my card cool?**
It watches every card's temperature all the time. Above the card's limit it eases the power limit down (this needs
administrator rights). Near the card's shutdown point it pauses that card until it has cooled, even without
administrator rights. The limit is read from your card by default; you can set your own in **Settings → Temperature
and power**. More in [Temperature limits](auto-tune.md#temperature-limits).

**The log says the power limit "cannot be changed".**
The full line is *GPU 0: 84 C is over the 80 C limit, but the power limit cannot be changed. Run GlintMiner as
administrator to let it manage temperature.* Your card is hot and GlintMiner isn't allowed to lower its power. Run
it as administrator, or improve the airflow.

**Does GlintMiner control my fans?**
No. It never changes fan speeds; your card, or the tool you use for fans, stays in charge. If a card runs with its fan
at 100% and still hot, the log says *check airflow and dust*.

## The dashboard and your phone

**Where is the dashboard?**
At **http://127.0.0.1:4078** in your browser while GlintMiner runs. It can open by itself at every start: **Settings →
Dashboard → Open this dashboard when GlintMiner starts**. The full tour is in [The dashboard](dashboard.md).

**How do I watch it from my phone?**
**Settings → Dashboard → Who can open it** → *Other devices*, save, and restart GlintMiner. When Windows asks about
the firewall, allow **Private networks** only. Other devices can then watch, but not change anything. For
watching from anywhere with Tailscale, including the firewall rule to add, see [Phone access](phone-access.md).

**The console says "The dashboard and stats API couldn't start".**
The full message tells you why, for example *port 4078 is already in use (another miner, or a second GlintMiner?)*.
Mining carries on; only the dashboard is missing. Close the other program, or pick another port with `--api-port
4079` (or **Settings → Dashboard → Port**, then restart).

**The dashboard shows only the word "forbidden".**
You opened it by a name that contains a dot, like `http://my-pc.lan:4078`. To protect you from malicious web pages,
GlintMiner answers only to an IP address (`http://192.168.1.20:4078`), a plain computer name (`http://my-pc:4078`),
a `.local` name, or a Tailscale name ending in `.ts.net`.

## Logs

**Where is the log?**
In `glint.log`, next to `glint.exe`. Each line starts with the time as a Unix timestamp (seconds since 1970), then the
message. When the file has grown past 8 MB, GlintMiner starts it afresh at the next start. The most useful lines also
appear on the dashboard under **Rigs → Recent events**.

**What's in the log that isn't on the screen?**
The technical detail. The console and dashboard show a short sentence saying what happened and what to do; the web
addresses, Windows error codes and error details behind it go to `glint.log` only.

**How do I share my log when asking for help?**
Open `glint.log` in Notepad, copy the lines from around the problem, and include them with the output of
`glint --self-test` in your [issue](faq.md#getting-help). Remove your wallet address first if you'd rather not share
it.

**Can I turn the log off?**
Yes: **Settings → Console and logs → Write a log file**, or start with `--no-log-file`.

## Updating and uninstalling

**How will I know there's a new version?**
GlintMiner checks GitHub at start and once a day. When a newer version exists, the console and the dashboard say so,
in the words *A newer GlintMiner (…) is available at https://github.com/MaccaDaStaka/GlintMiner/releases*. It never
downloads or installs anything by itself.

**How do I update?**
Close GlintMiner, unzip the new `glint-…-windows.zip` into the same folder (replace the files) and start `glint.exe`
again. Your settings, saved tunes and history aren't in the zip, so they stay. Details in
[Updating](getting-started.md#updating).

**How do I uninstall it?**
Close it and delete its folder. GlintMiner creates no services, registry entries or background programs. If you made
a Startup shortcut, a Task Scheduler task or a firewall rule for it, delete those too.

## Several cards

**Does it use all my cards?**
Yes, every supported NVIDIA card, and you can mix models. To choose, use **Settings → Mining → Cards to use** or
`--devices 0,2`. More in [Several GPUs and several rigs](advanced.md#several-gpus-and-several-rigs).

**Which card is "GPU 1"?**
`glint --gpu-info` lists each card with the number GlintMiner uses, its name and its PCI bus address. On a PC with
different cards the numbers can differ from those other tools show, so check there before using `--devices` or
`--tune-card`.

**How much memory does it need?**
About 1.5 GB of system memory (RAM) per card.

## Messages and what they mean

| What you see | What it means | What to do |
|---|---|---|
| *No NVIDIA driver was found. Install the current GeForce driver from nvidia.com and start again.* | The NVIDIA driver is missing | Install the current driver |
| *No NVIDIA GPU was found. GlintMiner needs an RTX 30-series or newer card.* | Windows sees no NVIDIA card GlintMiner can use | Check the card and driver; run `glint --gpu-info` |
| *Your NVIDIA driver is too old for this GPU. Update to driver 550 or newer (580+ for RTX 50) and start again.* | The driver predates your card or GlintMiner | Update the driver |
| *…is not supported: Pearl mining needs an RTX 30-series or newer* | That card is too old (GTX, RTX 20) | That card is skipped; the others mine |
| *The GPU ran out of memory. Close other GPU programs (games, other miners) and start again.* | Something else is using the card's memory | Close it and start again |
| *Can't look up … — check this PC's internet or DNS settings.* | The pool's name can't be looked up | Check the PC's internet connection |
| *Couldn't set up a secure connection to …; check this PC's date and time, and any antivirus or firewall that inspects traffic.* | The encrypted connection was refused on this PC | Correct the clock; allow GlintMiner in software that scans connections |
| *The pool is not accepting our work (…). Pearl's rules may have changed (a network upgrade): this version needs an update.* | GlintMiner stopped rather than send work that would be rejected | [Update](#updating-and-uninstalling) |
| *…glint.json is not valid (delete it to run the setup again)* | The settings file is damaged | Delete `glint.json` and run setup again |
| *Tuning needs a newer NVIDIA driver: update it and start GlintMiner again.* | The driver doesn't offer the controls tuning needs | Update the driver; the card mines at stock meanwhile |

More, including every auto-tune message, in [What the messages mean](auto-tune.md#what-the-messages-mean) and the
[troubleshooting table](faq.md#troubleshooting).

## Getting the best hashrate

**My hashrate is lower than I expected.**
Close anything else that uses the card: games, video and animated wallpapers, browser tabs playing video, local AI
apps and other miners. Check the card's temperature on the dashboard; a card near its limit runs slower. An open
dashboard tab is fine: it draws nothing while it sits there.

**Does a busy CPU matter?**
A little. Every result is checked on your PC with Pearl's own verifier before it is sent, and a PC that is very busy
checks more slowly. While a card tunes it matters more: a tune can end with *The computer was too busy to make sure
this card is stable, so it stays at stock.* Try again with fewer programs running.

**Should I leave it running?**
Yes. Pools pay for steady work, and a card that mines around the clock earns far more than one started and stopped
every evening.
