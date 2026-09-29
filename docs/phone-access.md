# Watch your miner from your phone

[← Back to the README](../README.md) · **English** · [Русский](phone-access.ru.md) · [简体中文](phone-access.zh-CN.md)

The dashboard runs on your mining PC. You can open it from your phone or laptop too, at home or from anywhere,
without opening your PC to the internet.

- [At home, on the same Wi-Fi](#at-home-on-the-same-wi-fi)
- [From anywhere, with Tailscale](#from-anywhere-with-tailscale)
- [View only, and allowing changes](#view-only-and-allowing-changes)
- [Headless rigs (HiveOS, MMPOS, Linux)](#headless-rigs-hiveos-mmpos-linux)
- [If it doesn't open](#if-it-doesnt-open)
- [Other ways to keep an eye on it](#other-ways-to-keep-an-eye-on-it)

---

## At home, on the same Wi-Fi

1. On the mining PC, open the dashboard and go to **Settings → Dashboard → Who can open it**. Choose **Other
   devices, e.g. your phone at home or via Tailscale — view only**, save, and restart GlintMiner.
2. The page then shows the address to open, like `http://192.168.1.20:4078`. Open that on your phone.
3. If Windows asks about the firewall when GlintMiner starts, allow **Private networks** only. Don't tick **Public
   networks**.

## From anywhere, with Tailscale

[Tailscale](https://tailscale.com) (free for personal use) links your own devices into a private network. Your phone
can then reach your PC from anywhere, over mobile data or someone else's Wi-Fi, and nothing is opened to the rest of
the internet.

1. **Install Tailscale** on the mining PC and on your phone, and sign in to the **same account** on both.
2. **Let other devices open the dashboard:** on the mining PC, **Settings → Dashboard → Who can open it** → **Other
   devices, e.g. your phone at home or via Tailscale — view only**. Save and restart GlintMiner.
3. **Let the dashboard through the firewall, for Tailscale only.**
   - **Windows:** open PowerShell as administrator (right-click Start → *Terminal (Admin)*) and run:
     ```
     New-NetFirewallRule -DisplayName "GlintMiner dashboard (Tailscale)" -Direction Inbound -Protocol TCP -LocalPort 4078 -RemoteAddress 100.64.0.0/10 -Action Allow
     ```
     This only lets in devices on your own Tailscale network (their addresses start with `100.`).
   - **Linux / HiveOS:** Tailscale usually handles this itself. If you use ufw:
     `ufw allow in on tailscale0 to any port 4078`.
4. **Open it on your phone:** `http://100.x.y.z:4078`, where `100.x.y.z` is the PC's Tailscale address (shown in the
   Tailscale app). You can also use `http://your-pc-name:4078`, or the full `your-pc-name.your-tailnet.ts.net` name.
5. **Tip:** add it to your phone's home screen (in the browser's menu: *Add to Home screen*) and it opens like an app.

> **Never forward port 4078 on your router.** That would open your dashboard to the whole internet. Tailscale gives
> you the same access privately.

## View only, and allowing changes

From any device other than the mining PC, the dashboard is **view only**: you see everything, but can't change
settings, start or pause tuning. The page says so at the top. Changes are made on the mining PC.

To allow changes from your other devices too, start GlintMiner with `--api-allow-remote-control`. Only do that on a
network you trust (your own Tailscale network is one).

## Headless rigs (HiveOS, MMPOS, Linux)

A rig without a screen has no browser. Start GlintMiner with `--api-bind 0.0.0.0` (on HiveOS: in *Extra config
arguments*), then open `http://<rig-ip>:4078` from any computer on your network, or the rig's Tailscale address from
anywhere.

## If it doesn't open

- **Is GlintMiner running** on the PC, and did you restart it after changing *Who can open it*?
- **Is the address right?** Use the address shown on the dashboard's Settings page, or the Tailscale address. The
  port is `4078` unless you changed it.
- **Firewall:** on Windows, check the rule above exists (Windows Defender Firewall → Inbound rules) and that
  GlintMiner isn't blocked for Private networks.
- **Tailscale:** is it connected on both devices, signed in to the same account? Try pinging the PC from the Tailscale
  app.
- **Phone internet feels slow with Tailscale on?** That's usually an *exit node* being selected in the Tailscale app
  (all your traffic then goes through another device). You don't need one to reach your PC: set exit node to *None*.

## Other ways to keep an eye on it

- **Telegram alerts:** get a message when a card stops or the pool is lost. Create a bot with @BotFather, then enter
  the bot token and your chat id in **Settings → Telegram alerts** (or `--telegram-token` and `--telegram-chat`).
- **Your pool's website:** search for your wallet address to see your hashrate and balance as the pool sees them
  (these lag 10–30 minutes behind).
