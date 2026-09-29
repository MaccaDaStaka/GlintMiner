# Linux 上的 GlintMiner：常见问题

[← 返回 FAQ](faq.zh-CN.md) · [English](faq-linux.md) · [Русский](faq-linux.ru.md) · **简体中文**

在 Linux 桌面电脑或服务器上用 GlintMiner 挖矿时常见的问题，按 GlintMiner 目前的实际工作方式解答。矿机系统有各自的页面：[HiveOS](faq-hiveos.zh-CN.md)、[MMPOS](faq-mmpos.zh-CN.md) 和 [Docker](faq-docker.zh-CN.md)。

- [系统要求](#系统要求)
- [安装与首次运行](#安装与首次运行)
- [在后台运行](#在后台运行)
- [root 权限](#root-权限)
- [Linux 上的自动调校](#linux-上的自动调校)
- [温度与功耗](#温度与功耗)
- [桌面电脑或无显示器矿机上的面板](#桌面电脑或无显示器矿机上的面板)
- [日志](#日志)
- [更新与卸载](#更新与卸载)
- [多张显卡](#多张显卡)
- [提示信息及其含义](#提示信息及其含义)

---

## 系统要求

**能在哪些 Linux 上运行？** 64 位 x86 Linux，glibc 2.17 或更新，这几乎涵盖了所有仍在使用的发行版。除了 glibc，它只需要 NVIDIA 驱动：不需要 CUDA Toolkit、OpenSSL 或 Python。

**需要什么 NVIDIA 驱动？** NVIDIA 官方驱动（来自 nvidia.com 或你的发行版提供的 NVIDIA 软件包），版本 550 或更新，RTX 50 显卡需要 580 或更新。GlintMiner 会加载驱动自带的两个库：挖矿用的 `libcuda.so.1`，以及读取温度、功耗和进行调校用的 `libnvidia-ml.so.1`。开源的 nouveau 驱动无法挖矿。

**支持哪些显卡？** NVIDIA RTX 30、40 和 50 系列（计算能力 8.0 或更新）。`glint --gpu-info` 会列出 GlintMiner 看到的显卡。

**需要多少内存？** 每张显卡约需 1.5 GB 系统内存（RAM）。

## 安装与首次运行

**下载哪个文件？** [最新版本](https://github.com/MaccaDaStaka/GlintMiner/releases/latest)页面中的 `glint-…-linux.tar.gz`。解压后是一个 `glint` 文件夹，其中有 `glint` 程序、README 和这些指南、更新日志、许可证文件、一个 systemd 单元（`glint.service`），以及用于 [MMPOS](faq-mmpos.zh-CN.md)（`mmpos/`）和 [Docker](faq-docker.zh-CN.md)（`docker/`）的文件。

**如何启动？**

```
tar xzf glint-*-linux.tar.gz
cd glint
./glint
```

第一次运行时，它会问你想怎样收款以及其他几个问题（[入门指南](getting-started.zh-CN.md)）。设置需要终端。如果在没有终端、也没有钱包的情况下启动，GlintMiner 会停止并提示 *no wallet configured: run glint in a terminal for the setup, or pass --wallet ADDRESS*（未配置钱包：请在终端中运行 glint 进行设置，或传入 --wallet ADDRESS）。在命令行中加上 `--wallet` 时，它会跳过设置，并在第一次运行时把你的参数保存到 `glint.json`。

**设置程序没有在剪贴板中找到我的地址。** 在 Linux 上，GlintMiner 只在桌面会话中读取剪贴板，使用 `wl-paste`（Wayland）或 `xclip`、`xsel`（X11）。通过 SSH 运行，或没有这些工具时，在设置程序询问时直接粘贴地址即可。

**GlintMiner 把文件保存在哪里？** 在 `glint` 程序旁边：`glint.json`（设置和已保存的调校结果）、`glint.log`、`glint-history.jsonl` 和 `glint-benchmarks.json`。`glint.json` 只有保存它的用户能读取，因为其中可能含有 Telegram 机器人令牌。使用 `--config /path/rig.json` 时，这些文件会放在那个文件旁边。

**面板没有在浏览器中打开。** 只有在桌面会话中运行、并且没有使用 `--plain` 时，GlintMiner 才会（用 `xdg-open`）打开面板。在服务器上或通过 SSH 运行时，请自己打开地址；见下面的[面板](#桌面电脑或无显示器矿机上的面板)。

## 在后台运行

**如何把它作为开机启动的服务运行？** 下载包中包含一个 systemd 单元 `glint.service`：

1. 把 `glint` 文件夹中的内容放到 `/opt/glint`。
2. 把 `glint.service` 复制到 `/etc/systemd/system/`，并在它的 `ExecStart` 行中填入你的钱包（以及矿工名）。
3. 运行 `systemctl enable --now glint`。

之后 GlintMiner 会开机启动，无论因为什么原因停止，systemd 都会在 10 秒后再次启动它。这个单元以 root 身份运行它，这样温度保护和自动调校就能更改显卡的设置；并且使用 `--plain`，让它的输出在 journal 中清晰易读。

**我在面板上改了一项设置，但服务重启后用的还是旧的。** 每次启动时，命令行参数都优先于 `glint.json`。单元的 `ExecStart` 行中写的内容（钱包、矿工名、简洁控制台）每次都会被应用，所以请在单元中修改这些，然后运行 `systemctl daemon-reload` 和 `systemctl restart glint`。没有写在命令行中的设置会保留你在面板上的修改。

**如何停止它？** 在终端中按 **Ctrl+C**。作为服务运行时，使用 `systemctl stop glint`。收到 SIGTERM 或 SIGHUP（关闭终端）时，GlintMiner 也会正常停止。无论哪种方式，它都会先把对显卡所做的一切更改恢复原样。

**如果它被 `kill -9` 结束，或者机器断电了会怎样？** 下次启动时会先收尾：在任何显卡开始挖矿之前，被自动调校改动过的显卡会被恢复，日志会显示 *auto-tune: GlintMiner didn't close cleanly last time; 1 card(s) put back to stock*（上次没有正常关闭，已将 1 张显卡恢复为出厂设置）。仅由温度保护调低的功耗上限不在这份记录中，所以可能要到机器重启后才会恢复原值。

**可以改用 `screen` 或 `tmux` 运行吗？** 可以；它的表现和在任何终端中一样。分离会话后它会继续挖矿。

## root 权限

**需要 root 吗？** 挖矿不需要。只有更改显卡的设置时才需要 root：

- 显卡过热时调低它的功耗上限，
- 使用利润模式（`--profit-mode`），
- 使用[自动调校](auto-tune.zh-CN.md)。

*紧急暂停*（在显卡接近关机温度时暂停它）不需要 root 也能工作。调校需要 root 时，设置程序会告诉你：*Tuning needs root (sudo): until then your card simply mines at stock.*（调校需要 root（sudo）：在此之前你的显卡只是以出厂设置挖矿。）

**如何以 root 权限运行？** `sudo ./glint`，或作为上面的 systemd 服务运行（它以 root 身份运行）。在 Linux 上，GlintMiner 无法像在 Windows 上那样提出以 root 权限重启自己。

**用过一次 `sudo` 之后，以普通用户运行时出现 “Permission denied”。** GlintMiner 以 root 身份运行时保存的文件属于 root，而 `glint.json` 只有它的所有者能读取。请每次都用同样的方式运行，或把文件交还给你的用户，例如 `sudo chown $USER glint.json glint.log glint-history.jsonl`。

## Linux 上的自动调校

完整指南见[自动调校](auto-tune.zh-CN.md)。以下是 Linux 特有的部分。

**如何开启？** 在设置时、在面板上（**设置 → 调优**），或用 `sudo ./glint --tune speed --confirm-tuning`（也可用 `efficiency`，或 `profit` 加上 `--kwh-price`）。`--confirm-tuning` 用来确认你接受风险；它会被保存。

**自动调校需要桌面、X 或 nvidia-settings 吗？** 不需要。GlintMiner 通过 NVIDIA 驱动的管理库进行更改，所以在无显示器的机器上也能工作。它需要 root，以及提供这些控制功能的驱动；驱动较旧时，显卡会显示 *Tuning needs a newer NVIDIA driver: update it and start GlintMiner again. Until then this card mines at stock.*（调校需要更新的 NVIDIA 驱动：请更新后重新启动 GlintMiner。在此之前这张显卡以出厂设置挖矿。）

**GlintMiner 在 Linux 上能察觉其他超频工具吗？** 它只在 Windows 上检查正在运行的调校程序。在 Linux 上，显卡上已有的超频（来自 nvidia-settings、脚本或其他工具）会在调校开始时被察觉：GlintMiner 先把显卡恢复为出厂设置，记录 *Your card had its own overclock; tuning starts from factory settings and puts yours back when GlintMiner closes.*（你的显卡有自己的超频设置；调校从出厂设置开始，GlintMiner 关闭时会恢复你的设置。），并在关闭时恢复你的设置。在调校*期间*改动显卡频率的东西不会被察觉，并且会破坏结果，所以调校时不要运行这类脚本或工具。

**能让一些显卡用我自己的超频、另一些用自动调校吗？** 可以。模式为 **关闭** 的显卡会完全保持原样。在面板上按显卡设置，或使用 `--tune-card 0=speed,1=off`（显卡可以用编号或 PCI 总线地址指定，例如 `01:00.0`）。

**显卡在调校时崩溃，GlintMiner 重启了。** 这是调校在寻找显卡的极限。GlintMiner 会记录 *a GPU stopped responding; restarting GlintMiner*（某张显卡停止响应，正在重启 GlintMiner），启动一个新的自身副本并继续。在 systemd 下，单元中的 `Restart=always` 确保无论发生什么它都会回来。

## 温度与功耗

**GlintMiner 如何管理温度？** 它一直监控每张显卡的温度。超过显卡的上限时，它会调低功耗上限（需要 root）。接近显卡的关机温度时，它会暂停这张显卡直到冷却（有没有 root 都可以）。上限默认从显卡读取；你可以在 **设置 → 温度和功耗** 中自行设置。详见[温度上限](auto-tune.zh-CN.md#温度上限)。

**日志说功耗上限 “cannot be changed”（无法更改）。** *GPU 0: 84 C is over the 80 C limit, but the power limit cannot be changed. Run GlintMiner as administrator to let it manage temperature.*（GPU 0：84 °C 超过了 80 °C 的上限，但功耗上限无法更改。以管理员身份运行 GlintMiner，让它来管理温度。）在 Linux 上，这意味着：以 root 身份运行它。

**它会控制我的风扇吗？** 不会。GlintMiner 从不改动风扇转速。如果某张显卡风扇已达 100% 仍然很热，日志会提示 *check airflow and dust*（检查通风和灰尘）。

## 桌面电脑或无显示器矿机上的面板

**面板在哪里？** 在挖矿的机器上打开 **http://127.0.0.1:4078**。默认只在这里响应。

**如何从另一台电脑打开？** 用 `--api-bind 0.0.0.0` 启动 GlintMiner（或 **设置 → 面板 → 谁可以打开** → *其他设备*，然后重启），再打开 `http://<machine-ip>:4078`。从其他设备打开时仅可查看；加上 `--api-allow-remote-control` 也允许从这些设备更改，只在你信任的网络中这样做。如果你运行着防火墙，只允许来自你自己网络的 TCP 4078 端口入站。要随时随地访问，请使用 Tailscale（[手机查看](phone-access.zh-CN.md#随时随地使用-tailscale)）。

**页面只显示一个单词 “forbidden”。** 你是用含有点号的名称打开的，例如 `http://rig.lan:4078`。为了保护你免受恶意网页的攻击，GlintMiner 只响应 IP 地址、不带点号的机器名（`http://rig:4078`）、`.local` 名称，或以 `.ts.net` 结尾的 Tailscale 名称。

**日志显示 “The dashboard and stats API couldn't start”（面板和统计 API 无法启动）。** 这一行的其余部分说明了原因，例如 *port 4078 is already in use (another miner, or a second GlintMiner?); choose another with --api-port*（端口 4078 已被占用：另一个挖矿软件，还是第二个 GlintMiner？请用 --api-port 换一个）。没有面板时挖矿也会继续。

## 日志

**日志在哪里？** 在程序旁边的 `glint.log` 中（如果使用了 `--config` 文件，则在那个文件旁边）。每一行以 Unix 时间戳开头，后面是消息；`date -d @1759132800` 可以把时间戳转换为日期。文件超过 8 MB 后，GlintMiner 会在下次启动时重新开始写一个新文件。作为服务运行时，`journalctl -u glint` 也会显示它的输出。

**为什么控制台中的时间和我的时钟不一样？** 它们是 UTC 时间，不是你的本地时间。

**`glint.log` 里有哪些屏幕上没有的内容？** 技术细节。控制台和面板用一句简短的话说明发生了什么、该怎么做；网址、系统错误代码和错误细节写入 `glint.log`。如果你关闭了日志文件（`--no-log-file`），这些细节会改为打印在控制台上，放在那句话后面的方括号中。

**求助时如何分享我的日志？** 复制问题前后的几行（例如 `tail -n 200 glint.log`），连同 `./glint --self-test` 的输出一起附在你的 [issue](faq.zh-CN.md#获取帮助) 中。如果你不想公开钱包地址，请先把它删掉。

## 更新与卸载

**我怎么知道有新版本？** GlintMiner 在启动时和每天一次检查 GitHub，并在日志和面板上提示 *A newer GlintMiner (…) is available at https://github.com/MaccaDaStaka/GlintMiner/releases*。它绝不会自行下载或安装任何东西。

**如何更新？** 停止 GlintMiner，用新的 `glint-…-linux.tar.gz` 中的 `glint` 程序替换旧的，然后重新启动（作为服务运行时：`systemctl restart glint`）。保留 `glint.json` 和其他文件：你的设置、已保存的调校结果和历史记录都会延续。

**如何卸载？** 停止它，然后删除它的文件夹。如果你把它设置成了服务，先运行 `systemctl disable --now glint`，并删除 `/etc/systemd/system/glint.service`。GlintMiner 不会安装其他任何东西。

## 多张显卡

**它会使用我所有的显卡吗？** 会，所有受支持的 NVIDIA 显卡都会使用，型号可以混搭。用 `--devices 0,2` 或 **设置 → 挖矿 → 使用的显卡** 选择。详见[多显卡与多台矿机](advanced.zh-CN.md#多显卡与多台矿机)。

**为什么 GlintMiner 的 “GPU 1” 和 nvidia-smi 的 GPU 1 不是同一张显卡？** GlintMiner 按 CUDA 的顺序给显卡编号，在装有不同显卡的机器上，这个顺序可能与 nvidia-smi 的不同。`glint --gpu-info` 会显示每张显卡的编号以及它的名称和 PCI 总线地址，方便你对应起来。

## 提示信息及其含义

| 你看到的提示 | 含义 | 该怎么做 |
|---|---|---|
| *No NVIDIA driver was found. Install the current GeForce driver from nvidia.com and start again.* | 无法加载 `libcuda.so.1` | 安装 NVIDIA 官方驱动（不是 nouveau） |
| *No NVIDIA GPU was found. GlintMiner needs an RTX 30-series or newer card.* | 驱动找不到 GlintMiner 能用的显卡 | 检查 `nvidia-smi` 和 `glint --gpu-info` |
| *Your NVIDIA driver is too old for this GPU. Update to driver 550 or newer (580+ for RTX 50) and start again.* | 驱动比你的显卡或 GlintMiner 更旧 | 更新驱动 |
| *…is not supported: Pearl mining needs an RTX 30-series or newer* | 这张显卡太旧 | 跳过这张显卡；其他显卡照常挖矿 |
| *The GPU ran out of memory. Close other GPU programs (games, other miners) and start again.* | 有其他程序在占用显卡的显存 | 关闭它，然后重新启动 |
| *no wallet configured: run glint in a terminal for the setup, or pass --wallet ADDRESS* | 在没有终端、也没有设置的情况下启动 | 在终端中运行一次，或加上 `--wallet` |
| *reading …/glint.json: Permission denied* | 文件属于 root（见上文） | 每次都用同样的方式运行，或用 `chown` 更改文件所有者 |
| *Can't look up … — check this PC's internet or DNS settings.* | 无法解析矿池的域名 | 检查网络和 DNS |
| *Couldn't set up a secure connection to …; check this PC's date and time, and any antivirus or firewall that inspects traffic.* | 加密连接失败 | 校正时钟（NTP）；检查任何拦截流量的软件 |
| *The pool is not accepting our work (…). Pearl's rules may have changed (a network upgrade): this version needs an update.* | GlintMiner 停了下来，而不是继续发送会被拒绝的工作 | [更新](#更新与卸载) |
| *Tuning needs administrator rights: close GlintMiner and start it again with right-click, Run as administrator (on Linux, with sudo).* | 调校已开启，但没有 root 权限 | 以 root 身份运行 |

GlintMiner 会向外连接你的矿池（HeroMiners 使用端口 1200，Kryptex 使用 8048，unMineable 使用 4444 或 3333），并通过 443 端口访问网站，以获取价格、你的矿池数据和检查更新。如果你过滤出站流量，请放行这些连接。更多解答见[提示信息的含义](auto-tune.zh-CN.md#提示信息的含义)和[故障排除表](faq.zh-CN.md#故障排除)。
