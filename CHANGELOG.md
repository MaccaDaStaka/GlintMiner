# Changelog

All notable changes to GlintMiner are listed here.

## [1.2.5] - 2026-09-29

### Added
- **Auto-tune starts from a true stock card.** A card that already had its own overclock (a clock offset from MSI
  Afterburner, the NVIDIA app's automatic tuning or nvidia-settings, or a power limit set outside GlintMiner) is put
  to factory settings before tuning, so the tune starts from real stock. The log says so plainly: *Your card had its
  own overclock; tuning starts from factory settings and puts yours back when GlintMiner closes.* Your own settings
  come back when GlintMiner closes (or on the next start after a crash). Clock locks another tool set are released.
- **Other tuning tools are detected (Windows).** While MSI Afterburner, EVGA Precision X1, ASUS GPU Tweak, GIGABYTE
  AORUS Engine, GIGABYTE Graphics Engine, ZOTAC FireStorm, Palit ThunderMaster or GALAX Xtreme Tuner is running, a tune doesn't start (they can
  re-apply their own clocks at any time, which spoils the measurements); the card keeps mining at stock and the
  dashboard, console and log say which program to close, for example *MSI Afterburner is running. Close it (and turn
  off its 'apply overclocking at startup'), then tuning starts by itself.* GlintMiner looks again every minute. If one
  is opened while a card is tuning, that card goes back to stock and tunes again once it is closed. RivaTuner's
  on-screen display alone is fine. `--tune-ignore-tools` (or `"tune_ignore_tools": true` in glint.json) tunes anyway,
  for those who know what their tools do.
- Setup and the dashboard's tuning section remind you to close these tools before tuning; the READMEs have a short
  *Before you auto-tune* list.
- While a card tunes, the dashboard (Home, Rigs and Settings) and the console say why its hashrate is a little lower:
  every result is double-checked, and the result is measured afterwards the way the card mines, so let it finish.
  Setup says so too when you turn tuning on.

- **New guides.** The README is now a short landing page, and the details moved to guides of their own, in English,
  Russian and Chinese: *Getting started*, *The dashboard*, *Auto-tune*, *Phone access*, *For rig owners and power
  users* and *FAQ and troubleshooting*, plus a FAQ for each platform (Windows, Linux, HiveOS, MMPOS and Docker).
  They come in the Windows and Linux downloads too. The HiveOS guide now says
  stats need no setup, how to change the port so they keep working, and how to open the dashboard from another
  computer.

### Changed
- **A new logo:** a lustrous pearl with its glint, in the dashboard and the browser tab.
- **Payouts on the dashboard** show the latest five, with *Show all* for the rest and a link to the pool's full
  history, instead of a list that grew with every payout (Kryptex pays six times a day).
- **Recent events** (Rigs) show what matters: a card starting or restarting, the pool connecting or switching,
  tuning finishing or backing off, errors. Each accepted share and the minute's hashrate line are left out;
  they filled the list within minutes and, because that line always reads *rejected 0*, showed a red error dot.
- Measuring stock before a tune takes about three minutes longer: stock is measured as the card mines and again with
  the extra checks every tuning step runs with, so steps are compared with stock like with like.

### Fixed
- **Tunes no longer come out lower than they should.** A busy PC, or the extra checks themselves, made every tuning
  step look a little slower than stock (stock was measured without them): cards could end at *No stable gain*,
  efficiency could find nothing on a card with power to spare, and searches could stop early. Stock and every step
  are now measured the same way; the gain you see is still against stock as the card mines.
- **Heat during tuning no longer lowers the tune for good.** While a card is being measured, the temperature guard
  doesn't give its power back and only takes power away when the card runs well over its limit, so every measurement
  of a search runs on the same power. When a warm room (not the setting being tested) makes the card run hot, tuning
  waits for it to cool and tests that step again. Before, a warm spell late in a search could leave a tune several
  percent below what the same card found on a cooler day.
- The tuned result is measured only while the card mines normally (after the extra checks are all done, and on one
  power limit), and again when the card's power limit has changed for a while (the temperature guard giving power
  back, for example), so it keeps matching the live hashrate. A reading no card could give is measured again instead
  of being shown.
