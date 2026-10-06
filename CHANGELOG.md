# Changelog

All notable changes to GlintMiner are listed here.

## [1.2.8] - 2026-10-06

### Security
- **Remote control needs a code.** With `--api-allow-remote-control`, another device makes changes only with the
  remote-control code, printed when GlintMiner starts and shown on the mining PC's dashboard; the page asks for it once.
  A page opened through a proxy on the mining PC (`tailscale serve`, nginx) counts as another device. The Docker image
  is view-only unless you add the option yourself.
- The dev fee's own pool servers at HeroMiners and Kryptex must prove who they are (their certificate must come from
  their usual certificate authority); one that can't is skipped like a server that's down. Your own pool connections
  are unchanged. The fee's backup on your own HeroMiners server always connects over TLS (port 1200) with
  the same check, even when you mine there over plain TCP.
- The stats are readable by other web pages only from your own network; the dashboard limits connections per device
  and slow clients; a pool can no longer send endless lines, absurdly easy jobs or leave shares waiting without end.
- Settings in `glint.json` are held to the dashboard's limits when read (temperature limit, power limits, port), and
  after a crash a card's settings are put back only within the card's own ranges.
- `--diag` also hides the rig name (`--diag-keep-worker` keeps it), the remote-control code and Telegram options from
  HiveOS's extra arguments, and the file is readable by its owner only.
- HiveOS: extra arguments are passed exactly as typed (a `*` is no longer expanded; "quoted values" stay together).
- Releases come with a signed `SHA256SUMS.txt`: see *Verify your download* in the README.
- The anonymous install id in the dev-fee label and the check-in changes with each release, so it can't link a payout
  address across versions.
- **Affiliate codes can't change the fee.** The code list is signed with a key of its own, used for nothing else, under
  its own purpose (`glintminer-affiliates`): GlintMiner trusts only that key for code lists and never for updates, and
  never takes the release key for a code list. The list is checked with the key built into GlintMiner wherever it
  comes from (built in, kept beside `glint.json`, or downloaded
  over HTTPS from GitHub only), and a list is only replaced by a newer one (a withdrawn code can't come back with an
  older list). With a code the fee is still exactly 1% of the time: the developer's fee connection decides when a fee
  share is due, a quarter of those go to the affiliate. If the affiliate's connection is down, the pool refuses its
  wallet or its shares keep being refused, its share goes to the developer: never idle time, never less fee, never
  more. Idle time and the 24-hour pause follow the developer's fee connection as before. The check-in carries the code
  only, never the affiliate's wallet.

### Added
- **Affiliate codes.** Enter the code of whoever referred you in setup (*Affiliate code (optional, press Enter to
  skip)*), in Settings → Affiliate code, with `--affiliate CODE` (HiveOS and mmpOS: in the extra arguments; `off`
  removes it) or as `"affiliate"` in `glint.json`. You still pay 1%: a quarter of it (0.25% of the time) mines to the
  affiliate's PRL wallet instead of the developer's, on the dev fee's own servers, with the worker name `glint`. Codes
  come from a signed list in a public repository of their own (GlintMiner-affiliates), checked on the rig; GlintMiner looks for a newer list (at start
  and once a day) only when a code is set. A code that isn't in it is *not recognised*, and the whole fee goes to the
  developer. The dashboard shows *Affiliate: CODE*, the console *affiliate: CODE*. You can't use your own code: one
  that pays the wallet the rig mines to gives no split (the whole fee goes to the developer). The list is signed again
  every few days; if GlintMiner can't get one issued in the last 14 days, it says *the affiliate list is out of date*
  and the whole fee goes to the developer until it can.
- **Become an affiliate.** Settings → Become an affiliate, or `glint --become-affiliate` on a rig without a screen:
  earn a quarter of the fee from every rig that uses your code, paid by the pool to your PRL wallet. It shows exactly
  what is sent (the PRL payout wallet you give, your Discord username if you give it, the install's anonymous id and the
  version) and sends it only after you tick the confirmation (or type `yes`). The developer checks each request by
  hand; the dashboard (or `--become-affiliate` again) shows whether it is waiting, approved (with your code) or not.
- A link to GlintMiner's Discord in the dashboard's footer, the README and the FAQ.
- **Faster RTX 50 cards held by the driver's power cap.** An RTX 50 card now has a second way of mining that leans
  on the card's memory instead of its cores. At start (and when a card first goes to Most hashrate) GlintMiner mines
  a minute or so each way, shows the card as starting meanwhile, and keeps the faster: on an RTX 5090 that the driver
  holds well under its power limit that is +2.5% verified at stock and about +3% with Most hashrate's tune; on a
  card with no such cap (an RTX 5060) or one held by its power limit it keeps the usual way. Less power and Cool always
  mine the usual way (it uses the least energy per hash); Best earnings uses the way of the tune it runs.
