# Auto-tune

[← Back to the README](../README.md) · **English** · [Русский](auto-tune.ru.md) · [简体中文](auto-tune.zh-CN.md)

Every graphics chip comes out of the factory a little different. Two cards of the same model can hold different
clocks at the same voltage, so the factory settings are chosen to be safe for the weakest one. Auto-tune finds the
best stable setting for **your** card, automatically, while it keeps mining.

It is **optional and off by default**. Out of the box GlintMiner runs your card at its factory settings and never
touches clocks, voltages or fans.

- [What it gets you](#what-it-gets-you)
- [The choices](#the-choices)
- [Before you start](#before-you-start)
- [Turning it on](#turning-it-on)
- [While it tunes](#while-it-tunes)
- [When it's done](#when-its-done)
- [Rigs with several cards](#rigs-with-several-cards)
- [How it keeps your card safe](#how-it-keeps-your-card-safe)
- [Temperature limits](#temperature-limits)
- [Tuning again, pausing and turning it off](#tuning-again-pausing-and-turning-it-off)
- [Gaming and the schedule](#gaming-and-the-schedule)
- [What the messages mean](#what-the-messages-mean)
- [The risk, plainly](#the-risk-plainly)

---

## What it gets you

On our RTX 4090, mining live on Kryptex:

| RTX 4090 | Hashrate | Power | TH/s per watt |
|---|:-:|:-:|:-:|
| Stock | 310 TH/s | 443 W | 0.70 |
| **Most hashrate** | **332 TH/s** (+7%) | 430 W | 0.77 |
| **Less power** | 310 TH/s | **338 W** (−24%) | **0.92** |

Your card's result will be different, because every chip is. Many cards find a few percent more hashrate, or the same
hashrate on less power (from under a tenth to nearly half less, depending on the card). **Cool and quiet** goes further
on power, for some hashrate: from about 90% of stock speed on 25–50% less power to 70–75% of stock speed on 45–60%
less, as you choose. A card with little headroom may find nothing worth keeping, and then
it simply stays at stock (see [No stable gain](#what-the-messages-mean)). A card already held back by its own power
limit at stock has little to gain: a 600 W RTX 5090 mines about the same with Most hashrate as at stock (about 420
TH/s), and Less power saves only about 10 W on it. A smaller card can do better on power: an RTX 2060 SUPER holds its
stock 49.7 TH/s with Less power on about 167 W instead of 182 W.

## The choices

You choose by what you want, not how it's done. The name in brackets is the one to use on the command line and in
HiveOS or MMPOS (`--tune profit`, and so on).

| Choice | What you get | Good for |
|---|---|---|
| **Off** (default) | Factory settings | Anyone who doesn't want their card changed |
| **Best earnings** (`profit`) | Most hashrate or Less power for each card, whichever earns more at your electricity price. **Recommended** | Most people: it decides for you |
| **Most hashrate** (`speed`) | The highest hashrate your card holds with zero errors: usually 4–9% more than stock, on about stock power or a little more | Cheap or free electricity; the most Pearl |
| **Less power** (`efficiency`) | Full stock hashrate on less power: from under 10% to nearly half less, depending on the card. Saves less than Cool and quiet | Dearer electricity, heat, noise, a small PSU |
| **Cool and quiet** (`cool`) | Some hashrate given up for clearly less power, heat and fan noise than Less power: 70–90% of stock speed (never below 70%), at a strength you choose | Very expensive electricity, a hot room, a quiet PC |

**Most hashrate** may also raise the card's power limit up to the card's own maximum, while its temperature allows.
You can allow it less: see *Extra power for Most hashrate* under [Rigs with several cards](#rigs-with-several-cards).

**Best earnings** needs your electricity price (Settings → Electricity; setup asks for it if you choose this). It
finds both the Most hashrate and the Less power result first, so its first run takes about twice as long. After that
it looks at the coin price and your electricity price every half hour and runs whichever result earns more, switching
only when the other one earns clearly more (so it doesn't flip back and forth on small price moves).

**Cool and quiet** is for a card that should run clearly cooler and quieter than *Less power* makes it. It aims for a
set power below stock and gives up some hashrate for it. You choose how far it goes:

| Strength | Speed against stock | Power against stock | Good for |
|---|:-:|:-:|---|
| **Cool** (`cool:cool`) | About 90% | About 25–50% less | Lower bills and heat for little hashrate |
| **Cooler** (`cool:cooler`, the default) | About 80% | About 35–55% less | The balance for most rigs. **Recommended** |
| **Coolest** (`cool:coolest`) | 70–75% | About 45–60% less | A hot room, a quiet PC, expensive electricity |

The power saved spans a range because cards differ: each strength aims for at most 75%, 65% or 55% of the card's stock
power, and always clearly below what *Less power* uses on it, so a card whose *Less power* result already saves a lot
(some RTX 30, 40 and 50 cards: the RTX 3070, 4080 SUPER and 5080 in our simulations) saves more. The figures come from our simulations of RTX 20, 30, 40 and 50 cards,
calibrated to cards we and testers measured; yours will differ a little.

**The watts for your card.** Once a card's stock power has been measured, the dashboard shows what each strength aims
for on it, next to the strength picker and the card's mode. For example, on an RTX 2060 SUPER: *Cool ~137 W · Cooler
~118 W · Coolest ~100 W (stock 182 W)*. On a rig, Settings → Tuning shows the range across your cards. Until the card's
least power at stock speed is known (its first Cool and quiet or Less power tune measures it), the figures read *up to*:
the most each strength draws. While a card tunes for Cool and quiet its line says *aiming for about 118 W (stock 182
W)*, and the log says the same once (`auto-tune: GPU 0 Cool and quiet (cooler): aiming for about 118 W (stock 182 W)`).
Before any measurement the dashboard shows the percentages only.

**How Cool picks its power.** An example with real figures: an RTX 3060 Ti mines about 65.5 TH/s at 178 W at stock.
Its first Cool and quiet or Less power tune finds its efficiency point, the least power it holds full stock speed on: about 127 W. Cooler then aims
for the lower of 65% of stock (about 116 W) and 84% of that efficiency point (about 107 W), so about 107 W. It then
takes the most hashrate that fits under 107 W, and never goes below 70% of stock speed (about 46 TH/s) to get there.
Cool and Coolest work the same way with their own shares (75% and 92%, 55% and 76%).

Every strength stays clearly below what *Less power* uses on the same card, so the two never end up side by side. It
never goes below 70% of stock speed: a card that would have to run slower than that to save its share stays at 70%
and saves a little less, and its result says *as far as this card goes*. The result reads as the power saved at a
share of stock speed. It takes longer than the others, up to
about two hours.

- **Choosing the strength:** on the dashboard, *Cool*, *Cooler* and *Coolest* appear next to the mode once you pick
  Cool and quiet (Settings → Tuning, the tuning panel on Rigs, and each card's mode on Rigs). On the command line,
  `--cool-strength coolest` (saved as `cool_strength` in `glint.json`; Cooler when it isn't set) sets the rig's, and
  `--tune cool` runs at it; `--tune cool:coolest` names it directly. Setup's Cool and quiet choice is Cooler.
- **Each strength keeps its own tune.** Switching to another strength uses that strength's saved tune, or tunes for it
  if it has none; it never applies another strength's tune.
- **Tuned with 1.2.6 or 1.2.7?** There this mode was called *Coolest and quietest* and looked for the most hashrate
  per watt, which often ended next to Less power. A Cool tune saved by those versions is replaced once: the first time
  the card runs Cool and quiet on 1.2.8, it tunes again for its strength (the log says so).

**Cooler days.** A card that later runs clearly cooler than when it was tuned (a cold night, a cleaned fan, a better
case) can hold a little more. GlintMiner notices and looks again while it mines, at most once a day, and keeps the saved
result as a fallback if the new one isn't better. *Most hashrate* tunes a little further; *Less power* and *Cool and
quiet* look for less power at the same hashrate (never faster or hotter).

## Choosing a mode

Not sure which mode suits you? **Compare modes** puts them side by side for each card and for the whole rig: TH/s,
watts, TH/s per watt, and what each earns, costs in electricity and makes in profit per day at today's coin price and
your electricity price. Open it with *Compare modes* next to a card's mode on Rigs, or in Settings → Tuning; it is
only a view (it changes nothing), and a view-only page can see it too.

- Each figure is marked **measured** (this card's own: its stock, its saved tunes and what it does now) or
  **estimate** (from the card's measured stock and efficiency point, or, before anything is measured, from our
  measurements and simulations of that model). A model we have no figures for shows the share of stock speed and
  power each mode gets, until its stock is measured. Tuning a mode replaces its estimate with the card's own result.
- With your electricity price set, the mode that makes the most profit at your price is highlighted. *Best earnings*
  picks between *Most hashrate* and *Less power* only, so the view also says which of those two it would run. Without
  a price it shows the earnings only, with a link to set one.

## Before you start

A tune measures small differences, about 1% at a time, so anything else that changes the card's speed during a tune
makes the result worse. For the best result:

1. **Close other overclocking tools**: MSI Afterburner, EVGA Precision X1, ASUS GPU Tweak, GIGABYTE AORUS Engine,
   GIGABYTE Graphics Engine, ZOTAC FireStorm, Palit ThunderMaster, GALAX Xtreme Tuner. Better still, reset their profile to default and turn
   off their *apply overclocking at startup*, and turn off the NVIDIA app's automatic tuning. On Windows GlintMiner
   waits while one of them is running and tells you which one to close (RivaTuner's on-screen display alone is fine).
2. **Leave the PC idle while it tunes.** No games, video editing, local AI apps or animated/video wallpapers. Even a
   browser tab with a moving page on the mining PC takes a little from the card. Overnight is ideal.
3. **Don't worry about an overclock you already have.** GlintMiner puts the card to factory settings before it starts,
   so the tune starts from real stock, and puts your own settings back when it closes.
4. **Run it as administrator** (Windows) or root (Linux). Changing clocks needs it. On Windows GlintMiner offers to
   restart itself as administrator when tuning is on; Windows asks you to allow it.
5. **Let the fans follow the temperature.** A card being tuned runs at factory power, so it gets hotter than with your
   own overclock. GlintMiner never touches fans, so use a temperature-based fan instead of a fixed low speed: HiveOS or
   mmpOS AutoFan with a temperature target (on 3090-class cards a memory target too), or a fan curve in MSI Afterburner
   (the card's own default curve favours quiet and can let it run hot), or a fixed 70% or more. With a temperature
   target, a tuning card's fan rises by itself and drops back once it's tuned. If a card
   still gets too hot, GlintMiner pauses it until it cools, so the tune just takes longer.

## Turning it on

Any one of these:

- **At setup:** the last question asks *Tune your card?* Pick a mode, read the one-line risk, and type **Y**.
- **On the dashboard:** **Settings → Tuning**, or the **Set up tuning** button on Home.
- **On the command line:** `glint --tune profit --confirm-tuning` (or `speed`, `efficiency`, `cool`; `cool:coolest`
  and so on for a [Cool and quiet strength](#the-choices)). `--confirm-tuning` is needed once, to confirm you accept
  the risk; it is saved.

If GlintMiner isn't running as administrator, the card mines at stock and the dashboard says *Tuning can't start
yet* with the one thing to do: close GlintMiner, right-click it and choose **Run as administrator**. Tuning then
starts by itself.

## While it tunes

- **Your card keeps mining the whole time,** so you keep earning.
- **It takes about 1 to 1½ hours** on a fast card (Less power is quicker; Best earnings and Cool and quiet take up
  to about two hours). The dashboard
  shows the percentage done and the time left. The time left is an estimate: a card that turns out to have more to
  give takes a little longer.
- **The hashrate runs a little lower while it tunes.** Every result is double-checked with Pearl's own verifier, and
  those checks take a small share of the card. That's expected. **Let it finish:** the result is measured afterwards,
  the way the card mines, and that's the figure you see.
- **Don't judge the result by the numbers during the tune.** They are lower on purpose and don't reflect the final
  result.
- **You can pause any time** (Rigs → **Pause**). The card goes straight back to factory settings, and Resume
  carries on from where it was.
- **If the card crashes during a tune,** that's the tune finding the card's limit, not a problem. GlintMiner restarts
  by itself, puts the card back to safe settings and carries on, typically a few times per tune. Your dashboard may
  show *Carrying on after a restart.* It never opens another browser tab when it restarts itself.
- **If the card gets hot during a tune,** tuning waits for it to cool and repeats that part, so a warm room doesn't
  lower the result for good.

## When it's done

The dashboard shows the outcome in plain words, for example **Tuned +7.4%** (Most hashrate), **−24% power** (Less
power) or the power saved at a share of stock speed (Cool and quiet), with the hashrate and power against stock.

- **The result is saved, for each mode.** It is applied at every start without tuning again, and a card keeps a tune
  for every mode it has tuned in: switch to another mode and back later, and the tune for that mode goes straight
  back on.
- **It keeps checking itself.** Over each quarter of an hour of normal mining, what the card actually mines is
  compared with the figure shown. If the card mines clearly faster or slower than the figure, it is measured again
  (at most once an hour), so the figure stays honest.
- **It backs off on its own if it ever has to.** If the card produces an error while mining, the tune steps back to
  a safer setting and says so (*Backed off to a safer setting after an error*). If the PC freezes or crashes soon
  after a tune is applied, the next start uses a safer setting too. A small loss of speed is always better than an
  unstable card.
- **It earns the setting back after a bad result.** If the error was a bad result (not a GPU error), then after
  three days of stable mining at the safer setting, running no hotter than when it erred, the card tries its tuned
  setting once more, under the same long check as the original tune (never while
  a game pauses mining or another card tunes). If it holds, the tune is back (*Regained its tuned setting after 3 days
  of stable mining*). If not, the card goes straight back to the safer setting and waits twice as long before the next
  try: 6 days, then 12; after the third try it keeps the safer setting until you tune it again. A setting the card
  hit a GPU error or stopped responding at, or the PC crashed at, isn't tried again: the card keeps its safer setting
  for good (until you tune it again).
- **A card that had trouble while tuning keeps more headroom.** If a card stops responding or hits a GPU error during
  its tune, its result keeps its full safety margin from where that happened and its final check runs about three
  times as long, so the tune takes a little longer and may end slightly lower. Cards that tune without trouble aren't
  affected.
- **A new NVIDIA driver** means the card is tuned again, since a driver can change how the card behaves.

## Rigs with several cards

- **One card tunes at a time,** from its stock measurement to its result, so no card is measured while another is
  being tested. The others keep mining, with their own tunes if they have them. A card waiting its turn says
  *Waiting for another card to finish tuning*, and its time left includes the cards ahead of it.
- **Cards waiting their turn don't sit at full stock power.** One card tunes at a time, which can take hours; leaving
  every other card at full stock power the whole time wastes electricity and heats the rig, including the card being
  tuned, which can make its result less accurate. So they run cooler until their turn, mining a little less meanwhile
  (about a tenth less). A card with settings of its own (a core overclock from HiveOS or Afterburner, a power limit
  you set) keeps them until its turn. Any other card mines at reduced power, three quarters of its default power
  limit, and shows *Waiting (reduced power)*; a memory offset of its own (HiveOS's usual
  memory underclock, or a memory overclock) stays on meanwhile. It gets its full limit back a few minutes before its
  turn, so its stock is measured as it really is; cards with a saved tune just run it, and cards you keep at stock or
  set to off are never touched. When a tune starts on a rig, the dashboard and the console say how long it takes and
  how the waiting cards run, for example *Tuning 6 cards one at a time, about 9 hours. Cards waiting their turn run at
  reduced power until then.* All of it is put back when GlintMiner closes, and after a crash at the next start.
- **When a card gets near its temperature limit,** or slows itself for heat in its memory, the waiting cards are held
  lower first, before the card being tuned is slowed; they go back up once the rig has been cool for a few minutes.
- **Once every card runs its tune,** the rig runs warmer than while the others waited at reduced power. The
  temperature guard looks after each card as before: a card that now reaches its limit gets a little less power,
  keeps its tune, and gets the power back when the rig cools (at night, say).
- **A crash while one card tests a setting is put down to that setting,** even when the driver stops every card (as
  it does on Windows): the cards already tuned keep their tunes.
- **Cards with their own overclock go to factory settings one at a time.** A card tuning starts from factory settings,
  at its full default power limit: a card on a power limit of your own (a 3090 at 220 W, say) goes to 350 W. When
  several cards start or resume tuning together (`--tune-at-once`, a start or restart, Resume tuning), they make that
  switch one at a time, 20 seconds apart, so the rig's draw rises gradually instead of by hundreds of watts at once;
  the cards not yet switched keep your settings meanwhile. And each card's power limit rises from yours to the factory
  limit in steps over about a minute before its stock is measured, so fans that follow the temperature keep up. It
  adds about a minute per card. With `--tune-at-once` above 1 the log says at the start how much more the rig may draw
  than on your settings; if the power supply can't carry that, use `--tune-at-once 1` or `--tune-power-budget`.
- **With `--tune-at-once`, cards that keep stopping make it tune one at a time.** Several cards measuring stock
  together all run at full power together, which some power supplies and risers can't take. If cards stop responding
  three times within half an hour while more than one card tunes, the rest of the tune goes one card at a time
  (*Several cards stopped responding while tuning together; tuning carries on one card at a time*), and a card that
  stopped while measuring stock with others isn't held to account for it: that is the rig's power, not a setting. If
  cards keep stopping one at a time (three more within half an hour), or GlintMiner restarts itself six times within
  15 minutes while cards tune, tuning pauses: every card mines at stock or on its own settings, and says why. Check
  the power supply and risers, then **Resume tuning** (one card at a time) or **Tune again** (as you set it); starting
  GlintMiner again by hand does the same as Tune again. Restarts that keep coming with no card tuning wait longer each
  time (5 minutes, up to half an hour), and the cards that still work keep mining meanwhile.
- **A power budget for the rig (optional).** **Settings → Temperature and power → Rig power budget while tuning**, or
  `--tune-power-budget 1800`: while cards tune, the whole rig is kept under that many watts. The waiting cards are held
  lower first (never under their minimum); a card starts tuning only when the rig fits the budget with that card at
  full power. If the cards already tuned draw too much for the next one to tune, that card says so plainly: raise the
  budget or turn it off. Under a budget, *Most hashrate* doesn't raise a card's power limit above its default.
- **Extra power for Most hashrate.** Each card's extra power is tried while the others wait at reduced power, so the
  rig only draws all of it together once every card runs its tune: on 4× RTX 4090 that can be 600 W more than at
  stock. Choose how much, safer to riskier, in **Settings → Temperature and power → Extra power for Most hashrate** or
  with `--speed-power-raise`:

  | Choice | Each card | 4× RTX 4090 (450 W each, 600 W at most) |
  |---|---|---|
  | `none` | never above stock | 1800 W |
  | `low` | up to 10% more | up to about 1980 W |
  | `medium` | up to 25% more | up to about 2250 W |
  | `max` (default) | up to the card's own maximum | up to 2400 W |

  Pick one your power supply can carry with headroom. A number of watts works too (`--speed-power-raise 50`: at most
  50 W more per card), and one card can have its own: `--speed-power-raise-card 0=none,1=50`. When two or more cards
  tune in Most hashrate, the console and the dashboard say what the rig's power limits may total once every card runs,
  and the console says what they total when tuning is done. Lower it after a tune and each tuned card runs at the most
  you now allow from then on (measured again as it mines, not tuned again). A power budget wins over it: under one, no
  limit is raised.
- **Each card can have its own mode.** For example Most hashrate on one card, Less power on another, and another at
  stock.
  Cards you don't set follow the rig's mode. Set it in **Settings → Tuning** (the card list under the rig's mode) or
  on each card in **Rigs**, where you can also tune one card again, or pause it while the others keep their tunes.
- On the command line: `glint --tune-card 0=speed,1=cool:coolest,2=off --confirm-tuning`. Cards not listed follow
  `--tune`; plain `cool` means the rig's strength. `--tune-exclude 0,2` keeps those cards at stock.
- A card on Cool and quiet of its own has its own strength, chosen next to its mode; a card that follows the rig uses
  the rig's.
- **A card keeps its mode and its tune when the cards are renumbered**: they are stored by the card's slot. Switching
  a card back to a mode it was already tuned in re-uses that result.
- The Home screen sums it up, for example *2 of 3 cards tuned: GPU 0 +6.4%, GPU 1 −22% power; GPU 2 at stock*.

## How it keeps your card safe

- **Error-free or nothing.** A setting is kept only if every result it produces passes Pearl's own verifier, over a
  long hold, and then with a safety margin on top.
- **Never memory overclocks, never above the card's own power maximum.** Most hashrate can raise the power limit, but only up
  to the maximum the card itself allows, and only as far as you allow it (Extra power for Most hashrate).
- **Everything is put back** when GlintMiner closes, and on the next start after a crash or a power cut. If
  GlintMiner is killed (Task Manager), the next start restores the card before doing anything else, and doesn't show
  it at stock until it really is.
- **A tune that made the PC crash is never applied again as it was.** It's backed off at the next start.
- **A search that found nothing isn't repeated at every start.** The card stays at stock, with the reason, for a
  week, or until you tune it again, update the driver or update GlintMiner.

## Temperature limits

GlintMiner watches every card's temperature all the time, tuned or not.

- **Automatic limit (recommended):** read from your card's own safe maximum, a little under the point where the card
  starts slowing itself down. On an RTX 4090 that's 80 °C at stock and 83 °C when tuned (a tuned card is allowed its
  own safe maximum). It is never set above what the card itself allows.
- **Above the limit,** GlintMiner eases the card's power limit down in small steps until it's back under (this needs
  administrator rights).
- **Near the card's shutdown point,** GlintMiner pauses that card until it is well cooler (a *hard stop*), then it
  carries on. The other cards keep mining.
- **Hot memory.** RTX 3080, 3090, 3090 Ti and 4070 Ti and up can get their memory to its own limit while the card's
  temperature looks fine. When the card slows itself for heat like this, GlintMiner lowers its power the same way
  until it no longer has to (administrator rights again), and the log says so.
- You can set your own limit in **Settings → Temperature and power**, or `--temp-limit 78`; and a limit for one card
  of its own (one in a hot spot of the rig) with `--temp-limit-card 1=72`. Auto-tune keeps to a card's own limit too.

## Tuning again, pausing and turning it off

| You want to… | Dashboard | Command line |
|---|---|---|
| Tune the whole rig again from stock (every card's saved tunes, in every mode, are forgotten) | Rigs → **Tune again** | `--retune` |
| Tune one mode again on every card (tunes for other modes are kept) | — | `--retune cool:cooler` (or `speed`, `efficiency`, `profit`, `cool`; 1.2.9) |
| Tune one card again from stock in its mode (its tunes for other modes, and the other cards' tunes, are kept) | Rigs → the card's tuning panel → **Tune this card again (this mode)** (on the mining PC, or with the remote-control code; not on view-only pages) | `--tune-card 07:00.0=efficiency --retune` (the card's bus id or number, and the mode to tune again; 1.2.9) |
| Pause tuning | Rigs → **Pause** | — |
| Change the mode | Settings → Tuning | `--tune efficiency` |
| Change how cool Cool and quiet runs | Settings → Tuning → **Cool**, **Cooler** or **Coolest** | `--cool-strength coolest` |
| Keep a card at stock | Rigs → the card → mode **Off** | `--tune-exclude 0` |
| Turn tuning off | Settings → Tuning → **Off** | `--tune off` |
| Forget everything tuning saved | — | `--tune-reset` |

Turning tuning off, pausing, or closing GlintMiner always puts the card straight back to factory settings.

**Gaming on the same PC?** Leave GlintMiner running: it pauses by itself while you play (next section). If you'd
rather close it first, close it normally (its window's X, or Ctrl+C). Ending it from Task Manager leaves the tune on the
card until GlintMiner runs again or the PC restarts, and a game running on a mining tune can crash.

## Gaming and the schedule

### Pause while you game (Windows)

On by default. When a game, or any other program, uses the card heavily, mining stops within about 10 seconds and
the cards go back to factory settings, so the game gets the whole card and never runs on a mining tune. A minute after
the game stops using the card (you quit it, or it sits minimised), mining carries on and the tune goes straight back
on. Home says **Paused while you play** and names the program.

- It looks at how much each program uses the card's graphics engine: the same figures Task Manager shows. The
  desktop, a browser or a video use far too little to count.
- If a program you keep open pauses mining when you don't want it to (an animated wallpaper, a video editor), press
  **Don't pause for it** on Home, or edit the list in **Settings → Gaming and schedule**. Wallpaper Engine is on the
  list from the start.
- Turn it off in the same place, or start GlintMiner with `--no-game-pause`.
- A game started while a card is tuning pauses the tune as well; it carries on from where it was afterwards.
- It works while GlintMiner runs. After ending GlintMiner from Task Manager, see the note above.

### The schedule

Choose times of day for another mode, or for a pause. For example:

| From | To | Mode | Why |
|---|---|---|---|
| 23:00 | 07:00 | Cool and quiet: Coolest | A quiet room at night |
| 17:00 | 21:00 | Pause mining | Your electricity's peak hours |

Set it in **Settings → Gaming and schedule**. The times are this PC's local time, every day; outside them the rig runs
its own mode, and where two times overlap the first in the list wins.

- **A schedule never starts a tune.** A card switches only to a mode it has a saved tune for (Settings lists them).
  Each Cool and quiet strength counts as its own mode. To add one, choose that mode as your mode once, let it tune,
  then switch back: both tunes are kept.
- **Switching is instant:** the saved tune goes straight on, with no new search. Factory settings and a pause are
  always available.
- **A tune in progress finishes first.** A card that is tuning when a scheduled time starts finishes, then switches.
- Cards with a mode of their own (Rigs → the card → Mode) keep it; the schedule moves the cards that follow the rig's
  mode. With tuning off, only the schedule's pauses apply.
- *Best earnings* isn't offered in the schedule: it already chooses between your Most hashrate and Less power tunes
  at your electricity price.
- Command line: `--schedule 23:00-07:00=cool:coolest,17:00-21:00=pause` (modes: `off`, `speed`, `efficiency`,
  `cool:cool`, `cool:cooler`, `cool:coolest`, `pause`; plain `cool` is saved with the rig's strength written out), and
  `--schedule off`. Add `--save` to keep it.

## What the messages mean

| Message | What it means | What to do |
|---|---|---|
| **Tuning can't start yet** | GlintMiner isn't running as administrator (root on Linux) | Close it, right-click, **Run as administrator** |
| **MSI Afterburner is running** (or another tool) | That tool can change clocks mid-tune | Close it (and its *apply at startup*); tuning starts by itself within a minute |
| **Waiting for another card to finish tuning** | One card tunes at a time | Nothing; it starts when its turn comes |
| **Carrying on after a restart** | The card crashed while testing its limit, or GlintMiner restarted | Nothing; this is normal during a tune |
| **No stable gain** | Nothing beat stock without errors on this card | Nothing; it stays at stock. To try again another day, or after a driver update: **Tune this card again (this mode)** in the card's tuning panel (or `--tune-card <bus id>=<mode> --retune`) |
| **Backed off to a safer setting** | The card made an error while mining tuned | Nothing; it's safer now. After a bad result it tries its tuned setting again by itself after a few days of stable mining; after a GPU error it keeps the safer setting. **Tune again** if you don't want to wait |
| **… as far as this card goes** | Cool and quiet reached 70% of stock speed before saving its strength's share of power | Nothing; that's this card's limit for Cool and quiet. A lower strength, or Less power, if you'd rather keep more hashrate |
| **This card can't be tuned** | The driver doesn't allow clock changes on it | Nothing; it mines at stock |
| **Several cards stopped responding while tuning together; tuning carries on one card at a time** | Cards stopped responding three times within half an hour while more than one tuned: the power supply or risers may not take several cards at full power together | Nothing; the rest of the tune goes one card at a time. If it keeps happening, check the power supply and risers |
| **Cards kept stopping responding while tuning, even one at a time; tuning is paused** (or **GlintMiner kept restarting itself while cards tuned; tuning is paused**) | Cards kept stopping one at a time too, or GlintMiner restarted itself six times within 15 minutes while cards tuned. Cards not yet tuned mine at stock; cards already tuned keep their tune | Check the power supply and risers, then **Resume tuning** (one card at a time) or **Tune again**; starting GlintMiner by hand does the same as Tune again ([more](#rigs-with-several-cards)) |

## The risk, plainly

Auto-tune runs your card outside its factory settings. It backs off at the first error, never overclocks memory,
never goes above your card's own power maximum, and puts everything back when GlintMiner closes (or on the next start
after a crash). But an unstable setting can still crash the miner or, rarely, the display driver or the PC. You turn
it on at your own risk, and it stays off unless you do.