- **Rigs that run for days:** GlintMiner's hashrate counter rolls over after about 15 hours of running (sooner on
  faster cards). A tune measured at that moment could show wrong figures, fail a good step or end at *No stable
  gain*. Every measurement now reads right across it, and the console's actual dev fee no longer drifts after a day.
- **Pause and Resume carry on.** Pausing tuning, the temperature guard stopping a card, another tuning tool being
  opened, choosing the mode that is already running, or Resume with nothing paused no longer throw the search away:
  it carries on from where it was once the card is back (after a heat stop, once it has cooled). Each of these used
  to start the whole search again from stock, an hour or more each time.
- **Rigs with several cards:** one card tunes at a time, from its stock measurement to its result, so no card is
  measured while another is being tested. A card waiting its turn says *Waiting for another card to finish tuning.*
  and its time left includes the cards ahead of it, instead of 99% and *less than a minute* for hours.
- A card whose self-test fails right after a tuning step no longer restarts over and over at that step: the step
  counts as failed and tuning moves on.
- A saved tune that makes the PC crash (a blue screen or a freeze) within minutes of being applied is backed off at
  the next start, instead of being applied again at every boot.
- A card that stops responding while it tests a step has found its limit there at once. GlintMiner being closed,
  killed or losing power during a step (nothing says the step did it) tests that step once more before it counts, and
  so does a single GPU error with nothing else wrong. A step that makes another card stop can no longer restart
  GlintMiner over and over.
- A new search starts with a clean slate: crash records belong to the search they happened in (a search a restart
  interrupted keeps its own).
- After a tune backs off a notch (an error while mining), its figures are measured again at the new setting instead of
  showing the old, faster ones; in profit mode the right tune backs off.
- A search that found nothing isn't run again at every start (hours of tuning, every day): the card stays at stock
  with the reason for a week, or until you start or retune it, update the driver or update GlintMiner.
- A tuning step is judged by its own results: a check that fails after the card moved on counts against the step
  that produced it, not the next one, and on a very busy PC a step is tested again rather than judged before its
  results are all checked. A step that loses its work for a moment (a pool outage, the card restarting) is tested
  again as soon as work is back, not after running to its end.
- glint.json can no longer be damaged by two parts of GlintMiner saving it at the same moment (tuning and a settings
  change); a damaged entry in it drops only itself.
- Smaller things: the power-limit try is skipped on cards held back by something else (like an RTX 4090's power rail),
  saving a few minutes per tune; a final check that runs hot is settled the cooler way; a
  tune that has backed off doesn't look for more speed where it already failed; *Re-tuning from stock.* goes once
  every card is done; a bug in one card's tuning puts that card back to stock instead of stopping tuning.
- The time left while tuning covers everything still ahead (the rest of the search, the final check and the
  measurement after it), rounded up to whole minutes, instead of only the current part: near the end it could say
  *about 2 min left* with 15–20 minutes to go. It now mostly counts down, and grows by a few minutes at most when the
  card turns out to have more to give.
- **Tune again** starts with a clean slate for the card: settings that crashed in earlier searches (often long ago,
  in other conditions or on another version) no longer hold it back. On an RTX 4090 they had kept a retune slower
  than the tune it had found the night before.
- A new tune's result is measured again when the measurement reads below the tuning figures (a busy moment on the
  PC), up to twice, and the middle one of the readings that read right is kept. A saved tune whose measurement never
  finished is measured the next time it runs and shows as tuned only then, with the figures as mined, instead of the
  tuning figures at once.
- After a restart during tuning, the progress carries on from where it was (for example 72%, with the true time left)
  instead of starting again from a few percent; the card says *Carrying on after a restart.*
- When the dev fee's shares go to its backup pool (Kryptex, if HeroMiners can't be reached), they now carry the same
  anonymous rig label as on HeroMiners: Kryptex reads the worker name only from the login, so the fee session logs in
  there as the fee address followed by the label. The fee session on Kryptex also sends compressed shares, like
  yours; it never asks for a share difficulty of its own. Nothing changes on HeroMiners.
