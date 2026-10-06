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
- Checks this repository once a day for a newer release (unless updates are off). By default it only tells you;
  it installs one when you choose Update now, or by itself if you turned on automatic updates. It downloads only this
  repository's own release files (following GitHub's redirect to its file host, nowhere else) and installs nothing
  unless `SHA256SUMS.txt` carries a valid signature from the release key built into the program, the package and the
  program inside it match that file, and the version is newer than yours (an older one only when you pick it with
  `glint --update VERSION`). Any failed check leaves everything as it was. The previous program is kept as
  `glint.prev.exe` / `glint.prev` and put back if the new version doesn't run properly. An update never touches your
  settings, wallet, the dev fee or the release key. On HiveOS, mmpOS and Docker it never replaces itself.
- Serves its dashboard on `127.0.0.1:4078`, reachable from this computer only, unless you choose `--api-bind 0.0.0.0`.
  Even then, other devices on your network can only view it: settings and tuning can be changed from this computer
  alone, unless you also start GlintMiner with `--api-allow-remote-control`. Only do that on a network you trust.
  Even then, another device needs the remote-control code (printed at start and shown on this computer's dashboard,
  kept in `glint.json`; delete `api_remote_code` there to make a new one). A request passed on by a proxy on this
  computer (`tailscale serve`, nginx) counts as another device's.
- Writes, next to the program: `glint.json` (your settings; on Linux readable by you only), `glint.log`, its history
  and benchmark files, `glint-update.json` (your update choices), during an update the `glint-update` folder and the
  previous program `glint.prev(.exe)`, and, while auto-tune has changed a card, a small `glint-tuned.json` so the
  next start can put the card back after a crash. Nothing else.

## The release key

Releases are signed with an offline key whose public half is
[glint-release.allowed_signers](glint-release.allowed_signers); the same public key is built into GlintMiner and is
the only key its updates trust. To replace the key, a release signed with the current key adds the new public key
next to it (GlintMiner accepts any key in its built-in list); once installs have moved to that release, a later one
signed with the new key drops the old one. A key is never taken from a download or the network.

## Reporting a vulnerability

If you find a security problem, please don't post details in a public issue. Open an issue titled
"Security contact request" without the details, and we will arrange a private channel.
