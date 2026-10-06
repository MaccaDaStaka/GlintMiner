# GlintMiner in Docker: FAQ

[← Back to the FAQ](faq.md) · **English** · [Русский](faq-docker.ru.md) · [简体中文](faq-docker.zh-CN.md)

Questions that come up when you run GlintMiner in a Docker container, answered for how GlintMiner and its
`Dockerfile` work today. The short setup is in the [Docker guide](../docker/README.md).

- [Setting it up](#setting-it-up)
- [Options and settings](#options-and-settings)
- [Running, stopping and restarting](#running-stopping-and-restarting)
- [The dashboard](#the-dashboard)
- [Auto-tune and power limits](#auto-tune-and-power-limits)
- [Logs and updates](#logs-and-updates)

---

## Setting it up

**What does the host need?**
An NVIDIA driver (550 or newer, 580 or newer for RTX 50 cards) and the
[NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html),
so that `docker run --gpus all` can hand the cards to the container.

**Where do I get the `Dockerfile`?**
It is in the `docker/` folder of the Linux release, `glint-…-linux.tar.gz`. Put the `glint` program from the same
release next to it, then build and run:

```
docker build -t glint .
docker run -d --restart unless-stopped --gpus all -p 127.0.0.1:4078:4078 glint --wallet prl1... --worker rig1
```

**What's in the image?**
Ubuntu 22.04 with its `ca-certificates` package, and the `glint` program. The image asks the NVIDIA runtime for the driver's compute and management libraries, which GlintMiner needs for mining
and for reading temperatures and power.

**Does it run the setup questions?**
No, give your wallet on the command line with `--wallet`. A container started with `-d` has no terminal, and
without a wallet GlintMiner stops with *no wallet configured: run glint in a terminal for the setup, or pass --wallet
ADDRESS*.

## Options and settings

**Which options are fixed in the image?**
The image always starts GlintMiner with:

```
--plain --no-log-file --config /glint/glint.json --api-bind 0.0.0.0
```

Repeating one of these after the image name doesn't change it: GlintMiner uses the first one it finds, and the
image's come first.

**Which options can I add?**
Everything else, after the image name: `--wallet`, `--worker`, `--pool`, `--devices`, `--kwh-price`, `--currency`,
`--tune` and the other tuning options, `--telegram-token` and `--telegram-chat`, `--share-diff`. The full list is in
[All options](advanced.md#all-options).
An affiliate code goes there too: `--affiliate CODE` after the image name ([what it is](faq.md#questions)).

**Where are my settings kept, and do they survive?**
In `/glint/glint.json` inside the container, with the saved tunes and the history behind the dashboard's charts next
to it. They survive the container stopping and starting again. They are lost when the container is removed, for
example to update to a new image. So put everything you want to keep on the `docker run` command line; changes made
on the dashboard last only as long as that container.

## Running, stopping and restarting

**Why `--restart unless-stopped`?**
When a card stops responding (it can happen while auto-tune tests a card's limit), GlintMiner restarts itself: it
starts a fresh copy and the old one exits. In a container the old one is the container's main process, so its exit
ends the container, and Docker's restart policy is what brings it back.

**How do I stop it cleanly?**
`docker stop <container>`. GlintMiner gets the stop signal and puts back everything it changed on the cards before it
exits.

**What if the container is killed?**
If the same container is started again, GlintMiner puts back what a tune had changed before it mines. If the
container is removed instead, that record goes with it, and a restart of the host clears what GlintMiner changed.

**How do I choose which cards it uses?**
`--gpus all` gives the container every card; GlintMiner then mines on all of them. Add `--devices 0,2` after the
image name to mine on some only.

## The dashboard

**Where is the dashboard?**
At **http://127.0.0.1:4078** on the host. It won't open in a browser by itself from a container.

**Why is the dashboard view-only?**
Inside the container every request arrives from Docker's network, not from the machine itself, so GlintMiner can't
tell the host's browser from another device. From 1.2.8 the image no longer allows changes by default. To change
settings and tuning from the dashboard, add `--api-allow-remote-control` after the image name: the page then asks once
for the remote-control code, which `docker logs <container>` shows at each start (the code is kept in the container's
`glint.json`, so a new container makes a new one).

**Why must I keep `127.0.0.1:` in `-p`?**
With `-p 127.0.0.1:4078:4078` only the host can reach the page. Publishing the port to your network shows your
wallet, cards and earnings to every device on it (`-p 4078:4078` also gets past ufw's rules).

**Can I use another port on the host?**
Yes, change the host side of `-p`, for example `-p 127.0.0.1:5000:4078`, and open `http://127.0.0.1:5000`.

**The page shows only the word "forbidden".**
Open it as `http://127.0.0.1:4078` (or `http://localhost:4078`). GlintMiner refuses names in other domains, to
protect you from malicious web pages.

## Auto-tune and power limits

**Can GlintMiner tune or change power limits in a container?**
It runs as root inside the container, so it tries. Whether the NVIDIA driver lets a container change power limits
and clocks depends on how your host is set up. If it refuses, GlintMiner says so (*Tuning needs administrator rights:
…*, or *the power limit cannot be changed*) and the card mines at stock. Mining itself is not affected.

**How do I turn auto-tune on?**
Add `--tune speed --confirm-tuning` (or `efficiency`, `cool`, or `profit` with `--kwh-price`) after the image name. Read
[Auto-tune](auto-tune.md) first. Because saved tunes are lost with the container, a new container tunes again from
stock.

## Logs and updates

**Where is the log?**
`docker logs <container>`. The image passes `--no-log-file`, so there is no `glint.log`; the technical detail of an
error is on the same line, in square brackets after the plain sentence. Times are in UTC.

**How do I update?**
Put the new release's `glint` next to the `Dockerfile`, build the image again, then remove the old container and
start a new one with the same `docker run` command. Settings that were only on the dashboard don't carry over (see
[above](#options-and-settings)). When a new version is out, GlintMiner says so in its log and on the dashboard, with
the version to rebuild with; it never replaces itself in a container.