- **The temperature hard stop no longer stops a card over and over.** A card's slowdown and shutdown points are read
  from the driver's temperature margin, which lags the temperature when it moves fast: read while a card was cooling
  (just after GlintMiner restarted, or during a stop) they could come out several degrees low, and an RTX 4090 mining
  at 79 C was stopped as *close to its shutdown point (82 C)* every ten seconds, losing half its hashrate (its real
  points are 85 and 90 C). The points are now read only while the temperature holds still, readings that don't add
  up are not used (the driver's fixed thresholds are, and the log says so once), and a stop lasts at least a minute,
  longer when it comes back soon after.
- **After GlintMiner is killed** (Task Manager, `taskkill /F`) the next start waits a few seconds for the driver to let
  go of the card if it has to, puts each setting back on its own and reads the card back before calling it stock. A
  card that can't be put back yet is never shown at stock: it says so and isn't tuned until it is back (GlintMiner
  tries again before tuning it). *Tuning needs administrator rights* now shows only when the driver refuses for want
  of rights, not for any other error. A tune that was still on the card when GlintMiner was killed is applied again
  and measured, not backed off as if the PC had crashed.
- **The tuned result matches what the card mines after a restart.** A tune measured right after GlintMiner started
  (for example after it was killed while measuring) took what the card mined in GlintMiner's first few minutes, about
  2% less than it mines after that, so an RTX 4090 showed *Tuned +6.6%* while mining about 8.5% over stock. Nothing
  is measured as the card mines during GlintMiner's first minutes any more, nor while the extra checks are still being
  worked through; stock is measured the same way at the first start. A new tune is also measured once more right
  after it is announced, the way the card mines from then on, and the figure follows.
- **The tuned figure checks itself.** While a card is tuned, what it actually mines over a quarter of an hour of normal
  mining is compared with the figure shown. Clearly faster (1%) or slower (2%, not counting heat, the temperature
  guard or the pool), the tune is measured again, at most once an hour, and the log says so in one line.
- **A tune's safety margin no longer costs speed.** The extra checks during tuning lower a card's power draw a little,
  so a tune could pass them at full speed and then, mining normally, meet the card's power cap and run slower. The
  margin is now also judged the way the card mines: a tune held back that way is checked and measured with a slightly
  smaller margin (still a margin), and the faster of the two is kept. On an RTX 4090, about half a percent.
- **Tuning climbs as far as the card really holds.** A real gain near the top could be compared with a reading that
  ran a little fast by chance, look like none, and leave the tune a notch lower. Each gain is now compared like with
  like.
- A restart GlintMiner makes by itself (after a GPU stops responding during tuning) no longer opens the dashboard in
  your browser again: before, each one left another tab on the mining PC.
- **Tuning no longer settles short when the card crashes once on the way.** Near a card's limit a single crash can be
  a matter of luck on the day; the tune then settled a notch lower for good. It now gives that point one more, safer
  try before settling. On our RTX 4090 this is what gets it to its best result: *Tuned +7.4%*, 332.5 TH/s as mined.
- The tuning progress never goes backwards: when the time left is revised upwards, the bar holds and the time left
  grows instead (it could drop from 98% to 78%).
- Dashboard layout: the status card keeps its gap to the card below while tuning; the Rigs tuning panel spaces its
  figures (*78%about 3 min left*) and shows no second progress bar for a single card; tile subtitles wrap to two lines
  instead of being cut off (Russian on small phones); the power cost is easier to read in the light theme; the masked
  wallet stays on one line; the time-range buttons are bigger on touch screens.
- Just after a start, the wallet's rig split says the pool hasn't caught up yet instead of *This rig is 0% of your
  wallet's hashrate* (pools report a 30-minute average).
- The Settings power section no longer says *Stock clocks* (not true while tuned), and a multi-card rig no longer says
  all cards tune at the same time (one card tunes at a time).
- **An unattended start doesn't wait at a question.** With tuning on and GlintMiner started without administrator
  rights (for example from a Startup shortcut after a power cut), the question *Restart GlintMiner as administrator
  now?* now gives up after a minute and mines at stock, instead of waiting for a key while the card earned nothing.
- **HiveOS:** each card's stats reach the right card in HiveOS on a rig whose CUDA order differs from its PCI order
  (a mix of models), and a card without a temperature or fan reading no longer shifts the other cards' figures.
  Worker names keep only what pools accept (letters, digits, `-` and `_`).
- `--help` gives the right place for the log (next to `glint.json`).
- The dashboard no longer animates endlessly while a card tunes (a page left open on the mining PC drew on the GPU
  being tuned).

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