- **RTX 50 cards: three more ways of mining, and each card keeps its fastest.** In the same comparison at start (and
  when a card first goes to Most hashrate), every RTX 50 card (compute capability 12.0: every RTX 50 card sold so far)
  now also measures these, at its own power limit and settings, and keeps the one that does the most work, if it is at
  least 1% faster than the usual way:
  - a third way for cards held by the driver's power cap (an RTX 5090: 395.5 TH/s at stock against 383.0 the usual
    way), with a leaner version of it for cards at their top clock or their power limit (kept only when 1% faster than
    the third way too). It suits a lowered power limit best: about 397 TH/s on an RTX 5090 set to 500 W;
  - a wide way that works on bigger blocks, so the card moves less data per hash: 402-408 TH/s on an RTX 5090 at stock;
  - a way shaped for the biggest cards: 423-426 TH/s on an RTX 5090 at stock (a 600 W card), every share valid at
    the pool (0 invalid in two checks of 10 and 12 minutes). It needs 3 GB of free video memory; a card short of it
    mines on without it.
  A card where they're all close (an RTX 5060) keeps the usual way. Most hashrate tunes on whichever way wins; Less
  power and Cool mine the usual way.
- **Compare modes.** Next to each card's mode on Rigs, and in Settings → Tuning for the whole rig, *Compare modes*
  shows every mode side by side (stock, Most hashrate, Less power, Cool, Cooler, Coolest and your settings now): TH/s,
  W, TH/s per W, earned, electricity and profit per day at today's coin price and your electricity price, the most
  profitable highlighted (and which of Most hashrate and Less power Best earnings would run). Each figure says whether
  it was measured on the card or is an estimate (from the card's own stock, else our measurements and simulations of
  its model, else, for a model we have no figures for, the shares of stock only). View-only pages can see it; it
  changes nothing. In EN/RU/ZH, as stacked rows on a phone, and in /api/stats as `mode_guide` (per card) and
  `mode_guide_total`, outcomes only. The auto-tune guide explains how Cool picks its power, with an RTX 3060 Ti example.
