# HiveOS 上的 GlintMiner：常见问题

[← 返回 FAQ](faq.zh-CN.md) · [English](faq-hiveos.md) · [Русский](faq-hiveos.ru.md) · **简体中文**

把 GlintMiner 作为 HiveOS 自定义矿工运行时常见的问题，按 GlintMiner 及其 HiveOS 安装包目前的实际工作方式解答。分步设置见 [HiveOS 指南](../hiveos/README.md)。

- [设置](#设置)
- [飞行表决定了什么](#飞行表决定了什么)
- [HiveOS 中的统计数据](#hiveos-中的统计数据)
- [自动调校与 HiveOS 超频](#自动调校与-hiveos-超频)
- [温度与功耗](#温度与功耗)
- [GlintMiner 自己的面板](#glintminer-自己的面板)
- [日志](#日志)
- [更新与移除](#更新与移除)
- [多张显卡](#多张显卡)
- [提示信息及其含义](#提示信息及其含义)

---

## 设置

**用哪个文件？** [Releases](https://github.com/MaccaDaStaka/GlintMiner/releases) 页面中的 `glint-….tar.gz`：把它的链接填入自定义矿工的 **Installation URL**。其中包含 `glint` 程序和四个 HiveOS 文件：`h-manifest.conf`、`h-config.sh`（生成命令行）、`h-run.sh`（启动矿工）和 `h-stats.sh`（向 HiveOS 报告统计数据）。

**飞行表（flight sheet）里填什么？** 矿工名称 `glint`，哈希算法 `pearl`，钱包和矿工模板 `%WAL%`，以及可选的矿池 URL 和额外参数。分步说明见 [HiveOS 指南](../hiveos/README.md)。

**可以用哪种钱包？** Pearl 地址（`prl1…`），在 HeroMiners 上以 PRL 收款；Kryptex 账户（`krx…` 或注册邮箱），通过 Kryptex 以 BTC 收款；或 `COIN:address`（例如 `BTC:bc1q…`），通过 unMineable 以该币种收款。如果想通过 Kryptex 而不是 HeroMiners 以 PRL 收款，把 `stratum+ssl://prl.kryptex.network:8048` 填为矿池 URL。[该选哪个？](getting-started.zh-CN.md#选择收款方式)

**矿工无法启动，提示 “CUSTOM_TEMPLATE (wallet) is empty”。** 飞行表中的钱包和矿工模板是空的。把它设为 `%WAL%`，并确认飞行表所用的钱包里填了地址。

**什么都没发生，`miner` 显示 "There is no screen to be attached matching miner"；或者 HiveOS 提示自定义矿工名称应为 "glint-1.2.6"。** HiveOS 从软件包的文件名中取矿工名称，即版本号之前的部分：`glint-1.2.7.tar.gz` 得到 `glint`，也就是软件包里的文件夹名。1.2.6 及更早的软件包名为 `glint-…-hiveos.tar.gz`，HiveOS 会把它读成名为 `glint-1.2.6` 的矿工，因此无法作为 HiveOS 自定义矿工安装。请使用名为 `glint-<版本>.tar.gz` 的 HiveOS 软件包，并把 **Miner name** 设为 `glint`。另外请确认模板只写 `%WAL%`（GlintMiner 会自己加上矿机名；`%WAL%.%WORKER_NAME%` 会让地址无效），如果填写了 Pool URL，要以 `stratum+ssl://` 开头。`miner log` 会显示启动失败的原因。

**GlintMiner 在 HiveOS 上会问设置问题吗？** 不会。HiveOS 通过命令行把钱包和矿机名传给它，所以它会直接开始挖矿。

## 飞行表决定了什么

**HiveOS 用什么命令行启动 GlintMiner？** `h-config.sh` 根据飞行表生成命令行：

```
--wallet <your wallet> --worker <rig name> --plain --no-log-file --config /hive/miners/custom/glint/glint.json
```

设置了矿池 URL 时再加上 `--pool <Pool URL>`，再加上你的 **Extra config arguments**。

**我的矿机在矿池上叫什么名字？** 使用 HiveOS 中的矿机名作为矿工名。矿池接受字母、数字、`-` 和 `_`，其他字符（空格、`#`、`.`）都会被去掉：名为 `my rig#1` 的矿机会以 `myrig1` 挖矿。

**我在 GlintMiner 的面板上改了钱包（或矿工名、控制台设置），重启后又变回去了。** 每次启动时，命令行参数都优先于 GlintMiner 的设置文件。在 HiveOS 上，飞行表总是会设置钱包、矿工名、简洁控制台和不写日志文件，填了矿池时还会设置矿池。请在飞行表中修改这些。不在命令行中的设置（电价、温度上限、在面板上设置的调校模式、Telegram 提醒）会保留。

**GlintMiner 的设置保存在矿机上的哪里？** 在 `/hive/miners/custom/glint/glint.json` 中。已保存的调校结果、面板图表所用的历史记录和基准测试结果也保存在同一个文件夹中。

**如何添加其他参数？** 把任何 GlintMiner 参数填入 **Extra config arguments**，例如 `--kwh-price 0.12 --currency EUR`。完整列表见[全部参数](advanced.zh-CN.md#全部参数)。

## HiveOS 中的统计数据

**要让 HiveOS 显示算力和温度，需要做什么设置吗？** 不需要。`h-stats.sh` 从矿机上的 `http://127.0.0.1:4078/api/stats` 读取 GlintMiner 的统计数据，并把算力、温度、风扇转速、已接受、拒绝和过期的份额、运行时间和版本交给 HiveOS。

**可以更改 GlintMiner 的端口吗？** 可以，但只能在 **Extra config arguments** 中用 `--api-port` 更改：`h-stats.sh` 从那里读取端口。在 GlintMiner 面板上更改的端口不会被跟随，HiveOS 将显示不出统计数据。

**HiveOS 显示算力为 0，但矿工在运行。** 刚启动时，第一批数据需要一两分钟。如果一直为 0，打开矿工日志，查找 *The dashboard and stats API couldn't start*（面板和统计 API 无法启动）：说明另一个程序已经占用了这个端口，统计数据无法读取。关闭那个程序，或用 `--api-port` 给 GlintMiner 换一个端口。

**为什么矿池显示的比 HiveOS 少？** 矿池报告的是 30 分钟平均值，并且滞后 10–30 分钟。GlintMiner 的数字是在你的显卡上测得的。见[常见问题](faq.zh-CN.md#常见问题)。

## 自动调校与 HiveOS 超频

**应该同时使用 HiveOS 超频和 GlintMiner 的自动调校吗？** 不应该，每张显卡选择其一。开启自动调校时，如果显卡有自己的超频（例如 HiveOS 为矿机设置的超频），GlintMiner 会在调校之前把它恢复为出厂设置，之后每次启动并重新应用已保存的调校结果时也会这样做。所以 GlintMiner 运行期间，显卡使用的是 GlintMiner 的调校结果，而不是你的 HiveOS 超频。日志会说明这一点：*Your card had its own overclock; tuning starts from factory settings and puts yours back when GlintMiner closes.*（你的显卡有自己的超频设置；调校从出厂设置开始，GlintMiner 关闭时会恢复你的设置。）

**GlintMiner 停止后，我的 HiveOS 超频会怎样？** GlintMiner 关闭时（崩溃后则在下次启动时）会恢复显卡原来的超频和功耗上限。如果你的超频把显卡锁定在某个固定频率，这一部分会为调校而解除，GlintMiner 不会恢复它。

**如果 HiveOS 在调校期间应用超频，GlintMiner 会察觉吗？** 不会。GlintMiner 只在 Windows 上检查其他调校程序，所以调校期间应用的超频不会被察觉，并且会破坏结果。有显卡在调校时，不要更改矿机的超频。

**如果自动调校是关闭的呢？** 那么 GlintMiner 从不改动频率，你的 HiveOS 超频和以前一样工作。GlintMiner 唯一可能改动的是功耗上限：显卡过热时调低，GlintMiner 停止时恢复。

**如何为 HiveOS 矿机开启自动调校？** 在 **Extra config arguments** 中加上 `--tune speed --confirm-tuning`（也可用 `efficiency`、`cool`，或 `profit` 加上 `--kwh-price`）。`--confirm-tuning` 表示你接受风险；请先阅读[坦白说明风险](auto-tune.zh-CN.md#坦白说明风险)。因为它写在飞行表中，这个模式在每次启动时都会生效。如果你允许从其他电脑更改，也可以在其他电脑上通过 GlintMiner 的面板开启它（见下面的[面板](#glintminer-自己的面板)）。

**能调校一些显卡、另一些保留 HiveOS 超频吗？** 可以。模式为 **关闭** 的显卡会完全保持 HiveOS 设置的样子。例如 `--tune speed --confirm-tuning --tune-card 01:00.0=off` 会调校除 PCI 总线 `01:00.0` 上那张以外的所有显卡。用总线地址指定显卡可以避免混淆，因为 GlintMiner 的显卡编号可能与 HiveOS 的不同（见[多张显卡](#多张显卡)）。

**如何只调校一张或几张显卡？** 在一个 `--tune-card` 后面用总线地址列出它们，用逗号分隔、不要空格，例如 `--tune-card 0b:00.0=cool,11:00.0=cool --confirm-tuning`。未列出的显卡保留 HiveOS 超频。`--tune-card` 只写一次（第二个同名参数或列表中间的空格都不会被读作它的一部分）。总线地址就是 HiveOS 中每张显卡下方的灰色数字（`0b:00.0`、`11:00.0` 等）。应用之前，先在 HiveOS 中把这些显卡的超频恢复为默认：Core、Core lock、Memory 和 Power limit 中对应位置填 `0`（每张显卡一个值，按 HiveOS 的顺序），这样 HiveOS 和 GlintMiner 不会同时设置同一张卡的频率。之后可以用同样的方法调校其余显卡，或用 `--tune cool --confirm-tuning` 调校整台矿机：已在该模式下调校过的显卡会保留结果，不会重新调校。

**GlintMiner 有调校所需的权限吗？** 它会自己检查。如果无法更改显卡的设置，显卡会以出厂设置挖矿，日志会显示 *Tuning needs administrator rights: … (on Linux, with sudo). Until then this card mines at stock.*（调校需要管理员权限：…（Linux 上使用 sudo）。在此之前这张显卡以出厂设置挖矿。），面板会显示“调优还无法开始”。

**调校在 HiveOS 中是什么样子？** 显卡全程都在挖矿，调校期间会稍慢一些；在快的显卡上，调校大约需要 1 到 1.5 小时。在 GlintMiner 的面板上查看进度和结果。详见[调校期间](auto-tune.zh-CN.md#调校期间)。

## 温度与功耗

**GlintMiner 会和 HiveOS 争夺风扇控制吗？** 不会。GlintMiner 从不改动风扇转速，所以风扇仍由 HiveOS 控制。

**GlintMiner 如何处理过热的显卡？** 超过显卡的温度上限时，它会调低功耗上限；接近显卡的关机温度时，它会暂停这张显卡直到冷却，其他显卡照常挖矿。停止时，它会恢复所有改动过的功耗上限。在面板上设置上限（**设置 → 温度和功耗**），或保持自动，从显卡读取。详见[温度上限](auto-tune.zh-CN.md#温度上限)。

## GlintMiner 自己的面板

**能看到 HiveOS 矿机的 GlintMiner 面板吗？** 能，从你网络中的另一台电脑查看：在 **Extra config arguments** 中加上 `--api-bind 0.0.0.0`，然后打开 `http://<rig-ip>:4078`。它会显示 HiveOS 不显示的收益、支付和调校结果。

**为什么我在上面什么都改不了？** 从矿机本身以外的任何设备打开时，面板都仅可查看。要允许从你的电脑更改，再加上 `--api-allow-remote-control`。只在你信任的网络中这样做：之后任何能访问这个页面的人都可以更改设置。

**页面只显示一个单词 “forbidden”。** 请用矿机的 IP 地址、不带点号的名称、`.local` 名称或 Tailscale 的 `.ts.net` 名称打开。其他域名下的名称（例如 `rig.lan`）会被拒绝，以保护你免受恶意网页的攻击。

**我不在家时能用手机查看吗？** 能，在矿机和手机上都使用 Tailscale 即可。见[手机查看](phone-access.zh-CN.md#随时随地使用-tailscale)。

## 日志

**GlintMiner 在 HiveOS 上的日志在哪里？** 在 `/var/log/miner/glint/glint.log` 中。GlintMiner 打印的所有内容都会写到那里。每次矿工启动时它都会重新开始。矿工文件夹中没有 `glint.log`（飞行表传入了 `--no-log-file`）。

**错误的技术细节在哪里？** 在 HiveOS 上，它在同一行中，放在那句简短说明后面的方括号里，例如 *No answer from … in time*（…未及时响应）背后的操作系统错误。

**为什么日志中的时间不是我的本地时间？** 它们是 UTC 时间。

## 更新与移除

**如何在 HiveOS 上更新 GlintMiner？** 把自定义矿工的 **Installation URL** 指向新版本的 `glint-….tar.gz`，然后应用飞行表。我们无法保证 HiveOS 在安装新版本时会保留矿工文件夹中的文件，所以请把重要的内容放在飞行表中：**Extra config arguments** 中的参数每次启动时都会应用，无论 `glint.json` 发生了什么。如果已保存的调校结果丢失了，自动调校会重新调校。

**如何停止使用它？** 应用一个使用其他矿工的飞行表。GlintMiner 正常关闭时，会恢复它对显卡所做的一切更改。如果它是被强行结束的，重启矿机即可清除 GlintMiner 所做的更改。

## 多张显卡

**它会使用矿机中的每张显卡吗？** 会，所有受支持的 NVIDIA 显卡（RTX 30 系列或更新）都会使用。要排除一些显卡，在 **Extra config arguments** 中加上 `--devices 0,2`。每张显卡请预留约 1.5 GB 系统内存。

**GlintMiner 的 GPU 编号和 HiveOS 的对不上。** GlintMiner 按 CUDA 的顺序给显卡编号，在装有不同显卡的矿机上，这个顺序可能与 HiveOS 显示的不同。要确认哪张是哪张，在矿机上运行 `/hive/miners/custom/glint/glint --gpu-info`：它会列出每张显卡的编号、名称和 PCI 总线地址。`--tune-card` 也接受总线地址。

## 提示信息及其含义

| 你在日志中看到的提示 | 含义 | 该怎么做 |
|---|---|---|
| *No NVIDIA GPU was found. GlintMiner needs an RTX 30-series or newer card.* | 没有 GlintMiner 能用的显卡 | 检查矿机的显卡和驱动 |
| *Your NVIDIA driver is too old for this GPU. Update to driver 550 or newer (580+ for RTX 50) and start again.* | 矿机的驱动太旧 | 更新矿机上的 NVIDIA 驱动 |
| *…is not supported: Pearl mining needs an RTX 30-series or newer* | 这张显卡太旧 | 跳过它；其他显卡照常挖矿 |
| *The dashboard and stats API couldn't start: port 4078 is already in use…* | 有其他程序占用了这个端口 | 停止那个程序，或使用 `--api-port` |
| *Can't look up … — check this PC's internet or DNS settings.* | 矿机无法解析矿池的域名 | 检查矿机的网络和 DNS |
| *Your card had its own overclock; tuning starts from factory settings…* | 自动调校已开启，而显卡有超频设置 | 正常现象；见[上文](#自动调校与-hiveos-超频) |
| *The pool is not accepting our work (…). Pearl's rules may have changed…* | GlintMiner 停了下来，而不是继续发送会被拒绝的工作 | 更新 GlintMiner |

更多内容见[提示信息的含义](auto-tune.zh-CN.md#提示信息的含义)和[故障排除表](faq.zh-CN.md#故障排除)。
