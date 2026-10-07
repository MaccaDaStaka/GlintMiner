# The dashboard

[← Back to the README](../README.md) · **English** · [Русский](dashboard.ru.md) · [简体中文](dashboard.zh-CN.md)

While GlintMiner runs, it serves a dashboard on your own PC at **http://127.0.0.1:4078**. It can open by itself when
GlintMiner starts (Settings → Dashboard). Nothing is sent to any website: the page talks only to GlintMiner on your
PC, and GlintMiner asks your pool and a price site for your figures.

It works on a phone as well as a desktop, in **English, Русский and 简体中文**, with a light and a dark theme.

- [Home](#home)
- [Earnings](#earnings)
- [Rigs](#rigs)
- [Settings](#settings)
- [This rig and your wallet](#this-rig-and-your-wallet)
- [When figures can't be refreshed](#when-figures-cant-be-refreshed)
- [Opening it from another device](#opening-it-from-another-device)
- [The stats API](#the-stats-api)

---

## Home

Home answers four questions, most urgent first:

1. **Is it working?** A single status line at the top. **Green** when all is well (for example *Mining · on Kryptex ·
   RTX 4090 · 331 TH/s · 49 of 49 shares accepted*). **Amber** or **red** when something needs you, with the reason in
   one sentence and the one thing to do. While a card tunes it says so, with the progress. **Paused while you play**
   names the game that paused mining (with **Don't pause for it**, if that program isn't a game), and **Paused by
   your schedule** says when mining carries on.
2. **What am I earning?** Profit per day after electricity (or income per day if you haven't entered an electricity
   price), in your currency and in Pearl, with *today so far* and *the last 7 days*. It's an estimate for this rig,
   worked out from your live hashrate, the network and today's Pearl price; *How this is worked out* shows every
   figure used.
3. **Is my card at its best?** If auto-tune is off, it says your card runs at factory settings (which is fine) and
   offers to set up tuning. While it tunes: the percentage done, the time left and the time so far. Once tuned: the
   outcome, like *Tuned +7.4%*, with the hashrate and power against stock. See [Auto-tune](auto-tune.md).
4. **When do I get paid?** Your balance on the pool, how close it is to the next payout, about when that comes, and
   your last payment.

Below them, **Details** has the live hashrate and its 24-hour chart, power, efficiency (TH/s per watt), energy used
today, the hottest card and its temperature limit, and your shares (accepted, rejected, stale).

## Earnings

- **Today, 7 days, 30 days, all time:** profit, income, electricity cost, Pearl mined, hours mined and the average per
  day, for the period you pick. Every figure uses each day's own price.
- **The last 30 days** as a chart (income, electricity, profit and your pool payouts), with a table view.
- **If nothing changes:** a projection for the next 7 and 30 days at today's price, network difficulty and your
  electricity price. Pearl's price changes every day, so it's a guide, not a promise.
- **Your wallet:** the pool's own figures for your address: balance, the payout threshold and about when the next
  payout comes. On Kryptex, what is confirmed and what is still maturing.
- **Your rigs on that wallet:** every rig mining to the same address, with its hashrate as the pool sees it and this
  rig's share of the total.
- **Payouts:** the latest payments, with the amount, when, a link to the transaction and its value in your currency.
  **Show all** lists the rest, and **Full history on …** opens the pool's own payouts page.

## Rigs

- **Every card** on its own: hashrate, temperature against its limit, power against its power limit, accepted shares,
  and its tuning state (mode, progress or outcome).
- **Per-card controls** (with auto-tune on): pause one card's tuning, tune one card again, or give it its own mode.
- **Recent events:** the things worth knowing, like a card starting or restarting, the pool connecting or switching,
  tuning finishing or backing off, and errors. Routine lines (each accepted share, the minute-by-minute hashrate)
  are left out so they don't crowd out what matters; the share counts are on Home.

## Settings

| Section | What's in it |
|---|---|
| **Wallet and payout** | Your address or Kryptex account, and how your earnings reach you |
| **Electricity** | Price per kWh and currency, for power cost and profit after power |
| **Tuning** | Auto-tune on or off and the rig's choice (Best earnings, Most hashrate, Less power, Cool and quiet with its strength: Cool, Cooler or Coolest), and a choice for each card (see [Auto-tune](auto-tune.md)) |
| **Gaming and schedule** | Pause while you game (Windows) and the programs that never pause it; times of day for another mode or a pause (see [Gaming and the schedule](auto-tune.md#gaming-and-the-schedule)) |
| **Temperature and power** | The temperature limit (automatic from your card, or your own), the hard stop, and profit mode for power limits |
| **Dashboard** | Who can open it (this computer only, or other devices view-only), the port, and opening it at start |
| **Appearance and language** | Light, dark or automatic theme, and the language |
| **Telegram alerts** | A message when a card stops or the pool is lost |
| **Mining** (advanced) | The rig (worker) name, which cards to use, a pool override, and a GitHub proxy for networks that can't reach GitHub (mainland China; see the [FAQ](faq.md#questions)) |
| **Affiliate code** | The code of whoever referred you: a quarter of the 1% fee goes to them, never more for you (see the [FAQ](faq.md#questions)) |
| **Become an affiliate** | Ask to become an affiliate: shows exactly what is sent, sends it only after you confirm, then shows whether it is approved (GlintMiner checks about every hour by itself while it waits; once approved, your code also shows as a notice on Home with a Copy button, until you dismiss it). It asks for your Discord username, not your display name: the smaller grey name under your profile picture, like `cri_ver` |
| **Console and logs** | The plain console for services and rig OSes, and whether to write `glint.log` |

Changes are saved to `glint.json`. A few (the port, who can open the dashboard) apply after GlintMiner restarts; the
page says so.

## This rig and your wallet

The dashboard keeps two kinds of figures apart, and labels them:

- **This rig:** GlintMiner's own live estimate for this PC (hashrate, earnings per day, power).
- **Wallet · all rigs:** the pool's figures for your whole address: balance, payouts, and every rig mining to it.

If you run several rigs to one wallet, the balance and payouts belong to all of them together, while *This rig*
figures are only this PC's.

**Just after a start, the pool lags.** Pools report a 30-minute average and refresh every few minutes, so for the first
10–30 minutes your pool may still show this rig at 0 (or its figures from before a restart). The dashboard says *the
pool hasn't caught up yet* rather than showing 0%.

## When figures can't be refreshed

If the pool's or the price site's website can't be reached for a while (your internet drops, or their site is down),
mining carries on. The dashboard keeps the last figures, shows how old they are, and says in one plain sentence what
couldn't be refreshed. The technical detail goes to `glint.log`.

## Opening it from another device

By default only the mining PC can open the dashboard. To watch it from your phone or laptop:

- **At home, on the same network:** Settings → Dashboard → **Who can open it** → *Other devices*, save and restart
  GlintMiner, then open `http://<this PC's address>:4078` on the other device.
- **From anywhere:** use Tailscale, step by step in [Phone access](phone-access.md).

From other devices the dashboard is **view only**: they can watch but not change anything, and the page says so.
To allow changes from them too, start GlintMiner with `--api-allow-remote-control`, only on a network you trust.

## The stats API

For your own monitoring, GlintMiner serves JSON on the same port:

- `GET http://127.0.0.1:4078/api/stats`: hashrate (total and per card), temperatures, fans, power, shares, uptime,
  version, earnings and the pool's wallet figures.

HiveOS and MMPOS read their stats from it (`h-stats.sh`, `mmp-stats.sh`). See [Advanced](advanced.md#stats-api).
