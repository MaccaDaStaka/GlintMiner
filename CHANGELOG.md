# Changelog

All notable changes to GlintMiner are listed here.

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