- **Updates from the dashboard, checked against the release signature.** When a new version is out, the dashboard
  and console say so with a few lines from its release notes: *Update now*, *Later* (asked again in about a day) or
  *Skip this version*. Settings → Updates (or `--auto-update`) chooses *Ask* (the default), *Install automatically*
  (at a moment no card is in the middle of a tune, then a restart) or *Don't check*, with *Check for updates now*;
  `glint --update [VERSION]` does it from the command line. Nothing is installed unless `SHA256SUMS.txt` carries a
  valid signature from the release key built into GlintMiner, the package and its program match it, the version is
  newer (an older one only when picked by hand) and the new program starts and reports that version; otherwise
  nothing changes. The previous program is kept (`glint.prev.exe` / `glint.prev`) and put back automatically if the
  new version fails at start or keeps stopping in its first 15 minutes ("Update to X didn't run properly on this
  rig, so GlintMiner went back to Y"). Settings, wallet and saved tunes stay. On HiveOS and mmpOS GlintMiner shows
  the package link for the flight sheet instead, and in Docker the version to rebuild with.
- **When a card finishes tuning, the dashboard asks what to do with it**: "GPU 0 tuned: +6.9% hashrate at 433 W
  (stock was 309.6 TH/s at 444 W)" (or the power saved, in Efficiency and Cool, with Cool's strength and "as far as
  this card goes" when it stopped short), with *Keep it* (the default: the tune
  stays on), *Back to stock* (the card's mode off; its tune is kept for later) and *Tune again*. Asked once per result;
  the console says it once too. Not shown on a view-only device's page. The API has it as each card's
  `tune.just_tuned`, answered with `{"action":"dismiss","gpu":N}` on `/api/tuning`. A Cool tune from an older version
  replaced by one for its strength is asked about too.
- **RTX 20-series cards mine.** RTX 2060, 2070 and 2080 cards (SUPER and Ti included) and the CMP 40HX mining card
  now mine Pearl, with a search kernel of their own whose instruction schedule is written out by hand for these
  cards. At stock settings a rented RTX 2070 SUPER mined 63.6 TH/s of work verified share by share on a pool, 3.3%
  more than the other miner tested side by side on that card, and a CMP 40HX 45.8 TH/s at its 135 W limit (the search
  runs in short launches that keep the card's units reading the same operands together: the memory controller is busy
  30% of the time instead of 37-40%, 2% more than the 44.8 TH/s of one long launch). Every hit is checked on the CPU before it is sent, as on every card. GTX 16-series cards and others
  without tensor cores are skipped with a plain message. Auto-tune is new on these cards: one whose driver doesn't
  offer the clock controls tuning needs mines at stock and says so.
- **Anonymous check-in, disclosed and easy to turn off.** About 2 minutes after the start and then every 15 minutes,
  GlintMiner tells the developer anonymously that a rig runs: the install id from the fee label, a random id for the
  run, the version, OS and platform, card models and counts, total hashrate and board power, payout type, uptime;
  per card its model, hashrate, power, temperature, fan and time waiting for the CPU; share counts, GPU errors and
  self-recoveries, how the previous run ended and why in one word (a GPU that stopped responding while tuning or
  otherwise, with its GPU number; an update, rollback, new settings, a stop, a crash), self-restarts in the last 24 h
  (a crash's place in the code as `file.rs:line`, never its text);
  auto-tune's outcome (off, tuning, tuned or partly, the mode, cards tuned/tuning/waiting/stock); per card tuning,
  its stage in outcome words, share done, time left and so far, the watts its Cool strength aims for and how many steps
  it backed off (the rig's longest time left and share done); the dev fee's state
  (paying through its pool or yours, idle with its servers unreachable, reconnecting); the update setting and any
  rollback; the NVIDIA driver version. Never the wallet, worker name, pool, Telegram, host name, folders, IP address
  or any tuning setting (clocks, offsets, limits, voltages, steps); the start-up log lists what is sent. It shows how
  many rigs run which versions and cards, whether they run well, and whether the dev fee arrives. `--no-telemetry` (or `"telemetry": false` in
  `glint.json`) turns it off; a failed check-in is never shown and never slows mining. See the README.
- **`--tune-at-once N`: tune several cards at the same time** (default 1, one at a time as before). A whole rig tunes
  in fewer hours, with a clear warning: every card tuning runs at factory settings (stock clocks and power, often much
  hotter and louder than your own overclock) until its tune is found, so N at once means N cards at stock together.
  Set fixed fan speeds (70% or more) and make sure the rig's cooling and power supply can take it. GlintMiner logs this
  warning at every start while it's set. If a crash takes down cards that were testing settings together, each
  setting counts against its card, so the same crash can't restart GlintMiner over and over; a card that has found its
  tune finishes its last check while the others still tune.
- **Big rigs tune without running hot for hours.** Cards tune one at a time, an hour or two each, so on a rig of six
  or twelve cards the last one waits most of a day, and until now every card waiting its turn mined at stock: the most
  power it draws, often well above your usual power-limited or HiveOS setup. Now a card waiting its turn keeps your own
  core overclock or power limit if it has one, and otherwise mines at three quarters of its default power limit (never
  under its minimum) until its turn, shown as *Waiting (reduced power)*. A memory offset alone (HiveOS's usual memory
  underclock, or a memory overclock) stays on and doesn't keep the card at full power, and a card is looked at again
  while it waits, so an overclock cleared in HiveOS meanwhile doesn't leave it at full power for hours (in testing an
  RTX 2070 waited at its full 175 W, shown as on its own settings). It gets its full limit back a few minutes
  before its turn, so its stock is measured as it really is, and the rig takes no longer to tune. In the simulation,
  a rig of six RTX 3090s and a 4070 Ti drew 1,880 W instead of 2,380 W while its first card tuned (2,170 W instead of
  2,410 W averaged over the whole 6-hour tune), and twelve RTX 5060 Ti 1,660 W instead of 2,150 W. When a tune starts
  on a rig, the dashboard and the console say how long it takes and how the waiting cards run (*Tuning 6 cards one at
  a time, about 9 hours. Cards waiting their turn run at reduced power until then.*). Cards with a saved tune just run
  it; cards you keep at stock or set to off are never touched. The limits are put back when GlintMiner closes, and
  after a crash or a kill at the next start. With `--tune-at-once`, cards waiting for a slot do the same.
- **Heat on a rig slows the waiting cards first.** When any card gets near its temperature limit while cards tune,
  the cards waiting their turn are held lower (down to their minimum) before the card being tuned is slowed; they go
  back up once the rig has been cool for a few minutes.
- **A power budget for the rig while it tunes (optional).** `--tune-power-budget 1800`, or **Settings → Temperature
  and power**: the whole rig's board power stays under that many watts while cards tune. Waiting cards are held lower
  first; a card starts tuning only when the rig fits the budget with that card at full power (with `--tune-at-once`,
  every card tuning counts), and a card tuning waits again if the rig stays over the budget for minutes anyway. When
  the cards already tuned draw too much for the next card to tune, that card says so with the watts missing. Under a
  budget, *Most hashrate* doesn't raise a power limit above the card's default. Off by default.
- **A tune changed from outside GlintMiner is put back.** Applying an overclock in HiveOS (even just to change the
  fans) rewrites every card's clocks, memory clock and power limit, and a tuned card went back to its full default
  power (a tester's 3090: 390 W instead of about 220). GlintMiner now checks every 30 seconds: a tuned card gets its
  tune back, and a card in the middle of a tuning test runs that test again with its settings back (the test would
  otherwise measure the wrong settings). Changed again within the hour, a tuned card's settings are taken as meant and
  left, and the card says so; restarting GlintMiner puts the tune back. A line in the log each time.
- **Tuning on older Linux drivers (470 to 550).** Auto-tune used the clock controls NVIDIA added in driver 555, so a
  HiveOS rig on 535 or 550 (still common) mined at stock and said "Tuning needs a newer NVIDIA driver". On Linux
  GlintMiner now falls back to the driver's older clock controls. Windows still needs 555 or newer.
- **`glint --diag`: one file to send for support.** It holds the last runs' logs, the cards as the driver reports
  them, the settings with the wallet and Telegram details hidden, and the GPU driver's error log (Linux), all written
  locally (on HiveOS to `/home/user`) and sent nowhere.
- **Kryptex account (paid in BTC): this week's PRL price range next to the estimate.** Kryptex converts PRL to BTC at
  the price of the moment and doesn't publish its rate, so what it credits swings with PRL's price (−17% to +34% in a
  recent week). The dashboard shows the day's BTC across the week's lowest and highest price, and the console how far
  the price moved, from Kryptex's own price feed.
- **Each start says how the previous run ended:** closed normally, restarted itself because a named GPU stopped
  responding, or stopped from outside (a watchdog, Task Manager, a power cut), with the time.
- **A tuned card that backed off earns its setting back.** A card that moved to a safer setting after an error used
  to stay there until you tuned it again. Now, after three days of stable mining at the safer setting, running no
  hotter than when it erred, it tries its tuned setting once more under the same long check as the original tune
  (never in GlintMiner's first hour, during a game pause, or while another card tunes). If it holds, the tune is back
  and the dashboard says *Regained its tuned setting after 3 days of stable mining*; if not, the card goes straight
  back to the safer setting and waits twice as long before the next try (6 days, then 12), and after the third try
  keeps the safer setting until you re-tune. A setting that stopped the card twice is never tried again; a tune the PC
  crashed at keeps its safer setting for good. The back-off note now says it will try again by itself. In every mode,
  Best earnings' two tunes included.
- **Cooler days in every mode.** A card tuned for *Less power* or *Cool and quiet* that later runs clearly
  cooler than when it was tuned tries a little less voltage at the same speed, at most once a day and with the same
  long check: less power at the same hashrate, never faster or hotter. (*Most hashrate* already looked for more speed
  on cooler days.)

### Changed
- **Hot memory counts as heat.** RTX 3080, 3090, 3090 Ti and 4070 Ti and up can reach their memory's own temperature
  limit while the card's temperature reads fine. When the card slows itself for heat like this, the temperature guard
  now lowers its power until it no longer has to (as for any card over its limit; administrator rights needed), and
  gives it back once the card has run cool for a few minutes. The log says why. While a rig tunes, it also holds the
  waiting cards lower first.
- **Temperature limits on the command line, and per card.** `--temp-limit auto|off|78` for every card, and
  `--temp-limit-card 1=72,3=75` for a card of its own (one between two others, or by the power supply), by number or
  PCI bus id, 60 to 95 °C and never above the card's own maximum. The temperature guard and auto-tune keep to it, and
  the dashboard shows each card's limit. Saved as `temp_limits` in `glint.json`.
- **You choose how much power Most hashrate may add.** **Settings → Temperature and power → Extra power for Most
  hashrate**, or `--speed-power-raise`: *none* (never above stock), *low* (up to 10% more per card), *medium* (up to
  25%) or *max* (up to each card's own maximum, the default, as before), each shown with what your rig's power limits
  come to; or a number of watts per card. One card can have its own with `--speed-power-raise-card 0=none,1=50`. A rig
  only draws all its cards' extra power together once every card runs its tune, so when two or more cards tune in Most
  hashrate the console and the dashboard say what the rig's power limits may total by then (at each choice, so you can
  pick one your power supply carries with headroom), and the console says what they total once tuning is done. A
  tune made with more power than you now allow runs at the most you allow from then on, without tuning again. A rig
  power budget still wins: under one, no limit is raised.
- **Cool and quiet (was *Coolest and quietest*) now saves a set share of power, at a strength you choose.** It looked
  for the most hashrate per watt, and on many cards that ended next to *Less power*. It now uses about a quarter
  (*Cool*), a third (*Cooler*, the default) or 45% (*Coolest*) less power than stock, always clearly less than *Less
  power* on the same card, and gives up some hashrate for it. It never goes below 70% of stock speed: a card that gets
  there first stays at 70% and its result says *as far as this card goes*. Choose the strength next to the mode on the
  dashboard (the rig's mode, each card's, the tuning panel and the schedule), with `--cool-strength
  cool|cooler|coolest` (saved as `cool_strength` in `glint.json`; files without it get Cooler), or in a mode:
  `--tune cool:coolest`, `--tune-card 0=cool:coolest`, `--schedule 23:00-07:00=cool:coolest` (plain `cool` is the
  rig's strength). Each strength keeps its own saved tune, and a schedule switches only to a strength a card has a
  tune for. Setup's Cool and quiet choice is Cooler. A Cool tune saved by 1.2.6 or 1.2.7 is replaced once: the first
  time a card runs Cool and quiet on 1.2.8 it tunes again for its strength (the log says so).
- **The tuning choices say what you get, and Cool and quiet shows its watts for your card.** Each mode and strength
  now reads as speed and power against stock, and who it suits: *Cool* about 90% of stock speed on about 25–50% less
  power, *Cooler* about 80% on 35–55% less (recommended), *Coolest* 70–75% on 45–60% less; *Less power* keeps full
  stock speed on under 10% to nearly half less, depending on the card; *Most hashrate* usually 4–9% more (ranges from
  our calibrated simulations of RTX 20 to 50 cards). Once a card's stock power is measured, the picker shows what each
  strength aims for on it, e.g. *Cool ~137 W · Cooler ~118 W · Coolest ~100 W (stock 182 W)* (a range across a rig's
  cards; *up to* until the card's least power at stock speed is known), a card tuning for Cool and quiet says *aiming
  for about 118 W (stock 182 W)*, and the log names the aim once. The same words in `--help` and setup; `targets_w` in
  `/api/stats` for each card.
- **Dev fee: if its pools can't be reached, it's paid through your own pool; if that fails too, 1% of the time is left
  idle instead (never more than 1%).** Blocking the fee's servers used to leave the fee unpaid while mining went on.
  The fee now has backups on the server you mine on (HeroMiners, Kryptex or unMineable), logged in with the fee's
  address; your own shares and login are untouched. If no fee server answers for 10 minutes, the fee's 1% of the time
  is left idle instead of mined for you. The console and dashboard say which (*fee pool reconnecting*, *fee pools
  unreachable: 1% of time left idle*), and after a day without a fee share they show a lasting notice to check the
  network or firewall.
- **Dev fee blocked for a day: mining pauses until it can connect.** If the fee has had no working connection for 24
  hours (neither its own servers nor its backup on your pool) while your own pool worked, mining pauses on every card
  and the console, log, dashboard and check-in say why (*The developer fee hasn't been able to connect for 24 hours
  ... mining is paused until it can*). The fee keeps trying in the background and mining carries on by itself as soon
  as it connects through any route. Restarting GlintMiner doesn't start the 24 hours over; the fee connecting once
  does. Time when your own pool can't be reached either (the internet down) never counts, and mining is never paused
  for the fee then; a PC asleep or a clock change doesn't count either. The FAQ explains what to allow, and the secure
  DNS settings (`--dns-over-https`, `glint --net-test`) for networks that block it.
- **A wrong PC clock is named as such.** When the fee can't connect because the PC's date is far off (the fee servers'
  certificates then read as expired or not yet valid), the console, log, dashboard and check-in say so, with the date
  the clock reads (*The developer fee can't connect because this PC's clock is wrong (it reads ...). Set the correct
  date and time; mining carries on once it connects.*), instead of a blocked network. The pause still applies.
- **The dev fee's connection is labelled as such in the log and only reports changes.** Its lines start with
  *dev fee (1%)* (they read like a second pool); connected, reconnecting and left idle show once, a run of reconnects
  as one count every 15 minutes, and the routine detail goes to `glint.log`.
- **A new tune is watched more closely for its first day.** A setting can pass its 5-minute test and still fail once
  later, as temperatures drift; for 24 hours after a tune GlintMiner checks the card's results twice as often (about
  0.25% of hashrate, that day only), so a rare error is caught sooner. While other cards on the rig are still tuning,
  their tests come first.
- **A slightly faster kernel:** on the RTX 4090, +0.9% at the same clock and +1.3% on a speed tune; the same at stock,
  where the card is limited by its power. RTX 30 cards run the same code; RTX 50 cards too, with one more change of
  their own (+0.2% on an RTX 5080 at stock).
- **A saved tune is checked again when the mining code changes.** A new kernel can move the setting a card holds, so
  the first start of a version with new mining code checks each saved tune once (about 20 minutes per tune; the card
  mines meanwhile): the tune is kept if it still holds, and tuned again if it doesn't. The dashboard says *the mining
  code changed* while it runs. Expect this once after updating to 1.2.8.
- **Saved tunes are stored in a new protected format.** Tunes saved by 1.2.5 to 1.2.7 load as before and are
  rewritten in the new format; a saved tune that has been edited by hand is ignored and that card tunes again.

### Fixed
- **Dev fee and pools reachable on networks that poison DNS (e.g. mainland China) via secure DNS.** On a rig in
  mainland China the dev fee couldn't reach any of its servers ("connection refused", "no answer", "connection cut")
  while the user's own pool worked, so the fee's time was spent idle. Now:
  - A secure connection that the network cuts because it names the pool (HeroMiners, Kryptex) is made again without
    the name; the pool's servers answer the same either way, and the dev fee still checks the pool's certificate.
  - When every address the network's DNS gives for a pool fails, or it gives none, the name is looked up by secure DNS
    (DNS over HTTPS, at Cloudflare, Google, AdGuard, OpenDNS, AliDNS and DNSPod, reached by IP address and checked by
    certificate), and as a last resort the dev fee's servers' known addresses are used. The log says once when this
    was needed.
  - A server your pool connection already reaches is reached at the same address by the dev fee's backup on it.
  - Your own pool can use secure DNS too: `--dns-over-https auto` (when the usual addresses fail) or `on` (first), or
    `"dns_over_https"` in `glint.json`; off unless you set it. `--net-test host:port` also shows what each secure DNS
    resolver answers.
- **Most hashrate no longer reports a gain that isn't one.** On an RTX 5090 on the second way of mining, a finished tune
  said "+0.8% hashrate" while the pool showed it mining the same as stock (it only saved 8-14 W). A gain under 1% is
  inside what a measurement can tell from stock: it is now said as "same hashrate" (with the power it saves, where
  that is 1% or more), and a card whose best setting gains under 1% and saves under 5% power stays at stock ("No
  stable gain over stock; staying at stock.") and isn't searched again at every start. Gains of 1% and more, and
  the same hashrate on 5% or more less power, are shown as before.
- **Rigs with several cards: a crash while one card tests a setting no longer costs the other cards their tunes.** A
  blue screen, power cut or driver reset while one card tested a setting could back off the tunes of the cards already
  tuned, for good. The setting being tested is now the one blamed, and an error the driver spreads to every card is
  put on the card being tested, not on a tuned card that reported it first.
- **A tuned card paused for heat keeps the lower power it was given when it carries on.** With Most hashrate in a hot
  room, a card paused for heat used to get its full tuned power back as it resumed and was paused again every 20
  minutes or so. It now carries on at the power its cooling holds and gets the rest back once the room cools.
- Started by Windows Task Scheduler (which runs programs at below-normal priority), GlintMiner could be starved by
  other busy programs: no shares for minutes, job updates late, the dashboard not answering. It now runs itself at
  normal priority (`GLINT_KEEP_PRIORITY=1` keeps the priority it was started with); on Linux, started with a raised
  nice value, it goes back to nice 0 where it is allowed to (as root).
- **A card whose driver stops responding during tuning.** A rented RTX 5090's driver stopped responding mid-tune
  (Linux, GPU microcontroller halt): it mined on, but its settings could no longer be changed or reset and its readings
  froze, while the dashboard said it "mines at stock". GlintMiner now notices at once (the driver answering "not
  ready", or readings frozen while the card mines), keeps that tuning step and anything bolder out of the tune for
  good, and says on the card: the driver stopped responding, the card keeps mining, its temperature can't be read and
  its settings can't be reset until the PC restarts. After the restart tuning carries on from where it was. A second
  such crash on the same card tunes it without holding its memory clock. Frozen readings are no longer shown or acted
  on (the temperature guard included), the card's stall isn't blamed on the processor, and the check-in flags that the
  PC needs a restart. On Windows, a driver that resets itself is picked up and tuning carries on.
- **A card whose driver has stopped responding for half an hour is paused, not retried.** Until now GlintMiner kept
  restarting such a card, and could restart itself over and over for it while the other cards lost their mining time
  too. After 30 minutes without an answer from its driver (counted across GlintMiner's own restarts), the card is
  paused with *driver stopped responding — restart the PC to bring this card back*, said once in the log, shown on the
  dashboard (EN/RU/ZH) and in the API, and the check-in reports the card as paused for its driver (and that the PC
  needs a restart). The other cards keep mining, and GlintMiner no longer restarts itself for that card. If the driver
  answers again by itself (Windows can reset it), the card mines again; starting GlintMiner again tries it afresh.
- A tuning error that left a card changed no longer says the card is at stock.
- A `glint.json` saved by Notepad or PowerShell (with a byte-order mark at the start) loads, instead of being called
  not valid.
- **Auto-tune on a card too hot for its full power.** A card that reached its temperature limit at full power while
  it tuned (a rented RTX 5080 in a case that couldn't cool it: paused at 85 C, mining again, paused again, every couple
  of minutes) never got past measuring stock. The temperature guard now acts before the card is paused for heat, and a
  pause for heat also lowers the card's power, so it mines again at a power its cooling holds. The tune then runs within
  what the card's cooling allows, and says so; a card that keeps getting too hot even so stops tuning and says "This
  card is too hot to tune: improve its cooling or airflow, or choose Cool and quiet" (it mines at stock meanwhile, kept
  within its temperature). A room that warms up while a card tunes no longer pauses it at every step: after a passing
  heat wave the tune carries on; in a room that stays hotter it starts again within what the card's cooling allows. A
  card the temperature guard has paused no longer gets its power back while it is paused (it read cool only because it
  had stopped).
- A card at stock after a tune that found nothing shows why again once a pause (heat, a game, the schedule) is over,
  instead of "Paused by the temperature guard".
- The check-in's start-up line in the dashboard's events is no longer marked as an error (it lists "GPU errors" among
  what it sends).
- **GlintMiner always recovers by itself when part of it stops answering.** A watchdog of its own restarts it when the
  main loop or the GPU readings stand still for 2 minutes, or when a stop (Ctrl+C, HiveOS ending the miner) hasn't
  finished in 30 s: the cards' clocks and power limits are put back first, and the next start says "stopped responding;
  restarted itself". Before, such a GlintMiner stayed up doing nothing, kept the dashboard port and needed a kill.
- A lock taken in opposite orders by the auto-tuner (cards waiting their turn) and the dashboard's tuning summary could
  stop the main loop, the dashboard and the tuner at once while a card tuned. Driver readings and clock changes no longer
  hold the locks the dashboard needs, and the dashboard and stats always answer within a few seconds.
- When the dashboard port is taken, GlintMiner waits a few seconds for an earlier copy to let go, then says who holds it:
  an earlier GlintMiner that stopped responding (with the command that ends it), one still running, or another program.
  On HiveOS a GlintMiner left behind from the same folder is closed (then ended) before the miner starts.
- **No more 0 TH/s in silence.** Cards that gave up after their restarts get a fresh start of GlintMiner; when that
  hasn't helped 3 times within an hour and no card mines, GlintMiner stops and says plainly that the PC needs a restart
  (the console, Telegram, the next start, and the anonymous check-in). Before, a rig whose cards all failed kept
  running and mining nothing.
- When one card's error ends every card's work (the driver does that), it counts as that card's error only: the miner
  restarts once and the other cards aren't charged a restart, at stock settings too.
- Connections try every address of a server, IPv4 and IPv6 in turn; IPv6 on a PC without it (HiveOS) is tried last, and
  the error shown is the one that happened (an address that didn't answer), not "address family not supported".
- **The tuning bar no longer sits at 99% with time still to go.** The bar never went back, so once a card's last
  measurement had taken it to 99%, a back-off or a restart that added steps left it there while the time left grew (a
  tester's RTX 2070: "99% · about 25 min left" after 91 minutes, 78% by the time). It now follows the time left when
  that grows by more than a little (small revisions still hold it), stops at 98% while over 2 minutes are left, and
  the rig's bar does the same.
- **On a big rig, a card's last check waited for hours.** After a card has found its tune, it is measured as it mines
  while the rest of the processor's stability checks are quiet. On a rig the cards tuned earlier were still in their
  first day of closer checks, which kept the checker from ever looking quiet: in the simulation a seven-card rig spent
  20 hours on one card's last check (27.6 hours to tune the rig, now 6 hours). Tuned cards now step their closer checks
  aside while another card measures, and a rig's normal checks no longer count as a backlog.
- **Cool's strengths no longer land on the same result.** On some cards Cool could end on the same result as Cooler
  (an RTX 2070 in testing: both at 108 W). Cool, Cooler and Coolest now always save clearly more power in that order;
  Coolest may stop at 70% of stock speed, and says so.
- **A card's own memory underclock stays on while it tunes.** A lower memory clock (HiveOS's memory -2000, common for
  Pearl, whose mining barely uses the memory) counted as an overclock: tuning put it back to factory settings while
  GlintMiner ran, so the card drew more than with your own settings. It now stays on: the card tunes and mines with it,
  goes back to it whenever it goes back to stock (and after a crash), and the log says so once. A memory overclock, a
  core overclock or a power limit of your own still go to factory settings for tuning and come back when GlintMiner
  closes.
- **Backup pools are reached when the first pool's server is blocked.** A connection to a server that drops packets
  (a firewall) waited about two minutes on Linux, and that wait made the reconnect start over on the same server, so
  the backups were never tried. A connection now gives up after 10 seconds and the next server is tried.
- **The live console view no longer leaves old copies of itself above it** (it's drawn on the terminal's alternate
  screen, as tools like `top` do; the normal screen comes back when GlintMiner stops).
- **Windows: clicking in GlintMiner's window no longer pauses it.** Windows' QuickEdit mode froze the output, and
  with it the program's main loop, until a key was pressed; GlintMiner now turns it off for its own window.
- **HiveOS keeps the previous runs' logs.** Each start used to overwrite `/var/log/miner/glint/glint.log`, so a restart
  wiped the log that said why it happened. The previous two runs are now kept as `glint.log.1` and `glint.log.2`.
- At every start the log could say a card's sensors couldn't be read, so it couldn't be tuned, and then the card
  tuned normally: the sensors were still opening. GlintMiner now gives them up to two minutes before saying so.
- **Cards that don't offer every clock control no longer end in a tuning error.** A card or driver that refuses one of
  the controls auto-tune uses (some RTX 20 and mining cards on newer drivers) is told apart from an old driver: it
  mines at stock with *This card doesn't offer the controls tuning needs*, decided within a minute of the start.
- `--bench` reports the average power, clock and hashrate per watt, and `--self-test` and `--bench` also write to
  `glint.log` (to send on from a rig reached over SSH).
- The dashboard reads a tuned card's saving as *43% less power at 90% of stock speed* (it said *-43% less power*).
- A card tuned for less power or Cool and quiet is held to its tuned hashrate in "of expected", not to its stock
  speed (it showed an amber 88%).
- A power limit set outside GlintMiner (HiveOS, Afterburner) is shown as such on the dashboard, not as one GlintMiner
  puts back when it closes.
- **The temperature limit acts from its first step on a card that runs under its power limit.** It lowered the power
  limit 10 W at a time from the limit itself, so on a card held lower by its own cap (an RTX 5080 draws 339 W of its
  360 W limit) the first two steps changed nothing. Each step now starts 10 W under what the card draws, and the power
  comes back to the card's own limit once it cools.
- **A busy processor no longer leaves the cards mining old work.** Each new job from the pool is prepared on the
  processor (about 0.1 s) at a lowered priority, so the cards go first on a weak processor. On Windows, while another
  program kept every core busy (a tester's full Defender scan), that preparation waited minutes: the cards stayed
  100% busy on jobs the pool had long replaced, and 720 of about 1,700 shares came back stale (in the lab, on a
  4090 limited to 8 busy processor threads: one job took 164 s to prepare and no share counted for three minutes
  while the hashrate read 312 TH/s). A job not ready after 1.5 s (or three times this PC's usual time) is now
  prepared at normal priority, and shares that wait for their check more than 2 s are checked at normal priority
  too. Once the pool has called a share of a replaced job stale, a card no longer mines a job replaced for longer
  than that; it waits for the new one instead of making shares the pool won't take. The console and dashboard say
  *The processor is too busy to prepare new work in time; some shares may arrive late* while it lasts (EN/RU/ZH),
  the log says how late, and the stats API has `work.late`, `work.job_lag_s` and each card's `job_lag_s`.
- Auto-tune no longer spends its first step holding the memory clock where it already is. On a card whose driver lists
  a single memory clock (an RTX 5060), or one that already mines at the clock the hold would pick, that step changed
  nothing; tuning now skips it there (RTX 30 and 40 cards hold their memory as before).
- When a pool closes a connection that was working (HeroMiners drops idle workers about every 15 minutes, so the dev
  fee's connection saw it often), the log no longer says to check this PC's date and time or its antivirus. The dev
  fee says "the pool closed the connection; reconnected" once it is back; your pool's line says the connection was
  cut. The date, time and antivirus hint now shows only when a secure connection can't be set up twice in a row.
- Efficiency's time left now counts down while it tunes. It could sit at about the same figure for twenty minutes
  or more (an RTX 4090 showed 12 minutes left, then 12 and a half twenty minutes later); it may now start a little
  longer and end sooner than said.
- Cool and quiet no longer repeats what an Efficiency tune already found on the same card. After an Efficiency tune
  from the last week (same card, driver and mining code, and stock reading as it did then), Cool starts from it and
  only tunes for its own power aim, in about half the time (an RTX 4090 in the tuner's simulation: 26 minutes instead
  of 47; the acceptance run's took 71).
  An older Efficiency tune, or a card that reads differently now, gets Cool's whole tune as before.

## [1.2.7] - 2026-09-30

HiveOS fixes only; the miner itself is unchanged from 1.2.6. **On HiveOS:** in the flight sheet's custom miner, set
Miner name `glint` and Installation URL the link to `glint-1.2.7.tar.gz`, then apply. On Windows and Linux there is
nothing new beyond the version number.

### Fixed
- **The HiveOS package installs.** HiveOS takes a custom miner's name from the package's file name (everything before
  the version), and `glint-1.2.6-hiveos.tar.gz` read as a miner called `glint-1.2.6` while the package holds `glint`:
  HiveOS either refused the name or installed a miner it then couldn't find ("no screen matching miner"). The HiveOS
  package is now `glint-<version>.tar.gz`; the Miner name stays `glint`.
- HiveOS: the start script loads the package's own settings (config and log paths) and makes its log folder, instead
  of relying on HiveOS to pass them on.
- The HiveOS package says its own version to HiveOS (1.2.6's `h-manifest.conf` still said 1.2.5); the packaging now
  writes it from the release number.

### Docs
- HiveOS FAQ: what "There is no screen to be attached matching miner" means (the Miner name must be exactly `glint`),
  with the template and Pool URL mistakes that stop a start.

## [1.2.6] - 2026-09-30

### Fixed
- **A card that goes dark while it tunes comes back by itself.** When a card's driver fell over during tuning (an RTX
  3070 reported *out of memory*, then an unknown error), GlintMiner retried five times in the same process and gave
  up, and the screens stayed black until the PC was restarted. Any GPU error while a card tunes now restarts
  GlintMiner fresh, which recovers the card, and says the card hit a GPU error.
- **Tuning starts with its gentlest change on its own.** The first thing tuning does now changes nothing but the one
  setting that saves power without touching the clocks, so a card that can't take it is found out on a step that
  changes nothing else. Such a card then tunes without it, and GlintMiner remembers that for the card (tuning it again
  won't try it again); a PC that froze on that step never gets it a second time.
- **"Next payout in …" counts every rig on your wallet.** The time to your next payout assumed only this rig was
  filling the balance; with other rigs mining to the same address (any miner), it came out too long, about twice as
  long with two similar rigs. It now uses this rig's live rate plus every other rig the pool lists on the address.
- A tiny leftover in the pool's balance (its rounding) shows as 0, not as *2.14e-9 PRL*.
- **A tuned card gets its tune back after a pause.** After the temperature guard had stopped a tuned card, or you
  paused and resumed tuning, the card mined on at factory settings until GlintMiner was restarted.
- After a pause or a wait for work in the middle of a tuning step, the step's stability checks no longer flood the
  checker for a few seconds (*hit checker is far behind*): the rate they're sized by counts mining time only.
- **Paused time no longer counts against a tune.** A card's tuned figure is checked against what it mines over each
  quarter of an hour; a stretch that included a pause (yours, the temperature guard's, a game's) read as a slow card
  and had it measured again for nothing.
- Profit mode's power-limit sweep waits while mining is paused, and leaves out a limit that was measured while it was.

### Added
- **Coolest and quietest, a new tuning choice: the most hashrate per watt.** From the stock clock it steps the card
  down a level at a time, finds the lowest voltage each level runs at, and keeps going while every watt earns more,
  never below 70% of stock speed; it settles where the card is quietest for what it mines and checks that as the other
  choices do. On our RTX 4090: 302.8 TH/s at 328 W as mined, 26% less power at 98% of stock speed. On a tester's
  RTX 3070: 66 TH/s at 95 W, half the power at 87% of the speed, better than his own hand tune.
- **Setup asks what you want, not how to tune:** Off (the default), Best earnings (asks for your electricity price if
  it's missing), Most hashrate, Less power, or Coolest and quietest. The dashboard, `--tune` and the docs use the same
  names (`profit`, `speed`, `efficiency`, `cool`).
- **Pause while you game (Windows, on by default).** When a game, or any other program, uses the card heavily, mining
  stops within about 10 seconds and the cards go back to factory settings, so the game has the whole card and never
  runs on a mining tune. A minute after the game stops using the card, mining carries on and the tune goes straight
  back on. GlintMiner tells a game from everyday use by how much of the card's graphics engine each program uses (what
  Task Manager shows), so the desktop, a browser or a video don't count. Home says *Paused while you play* with the
  program's name and a *Don't pause for it* button; Settings → Gaming and schedule has the list of programs that never
  pause mining (animated wallpapers are on it from the start) and the switch. `--no-game-pause` turns it off.
- **A schedule.** Times of day for another tuning mode (factory settings, Most hashrate, Less power, Coolest and
  quietest) or a pause, every day in the PC's local time: a quiet card overnight, no mining in your peak electricity
  hours. A card switches only to a mode it already has a saved tune for, at once and with no new search, so a schedule
  never starts a tune; a tune in progress finishes first. Settings → Gaming and schedule, or
  `--schedule 23:00-07:00=cool,17:00-21:00=pause`.
- The stats API says why mining is paused: `status.state` is `held` and `hold` names the game or the schedule's end.
- **Your wallet's total hashrate.** With more than one rig on the address, the payout card on Home and the wallet's
  rig list on Earnings show *All rigs on HeroMiners: 222 TH/s (2 rigs)* (or Kryptex): this rig at its live rate plus
  the others as the pool sees them, whatever miner they run.

### Docs
- The Windows FAQ and the auto-tune guide say what ending GlintMiner from Task Manager leaves behind (the tune stays on
  the card until GlintMiner runs again or the PC restarts, and a game on a mining tune can crash), and that the pause
  while you game makes closing it before gaming unnecessary. New sections: *Gaming and the schedule*, in every
  language.

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
