# Changelog

All notable changes to GlintMiner are listed here.

## [Unreleased]

### Added
- Web dashboard with Home, Earnings, Rigs and Settings pages, plus hashrate, temperature and power history kept for 90 days.
- Wallet balance and payment history, fetched from your pool.
- Thermal guard: power is eased down on a hot card, and a card near its temperature limit pauses until it cools.
- Saved per-card benchmarks (`--bench`, `--benchmarks`).
- Settings can be changed from the dashboard.

### Fixed
- The live console view now works in older Windows consoles, not only Windows Terminal.
- Saving settings from the dashboard no longer stores one-off command-line options.

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
