# Auto-tune

[← Back to the README](../README.md) · **English** · [Русский](auto-tune.ru.md) · [简体中文](auto-tune.zh-CN.md)

Every graphics chip comes out of the factory a little different. Two cards of the same model can hold different
clocks at the same voltage, so the factory settings are chosen to be safe for the weakest one. Auto-tune finds the
best stable setting for **your** card, automatically, while it keeps mining.

It is **optional and off by default**. Out of the box GlintMiner runs your card at its factory settings and never
touches clocks, voltages or fans.

- [What it gets you](#what-it-gets-you)
- [The four modes](#the-four-modes)
- [Before you start](#before-you-start)
- [Turning it on](#turning-it-on)
- [While it tunes](#while-it-tunes)
- [When it's done](#when-its-done)
- [Rigs with several cards](#rigs-with-several-cards)
- [How it keeps your card safe](#how-it-keeps-your-card-safe)
- [Temperature limits](#temperature-limits)
- [Tuning again, pausing and turning it off](#tuning-again-pausing-and-turning-it-off)
- [What the messages mean](#what-the-messages-mean)
- [The risk, plainly](#the-risk-plainly)

---

## What it gets you

On our RTX 4090, mining live on Kryptex:

| RTX 4090 | Hashrate | Power | TH/s per watt |
|---|:-:|:-:|:-:|
| Stock | 310 TH/s | 443 W | 0.70 |
| **Speed** | **332 TH/s** (+7%) | 430 W | 0.77 |
| **Efficiency** | 310 TH/s | **338 W** (−24%) | **0.92** |

Your card's result will be different, because every chip is. Many cards find a few percent more hashrate, or the same
hashrate on a fifth to a quarter less power. A card with little headroom may find nothing worth keeping, and then
it simply stays at stock (see [No stable gain](#what-the-messages-mean)).

## The four modes

| Mode | What it aims for | Good for |
|---|---|---|
| **Off** (default) | Factory settings | Anyone who doesn't want their card changed |
| **Speed** | The highest hashrate your card holds with zero errors | Cheap or free electricity; the most Pearl |
| **Efficiency** | Stock hashrate on as little power as possible | Expensive electricity, heat, noise, a small PSU |
| **Profit** | The most money after electricity | Letting GlintMiner decide from prices |

**Speed** may also raise the card's power limit up to the card's own maximum, while its temperature allows.

**Profit** needs your electricity price (Settings → Electricity). It finds both the Speed and the Efficiency result
first, so its first run takes about twice as long. After that it looks at the coin price and your electricity price
every half hour and runs whichever result earns more, switching only when the other one earns clearly more (so it
doesn't flip back and forth on small price moves).

**Cooler days (Speed only).** A card that later runs clearly cooler than when it was tuned (a cold night, a cleaned
fan, a better case) can hold a little more. GlintMiner notices, tunes a little further while it mines, at most once a
day, and keeps the saved result as a fallback if the new one isn't better.

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

## Turning it on

Any one of these:

- **At setup:** the last question asks *Tune your card?* Pick a mode, read the one-line risk, and type **Y**.
- **On the dashboard:** **Settings → Tuning**, or the **Set up tuning** button on Home.
- **On the command line:** `glint --tune speed --confirm-tuning` (or `efficiency`, `profit`). `--confirm-tuning` is
  needed once, to confirm you accept the risk; it is saved.

If GlintMiner isn't running as administrator, the card mines at stock and the dashboard says *Tuning can't start
yet* with the one thing to do: close GlintMiner, right-click it and choose **Run as administrator**. Tuning then
starts by itself.

## While it tunes

- **Your card keeps mining the whole time,** so you keep earning.
- **It takes about 1 to 1½ hours** on a fast card (Efficiency is quicker, Profit about twice as long). The dashboard
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

The dashboard shows the outcome in plain words, for example **Tuned +7.4%** (Speed) or **−24% power** (Efficiency),
with the hashrate and power against stock.

- **The result is saved** and applied at every start, without tuning again.
- **It keeps checking itself.** Over each quarter of an hour of normal mining, what the card actually mines is
  compared with the figure shown. If the card mines clearly faster or slower than the figure, it is measured again
  (at most once an hour), so the figure stays honest.
- **It backs off on its own if it ever has to.** If the card produces an error while mining, the tune steps back to
  a safer setting and says so (*Backed off to a safer setting after an error*). If the PC freezes or crashes soon
  after a tune is applied, the next start uses a safer setting too. A small loss of speed is always better than an
  unstable card.
- **A new NVIDIA driver** means the card is tuned again, since a driver can change how the card behaves.

## Rigs with several cards

- **One card tunes at a time,** from its stock measurement to its result, so no card is measured while another is
  being tested. The others keep mining, with their own tunes if they have them. A card waiting its turn says
  *Waiting for another card to finish tuning*, and its time left includes the cards ahead of it.
- **Each card can have its own mode.** For example Speed on one card, Efficiency on another, and another at stock.
  Cards you don't set follow the rig's mode. Set it in **Settings → Tuning** (the card list under the rig's mode) or
  on each card in **Rigs**, where you can also tune one card again, or pause it while the others keep their tunes.
- On the command line: `glint --tune-card 0=speed,1=efficiency,2=off --confirm-tuning`. Cards not listed follow
  `--tune`. `--tune-exclude 0,2` keeps those cards at stock.
- **A card keeps its mode and its tune when the cards are renumbered**: they are stored by the card's slot. Switching
  a card back to a mode it was already tuned in re-uses that result.
- The Home screen sums it up, for example *2 of 3 cards tuned: GPU 0 +6.4%, GPU 1 −22% power; GPU 2 at stock*.

## How it keeps your card safe

- **Error-free or nothing.** A setting is kept only if every result it produces passes Pearl's own verifier, over a
  long hold, and then with a safety margin on top.
- **Never memory overclocks, never above the card's own power maximum.** Speed can raise the power limit, but only up
  to the maximum the card itself allows.
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
- You can set your own limit in **Settings → Temperature and power**.

## Tuning again, pausing and turning it off

| You want to… | Dashboard | Command line |
|---|---|---|
| Tune again from stock | Rigs → **Tune again** | `--retune` |
| Pause tuning | Rigs → **Pause** | — |
| Change the mode | Settings → Tuning | `--tune efficiency` |
| Keep a card at stock | Rigs → the card → mode **Off** | `--tune-exclude 0` |
| Turn tuning off | Settings → Tuning → **Off** | `--tune off` |
| Forget everything tuning saved | — | `--tune-reset` |

Turning tuning off, pausing, or closing GlintMiner always puts the card straight back to factory settings.

## What the messages mean

| Message | What it means | What to do |
|---|---|---|
| **Tuning can't start yet** | GlintMiner isn't running as administrator (root on Linux) | Close it, right-click, **Run as administrator** |
| **MSI Afterburner is running** (or another tool) | That tool can change clocks mid-tune | Close it (and its *apply at startup*); tuning starts by itself within a minute |
| **Waiting for another card to finish tuning** | One card tunes at a time | Nothing; it starts when its turn comes |
| **Carrying on after a restart** | The card crashed while testing its limit, or GlintMiner restarted | Nothing; this is normal during a tune |
| **No stable gain** | Nothing beat stock without errors on this card | Nothing; it stays at stock. Try again another day, or after a driver update |
| **Backed off to a safer setting** | The card made an error while mining tuned | Nothing; it's safer now. **Tune again** later if you like |
| **This card can't be tuned** | The driver doesn't allow clock changes on it | Nothing; it mines at stock |

## The risk, plainly

Auto-tune runs your card outside its factory settings. It backs off at the first error, never overclocks memory,
never goes above your card's own power maximum, and puts everything back when GlintMiner closes (or on the next start
after a crash). But an unstable setting can still crash the miner or, rarely, the display driver or the PC. You turn
it on at your own risk, and it stays off unless you do.
