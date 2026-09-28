# Changelog

All notable changes to GlintMiner are listed here.

## [1.2.4] - 2026-09-28

### Changed
- **Clearer, calmer error messages.** What you see on the dashboard, in the console and in the event list is now a
  short sentence saying what happened and what to do, if anything, in English, Russian or Chinese; web addresses,
  operating-system error codes and other technical detail go only to `glint.log` (on HiveOS, mmpOS and Docker, to the
  miner's own log). When a pool, price or balance site can't be reached for a moment, the dashboard says so plainly
  and keeps showing the last figures with their age, for example *Couldn't refresh your balance just now; showing
  the figure from 12 min ago.*; if the site's name can't be looked up, it says to check this PC's internet or DNS
  settings. Messages that need you to act (no driver, administrator rights for tuning, a refused login, an
  unsupported card) stay as clear as before.
- The same error repeating (a pool down for a while) is logged at most once every five minutes instead of at every
  retry, and balance and price refreshes retry sooner at first and then less often while a failure lasts.
- Tuning takes about four minutes longer per tune (the result's measurement, below).

### Fixed
- The tuned result shown is now measured the way the card mines normally, so it matches the live hashrate; before, it
  read 1–2% low, more on a busy PC (our RTX 4090's speed tune now shows 330–333 TH/s, about +7–8% against stock). A
  tune saved by an earlier version keeps working as it is and has its figures measured again once, the next time it
  runs.
- A newly found tune is always written to the log once, even when its measurement is interrupted (paused by you or
  by the temperature guard, a mode change, a retune, or GlintMiner closing); it is then logged with the figures from
  tuning.
- The wallet panel no longer shows a raw connection error (a web address and an operating-system error) in red when
  a balance refresh fails.
- A long pool message with non-English characters can no longer stop the pool connection.
- The Telegram bot token is kept out of the log when a Telegram message can't be sent.

## [1.2.3] - 2026-09-27

### Added
- **A tuning mode for each card.** On a rig with several cards, each card can run its own mode (Off, Speed,
  Efficiency or Profit); cards you don't set follow the rig's mode. Set it in **Settings → Tuning** (a list of your
  cards, each with its mode and its outcome, under the rig's mode) or on each card in **Rigs**. The one risk
  confirmation covers every card.
- **Per-card controls on Rigs:** each card shows its mode and has a mode picker, **Tune this card again** (only that
  card's saved result is dropped; the others keep theirs and keep mining) and pause/resume for that card only.
- **Home sums up mixed modes**, for example *2 of 3 cards tuned: GPU 0 +6.4%, GPU 1 −22% power; GPU 2 at stock*.
- **`--tune-card 0=speed,1=efficiency,2=off`** sets each card's mode from the command line (`default` follows
  `--tune`; a PCI bus id works in place of the number).
- A card keeps a saved result per mode: switching it back to a mode it was tuned in re-uses that result.
- `/api/stats` gives each card's `tune_mode`, `tune_mode_own` and `pci_bus_id`, and `tuning.modes_active`;
  `POST /api/tuning` accepts a `gpu` (card number or PCI bus id) for `start`, `retune`, `pause`, `resume`, `stop` and
  `set_mode` (mode `default` = follow the rig).
- **Smaller shares on Kryptex.** GlintMiner now speaks Kryptex's compressed share format: when Kryptex agrees at
  login, each share goes out gzipped, about 11 KB instead of 2 MB, which cuts traffic and the stale shares a slow
  upload causes. If Kryptex doesn't agree, shares go uncompressed as before. The log says which at every login. Other
  pools are unchanged.
- **Share difficulty for big rigs on Kryptex.** A rig that measures above 500 TH/s asks Kryptex for a higher share
  difficulty (about one share every 30 seconds, never below Kryptex's default), so it sends fewer, larger shares; it
  logs in again once to apply it. Set your own with `--share-diff N` (or `"share_diff"` in `glint.json`; 0 =
  automatic). Earnings estimates, the dev fee and hashrate figures don't depend on it; only the count of shares gets
  smaller, each one counting for more.
- `/api/stats` shows `pool.compressed` and `pool.share_diff`.
- GlintMiner names itself to Kryptex (`GlintMiner/<version>`) at login.
- **Smaller shares on HeroMiners.** Shares to HeroMiners (yours and the dev fee's) now go compressed, about 14 KB
  instead of 2 MB each: on an RTX 4090 that is roughly 6 GB less upload a day. If a HeroMiners server refuses them,
  that server gets uncompressed shares for the rest of the run.

### Changed
- **About 1% faster on every card:** the mining kernel loads its next data one step later, which keeps the tensor units
  busier (RTX 4090: +0.9% at stock, +1.0% tuned; RTX 5060: +1.7%). Results are checked exactly as before.
- **RTX 50 and many RTX 30/40 cards mine up to 3.6% faster:** work is now split evenly across all of the card's
  cores (about +3.6% on an RTX 5090, +1.4% on a 3080 Ti, 4080 Super or 4070 Ti Super, +1% on a 3070 or 4070; the
  RTX 4090 was already even).
- **The dev fee's shares carry an anonymous rig label** (card models and counts, payout type, version, tuned or
  stock), so the developer can see how GlintMiner is used. No wallet, rig name, IP address or location. The fee's
  rate and pools are unchanged.
- A card's mode is stored by its PCI bus id (`tune_cards` in glint.json), so it stays with the card's slot when the
  cards are renumbered. Settings from 1.2.2 and earlier load unchanged: cards in `tune_exclude` are simply off.
- A card whose mode changes goes back to stock and tunes again on its own; the other cards carry on.
- **Stop tuning** (for the whole rig) now also clears the cards' own modes, so every card is back at stock.
- The dashboard and API number cards as CUDA does (the numbers the console, `--devices` and `--tune-card` use).
  `exclude`/`include` in `POST /api/tuning` now take that number (the same as before unless `--devices` picks a subset).
- Profit mode needs an electricity price wherever it is turned on (dashboard, API), not only in setup.
- Setup, on a rig with more than one card, mentions that each card can have its own mode.
- **Profit mode now really weighs power.** It finds both the Speed and the Efficiency result for the card, runs
  whichever earns more after electricity at today's coin price and your electricity price, and looks again every half
  hour (it switches only when the other earns clearly more, and not more than once every two hours). Before, it tuned
  exactly like Speed. The first run takes longer, since it finds both results.
- **Speed keeps climbing while it gains.** It no longer stops after a fixed number of steps up: it keeps going while each
  step holds and is measurably faster, so a well-cooled card goes as far as it can.
- **Speed looks again when the card runs cooler.** A tuned card that runs clearly cooler than when it was tuned (for
  example on a cold night) is tuned a little further, at most once a day; its saved result stays as the fallback. The
  card's message then reads, for example, *Tuned +7.1% (updated for cooler conditions)*.
- **Speed may raise the card's power limit** to the card's own maximum, only when the card is held back by its power
  limit and only if that measurably gains; otherwise the limit is left as it is. It is put back when GlintMiner closes
  or tuning stops (and on the next start after a crash).
- **The safety margin costs next to nothing.** When the margin itself would slow the card down (it runs into its power
  limit), the tuner narrows it by one notch or settles on the speed the card really holds.
- **Efficiency keeps stock speed.** It aims for the card's average stock speed (not the most common reading, which can
  be lower), and only keeps a result that saves at least 2% power.
- **Clearer reasons when a card stays at stock:** too hot already, not stable even with a small change, the computer
  too busy to check the card, locked by the card's maker (many laptops), sensors not readable, or a driver too old for
  tuning. Each shows on the dashboard and once in the log.
- Profit mode's power-limit search (the separate *profit mode* setting) leaves cards that auto-tune looks after alone,
  so the two never work against each other.
- **On a rig with several cards, auto-tune tests one card at a time** (the others keep mining at stock or at their
  saved result), so a setting that crashes is always blamed on the card that was testing it. Total tuning time is about
  the same.
- Speed tries a clock step above the card's usual ceiling at a little more voltage, and keeps it only if it gains.
- The log states a tuning outcome the way the dashboard does (an Efficiency result as the power it saves).

### Fixed
- Stock is measured once the card has warmed up. A card measured cold (right after GlintMiner starts) read too fast at
  stock, which could make real gains look like losses and leave the card at stock.
- A card whose first tuning step was slower with its memory clock held low (not every card likes that) now tries again
  without it instead of staying at stock.
- A card that already runs at its temperature limit at stock is no longer failed for staying there while tuned; only
  running hotter than stock counts against a setting.
- The power-limit search no longer saves options given only on the command line (like `--wallet` without `--save`) into
  glint.json, and it only uses prices in the currency of your electricity price.
- The thermal guard never raises a power limit back past the card's own after tuning has put it back.
- On a rig with several cards tuning at once, one card's crash (which resets the driver for every card on Windows)
  was recorded against every card being tested, so healthy cards gave up and stayed at stock. A crash now counts only
  against the card that was testing alone; a card that would give up because of crashes recorded the old way tests the
  lowest of them again, on its own, once.
- A card's saved result is no longer backed off because another card crashed while it was being tested.
- Profit mode switching from the Efficiency result to the Speed result could crash the card: the new clock limit went
  on before the voltage came up. The voltage now comes up first.
- Price, pool and update sites were told GlintMiner 1.1.1 whatever the real version; they now get the real one.

## [1.2.2] - 2026-09-27

### Added
- **Pearl paid to your own Pearl wallet through Kryptex.** A new setup choice for a steady payout: 2% pool fee, paid
  for every share (PPS+), sent to your wallet from 1 PRL. With a Pearl address you can switch between HeroMiners and
  Kryptex any time in Settings. Earnings estimates for Pearl on Kryptex are after the 2% fee.
- **Kryptex's own figures on the dashboard** for Pearl on Kryptex: your balance (ready to pay and still maturing), how
  close it is to the 1 PRL payout, about when the next payout comes (counting the time new blocks take to mature),
  your last payout and pending payouts, each rig's hashrate as Kryptex sees it (including rigs that are offline), and
  a link to your address's page on Kryptex. If Kryptex's website can't be reached, the dashboard says so and shows
  GlintMiner's own estimate only. A Kryptex account's balance stays private to that account (check it on kryptex.com).
- **Kryptex backup servers.** On Kryptex, Kryptex's regional servers are the backups (nearest first), so a server
  outage doesn't stop mining and your payout stays in one place.
- **The next payout time for every payout coin**, not only Pearl (for unMineable, from unMineable's own conversion).
  When there isn't enough to go on, no time is shown rather than a guess.
- **Windows: restart as administrator.** With auto-tune on but GlintMiner not started as administrator, it offers to
  restart itself as administrator (Windows asks you to allow it), in setup and at every start. Say no and the card
  simply mines at stock.
- **Check your miner from your phone, anywhere.** The dashboard opens by its Tailscale name
  (`your-pc.your-tailnet.ts.net`), and the README explains how to use Tailscale to see it from your phone without
  opening your PC to the internet (view-only, firewall rule for Tailscale only).

### Changed
- **A redesigned dashboard: Home tells the story.** A one-line **Is it working?** (green, or amber or red with the
  reason and the one thing to do), then three answers ordered by what matters now: **What am I earning?** (with a
  what-to-expect card in the first minutes), **Is my card at its best?** (auto-tune's progress and time left, then its
  outcome) and **When do I get paid?** (per payout route, with only the figures GlintMiner really has), and a quieter
  **Details** section with the 24-hour hashrate and its average. **Earnings** adds a projection and the daily figures;
  **Rigs** keeps every card's details and all the tuning controls in the same look; **Settings** has the four ways to
  be paid, the tuning mode with its risk to accept, the automatic temperature limit, who can open the dashboard, and
  language. In English, Russian and Chinese. On another device (view-only) every control is hidden.
- **Setup is pick-by-number:** type a number and press Enter (Enter alone picks the first choice). It finds your
  address on the clipboard (so there's nothing to paste), suggests your computer's name for the rig, suggests your
  system's currency when you enter an electricity price, and asks whether to turn on auto-tune (off unless you choose
  it, and only after you accept the risk).
- **The temperature limit is automatic and fits each card:** it comes from the card's own safe maximum as the driver
  reports it: 3 °C under it at stock, and the maximum itself when tuned, never above it (on an RTX 4090, 80 °C at stock
  and 83 °C tuned). Setup names the limit when you turn tuning on. A limit you set yourself stays yours, but is never
  allowed above your card's maximum. If you never changed the old 80 °C, you get the automatic limit.
- **The emergency pause uses your card's real slowdown and shutdown points** (on newer cards the driver's older fixed
  figures were far higher than the card's real ones).
- **Tuning shows progress and outcome only:** progress and time left while a card tunes (the console shows "tuning
  N%"), then the result. Once tuning has finished, the header says the outcome (for example "Tuned +6.4%") instead of
  "Tuning on", which read as still tuning. Tuning messages say what happened in plain words, in all three languages.
- While tuning is on, the power-limit history chart is hidden.
- The event list no longer shows raw pool traffic.
- Electricity prices up to 100000 per kWh are accepted, in setup and in Settings (before, 10 or more was refused,
  which ruled out currencies like yen, won, tenge, forint or rupees).
- A card too old for Pearl mining (for example a CMP 100-210) is skipped with a clear message instead of being reset
  and retried over and over.

### Fixed
- On Kryptex every rig showed up as one worker called "worker", so several rigs merged into one. Each rig now shows
  under its own name.
- With a Kryptex account, GlintMiner mined the first time but refused to start again ("That is not a valid Bitcoin
  address"). Your saved Kryptex account now loads normally; nothing to change on your side.
- Text with non-English letters (for example "Привет") no longer crashes GlintMiner: on the clipboard or typed in
  setup, in a Kryptex account's email, or from the pool.
- `--wallet` on the command line no longer mines on a pool saved for a different wallet: if the saved pool can't pay
  the new wallet, GlintMiner uses the wallet's own pools (unless you also give `--pool`).
- Windows: after restarting as administrator, a settings file given with `--config` relative to the current folder is
  still found.
- Home said "Price from Kryptex" when the price came from elsewhere; it now names the real source, and for Pearl on
  Kryptex says the estimate is after Kryptex's 2% pool fee.
- A tuned card showed a different gain in different places while it warmed up. It now shows the same saved result
  everywhere (header, tuning card, card rows); the live figure stays in the card's details.

## [1.2.1] - 2026-09-27

### Changed
- Auto-tune without administrator rights now says so within seconds, instead of after measuring stock for three
  minutes, and tells you what to do: close GlintMiner and start it again with right-click, Run as administrator (on
  Linux, with sudo). The card keeps mining at stock until then.

## [1.2.0] - 2026-09-27

### Added
- A redesigned dashboard that answers "is it working, and what am I earning?" at a glance, on a phone or a desktop,
  in dark or light.
- The dashboard now speaks Russian and Chinese as well as English: it follows your browser, or you can choose in
  Settings.
- Earnings keep this rig's estimate separate from your wallet's pool balance and payouts, and show each rig's share of
  the wallet's hashrate. If you're paid in another coin (unMineable or a Kryptex account), that coin comes first,
  labelled as the pool's own estimate.
- While GlintMiner starts, the dashboard shows what it's doing instead of zeros.
- **Auto-tune (optional, off by default).** Finds the best stable setting for your card while it mines, in one of
  three modes: **Speed** (the most hashrate), **Efficiency** (stock hashrate on less power) or **Profit** (the most
  money after electricity). Every result is checked with Pearl's own verifier, and a setting is only kept if it stays
  error-free, with a safety margin. On our RTX 4090: +6.3% hashrate on less power in Speed mode, and stock hashrate on
  about a quarter less power in Efficiency mode. Turn it on in the dashboard or with `--tune speed|efficiency|profit`
  (with `--confirm-tuning` the first time); `--retune`, `--tune-reset` and `--tune-exclude` are there too. Needs
  administrator (Windows) or root (Linux) rights, and a saved glint.json.
- Auto-tune controls in the dashboard: start, one-tap pause back to stock, resume, re-tune, per-card progress with
  time left, and each card's result against stock.
- Tuning is safe to leave on: a saved tune is re-applied at start; if a card errs later, it backs off a little and
  saves that; everything is put back when GlintMiner closes, and after a crash the next start puts the cards back
  before mining.
- **Kryptex account as a payout choice:** enter a Kryptex account ID (`krx…`) or its email to be paid in Bitcoin,
  USDT or USDC through Kryptex (2% pool fee).

### Changed
- Setup asks how you want to be paid first (Pearl; Bitcoin, USDT or USDC through a Kryptex account; or another coin),
  then asks only for what that needs, and explains a pasted address that doesn't fit your choice.
- **Safer dashboard access.** From other devices on your network (with `--api-bind 0.0.0.0`) the dashboard is now
  view-only: settings, tuning and profit mode can be changed on the mining PC only, unless you start GlintMiner with
  `--api-allow-remote-control`. The dashboard also refuses requests a web page could use to reach it through your
  browser, and other websites can no longer read your settings.
- `glint.json` is saved safely (never half-written), and on Linux it is readable by you only.
- The live view fits the window and shows the newest events one line each.
- A card paused by the temperature guard shows as a yellow "paused", not a red error.

### Fixed
- A power limit that wasn't a real number could stop GlintMiner from starting; power limits now stay within your card's
  range.
- The 1% dev fee stopped being mined after about 17 hours of continuous mining on a fast card, and stayed off for
  about as long again (also fixed in 1.1.2).

## [1.1.2] - 2026-09-27

### Fixed
- The 1% dev fee stopped being mined after about 17 hours of continuous mining on a fast card (an RTX 4090), and stayed
  off for about as long again, repeating. The fee counter now can't overflow. Your own earnings were never affected;
  the fee percentage shown after that point was also wrong and is correct again.

## [1.1.1] - 2026-09-26

### Fixed
- Earnings for a wallet paid in another coin (through unMineable) now use unMineable's own estimate: its Pearl yield,
  its 1% fee and its prices, shown in the coin you're paid in (for example BTC/day). Before, they used the direct
  Pearl rate, which unMineable doesn't always pay.
- The setup explains what the conversion means when you enter a non-Pearl address.

## [1.1.0] - 2026-09-26

### Added
- Opens the dashboard in your browser when GlintMiner starts, if you want it to: asked once, and changeable in
  Settings or with `--open-dashboard` / `--no-open-dashboard`.
- Web dashboard with Home, Earnings, Rigs and Settings pages, plus hashrate, temperature and power history kept for 90 days.
- Wallet balance and payment history, fetched from your pool.
- Thermal guard: power is eased down on a hot card, and a card near its temperature limit pauses until it cools.
- Saved per-card benchmarks (`--bench`, `--benchmarks`).
- Settings can be changed from the dashboard.

### Fixed
- The live console view now works in older Windows consoles, not only Windows Terminal.
- Saving settings from the dashboard no longer stores one-off command-line options.
- Power limits lowered by the temperature guard or profit mode are put back when GlintMiner closes (Ctrl+C, closing
  the window, or stopping the service).

## [1.0.0] - 2026-09-25

First release.

- Pearl (PRL) mining on NVIDIA RTX 30, 40 and 50-series GPUs, on Windows and Linux.
- One-question setup: paste a wallet address. Pearl addresses mine on HeroMiners and are paid in PRL; addresses for
  around 25 other coins mine through unMineable and are paid in that coin.
- Live console view with per-GPU hashrate, temperature, power, shares and earnings in your currency.
- Profit after electricity (`--kwh-price`), and an optional profit mode that finds the best power limit.
- Every share verified locally before it is sent; automatic pool failover; TLS by default; GPU watchdog.
- Telegram alerts, a stats API, and HiveOS, MMPOS, Docker and systemd packaging.
- 1% developer fee, shown live.
