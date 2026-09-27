# Security

## Getting GlintMiner safely

- Download GlintMiner **only** from this repository's [Releases](../../releases) page. Copies uploaded elsewhere may
  have been modified.
- Check the SHA-256 of what you downloaded against `SHA256SUMS.txt` in the same release:
  - Windows: `certutil -hashfile glint.exe SHA256`
  - Linux: `sha256sum glint`
- GlintMiner never asks for a private key, seed phrase or password. It only ever needs your **public** receiving
  address. Anyone asking for your seed phrase in GlintMiner's name is not us.

## What GlintMiner does on your machine

- Connects to your mining pool, to public price and pool-statistics pages to show your earnings, and to Telegram
  only if you turn alerts on.
- Checks this repository once a day for a newer release, and tells you if there is one. It never downloads or
  installs anything by itself.
- Serves its dashboard on `127.0.0.1:4078`, reachable from this computer only, unless you choose `--api-bind 0.0.0.0`.
  Even then, other devices on your network can only view it: settings and tuning can be changed from this computer
  alone, unless you also start GlintMiner with `--api-allow-remote-control`. Only do that on a network you trust.
- Writes, next to the program: `glint.json` (your settings; on Linux readable by you only), `glint.log`, its history
  and benchmark files, and, while auto-tune has changed a card, a small `glint-tuned.json` so the next start can put
  the card back after a crash. Nothing else.

## Reporting a vulnerability

If you find a security problem, please don't post details in a public issue. Open an issue titled
"Security contact request" without the details, and we will arrange a private channel.
