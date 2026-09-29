# MMPOS 上的 GlintMiner：常见问题

[← 返回 FAQ](faq.zh-CN.md) · [English](faq-mmpos.md) · [Русский](faq-mmpos.ru.md) · **简体中文**

把 GlintMiner 作为 MMPOS 自定义矿工运行时常见的问题，按 GlintMiner 及其 MMPOS 文件目前的实际工作方式解答。如何添加自定义矿工按 MMPOS 自己的流程进行；GlintMiner 提供的文件在 [MMPOS 指南](../mmpos/README.md)中说明。

- [设置](#设置)
- [启动命令决定了什么](#启动命令决定了什么)
- [MMPOS 中的统计数据](#mmpos-中的统计数据)
- [自动调校与 MMPOS 超频](#自动调校与-mmpos-超频)
- [面板、日志与更新](#面板日志与更新)

---

## 设置

**用哪些文件？** Linux 版本，即 [Releases](https://github.com/MaccaDaStaka/GlintMiner/releases) 页面中的 `glint-…-linux.tar.gz`。其中包含 `glint` 程序和一个 `mmpos/` 文件夹，里面有两个 MMPOS 文件：`mmp-external.conf`（矿工的名称、版本、算法、启动命令和统计地址）和 `mmp-stats.sh`（向 MMPOS 报告统计数据）。

**可以用哪种钱包？** 在你的挖矿配置（mining profile）中填入：Pearl 地址（`prl1…`），在 HeroMiners 上以 PRL 收款；Kryptex 账户（`krx…` 或注册邮箱），通过 Kryptex 以 BTC 收款；或 `COIN:address`（例如 `BTC:bc1q…`），通过 unMineable 以该币种收款。[该选哪个？](getting-started.zh-CN.md#选择收款方式)

**GlintMiner 在 MMPOS 上会问设置问题吗？** 不会。钱包和矿工名通过命令行传入，所以它会直接开始挖矿，并在第一次运行时把它们保存到 `glint` 程序旁边的 `glint.json` 中。

## 启动命令决定了什么

**MMPOS 用什么命令行启动 GlintMiner？** `mmp-external.conf` 中的 `START` 行：

```
./glint --plain --no-log-file --wallet %WALLET% --worker %WORKER% --api-port 4078
```

MMPOS 会用你配置中的钱包和矿工名替换 `%WALLET%` 和 `%WORKER%`。

**它用哪个矿池？我配置中的矿池好像被忽略了。** 启动命令没有传入矿池，所以 GlintMiner 和在其他地方一样，根据你的钱包选择矿池：Pearl 地址用最近的 HeroMiners 服务器，Kryptex 账户用 Kryptex，`COIN:address` 用 unMineable。如果想改为通过 Kryptex 以 PRL 收款，在 `START` 行中加上 `--pool stratum+ssl://prl.kryptex.network:8048`。

**如何添加其他参数，比如电价或自动调校？** 把它们加到 `START` 行中，例如 `--kwh-price 0.12 --currency EUR`。完整列表见[全部参数](advanced.zh-CN.md#全部参数)。每次启动时，命令行参数都优先于 `glint.json`，所以如果你在面板上也改了某项设置，下次启动时它会变回命令行中的值。在 MMPOS 上，这包括钱包、矿工名、端口、简洁控制台和不写日志文件。

**可以更改端口吗？** 请保持为 4078。`START` 行和 `mmp-stats.sh` 都使用 4078，而在面板上更改的端口每次启动时都会被 `--api-port 4078` 替换。

## MMPOS 中的统计数据

**MMPOS 从 GlintMiner 获取哪些数据？** `mmp-stats.sh` 读取矿机上的 `http://127.0.0.1:4078/api/stats`，报告总算力（单位 H/s）、已接受和拒绝的份额，以及每张显卡的算力、温度和功耗。

**MMPOS 不显示统计数据。** 在矿工的输出中查找 *The dashboard and stats API couldn't start*（面板和统计 API 无法启动）：说明另一个程序占用了端口 4078，统计数据无法读取。停止那个程序。刚启动时，第一批数据需要一两分钟。

## 自动调校与 MMPOS 超频

**应该同时使用 MMPOS 超频和 GlintMiner 的自动调校吗？** 不应该，每张显卡选择其一。开启自动调校时，如果显卡有自己的超频，GlintMiner 会在调校之前把它恢复为出厂设置，之后每次启动并重新应用已保存的调校结果时也会这样做。GlintMiner 运行期间，显卡使用的是 GlintMiner 的调校结果，而不是你的 MMPOS 超频。关闭时，它会恢复你的超频和功耗上限（如果你的超频把显卡锁定在某个固定频率，这一部分不会恢复）。有显卡在调校时，不要更改矿机的超频：在 Linux 上，GlintMiner 察觉不到调校期间所做的更改，而这些更改会破坏结果。

**如果自动调校是关闭的呢？** GlintMiner 从不改动频率。它只会在显卡过热时调低功耗上限，并在停止时恢复。

**如何开启自动调校？** 在 `START` 行中加上 `--tune speed --confirm-tuning`（也可用 `efficiency`、`cool`，或 `profit` 加上 `--kwh-price`）。请先阅读[自动调校](auto-tune.zh-CN.md)。想继续使用 MMPOS 超频的显卡可以用 `--tune-card 01:00.0=off` 排除（按 PCI 总线地址，`./glint --gpu-info` 会显示）。

**GlintMiner 在 MMPOS 上有调校所需的权限吗？** 它会自己检查。没有权限时，显卡会以出厂设置挖矿，日志会显示 *Tuning needs administrator rights: … (on Linux, with sudo). Until then this card mines at stock.*（调校需要管理员权限：…（Linux 上使用 sudo）。在此之前这张显卡以出厂设置挖矿。）

## 面板、日志与更新

**能打开 GlintMiner 的面板吗？** 能，从另一台电脑打开：在 `START` 行中加上 `--api-bind 0.0.0.0`，然后打开 `http://<rig-ip>:4078`。从那里打开时仅可查看；`--api-allow-remote-control` 也允许更改，只在你信任的网络中使用。详见[无显示器矿机](phone-access.zh-CN.md#无显示器矿机hiveosmmposlinux)。

**日志在哪里？** 启动命令传入了 `--no-log-file`，所以没有 `glint.log`。所有内容都输出到矿工的控制台，错误的技术细节放在那句简短说明后面的方括号中。时间为 UTC 时间。

**如何更新？** 用新 Linux 版本中的 `glint` 程序替换旧的，方法和安装时一样，并保留它旁边的 `glint.json`：你的设置和已保存的调校结果都会延续。有新版本时 GlintMiner 会在输出中告诉你（*A newer GlintMiner (…) is available at …*）；它绝不会自行更新。

**MMPOS 在温度或风扇方面有什么特别之处吗？** GlintMiner 从不改动风扇转速，所以风扇仍由 MMPOS 控制。它的温度保护和在其他地方一样工作：见[温度上限](auto-tune.zh-CN.md#温度上限)。
