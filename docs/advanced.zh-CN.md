# 矿机用户与进阶用户

[← 返回 README](../README.zh-CN.md) · [English](advanced.md) · [Русский](advanced.ru.md) · **简体中文**

设置向导问的所有内容也都可以通过命令行指定，这里的所有参数都可以保存下来，让 GlintMiner 每次启动都使用它们。

- [命令行](#命令行)
- [全部参数](#全部参数)
- [诊断](#诊断)
- [多显卡与多台矿机](#多显卡与多台矿机)
- [矿池与结算](#矿池与结算)
- [HiveOS、MMPOS、Docker 与 Linux 服务](#hiveosmmposdocker-与-linux-服务)
- [统计 API](#统计-api)
- [GlintMiner 保存的文件](#glintminer-保存的文件)

---

## 命令行

```
glint --wallet prl1... --worker rig1
glint --wallet prl1... --pool stratum+ssl://prl.kryptex.network:8048
glint --wallet krx... --worker rig1
glint --wallet BTC:bc1q... --kwh-price 0.12 --currency EUR
glint --wallet prl1... --devices 0,1 --api-bind 0.0.0.0 --plain
glint --wallet prl1... --tune speed --confirm-tuning --save
```

命令行中给出的参数只用于本次运行。加上 `--save` 可以把它们写入 `glint.json`，这样之后直接运行 `glint`（或双击）就会使用这些参数。

**钱包决定线路：**

| `--wallet` | 在哪里挖 | 收到的币 |
|---|---|---|
| `prl1…`（Pearl 地址） | HeroMiners，最近的服务器（矿池费 0%） | PRL |
| `prl1…` 加上 `--pool stratum+ssl://prl.kryptex.network:8048` | Kryptex（2%，按份额付费） | PRL |
| `krx…` 或 Kryptex 账户的邮箱 | Kryptex | BTC，可提现为 BTC、USDT 或 USDC |
| `COIN:address`，例如 `BTC:bc1q…`、`DOGE:D…`、`SOL:…` | unMineable（1%） | 该币种 |

## 全部参数

| 参数 | 作用 |
|---|---|
| `--wallet ADDRESS` | 收款地址（见上表） |
| `--coin TICKER` | 地址可能属于多种币时指定币种（例如 `0x…` 地址：ETH、USDT 等） |
| `--worker NAME` | 本机在矿池中的名称（字母、数字、`-` 和 `_`） |
| `--pool URL` | 使用这个矿池，而不是自动选择（`stratum+ssl://host:port`） |
| `--devices 0,1` | 只用这些显卡挖矿（编号与 `glint --gpu-info` 一致）；默认：全部 |
| `--kwh-price 0.12`, `--currency EUR` | 你的电价和货币，用于计算扣除电费后的利润 |
| `--profit-mode` | 每天一次寻找收益最高的功耗上限（需要 `--kwh-price` 和管理员权限） |
| `--tune MODE` | 自动调校：`profit`（收益最高）、`speed`（算力最高）、`efficiency`（更省电）、`cool`（凉爽安静，按 `--cool-strength` 的程度；或 `cool:cool`、`cool:cooler`、`cool:coolest`）或 `off`（需要管理员权限；第一次需加 `--confirm-tuning`） |
| `--cool-strength cooler` | 凉爽安静降多少：`cool`（功耗比出厂约低四分之一）、`cooler`（约低三分之一，默认）或 `coolest`（约低 45%）；速度绝不低于出厂的 70%。保存为 `cool_strength`。每个程度都有自己的调校结果。见[凉爽安静](auto-tune.zh-CN.md#选项) |
| `--confirm-tuning` | 确认你接受自动调校的风险（会被保存） |
| `--tune-card 0=speed,1=cool:coolest,2=off` | 为每张显卡设置模式（`default` 跟随 `--tune`；只写 `cool` 表示矿机的程度）；未列出的显卡跟随 `--tune` |
| `--tune-exclude 0,2` | 其他显卡调校时，让这几张显卡保持出厂设置 |
| `--retune [模式]` | 清除所有模式下已保存的调校结果，所有显卡从出厂设置重新调校。带上模式时（`--retune cool:cooler`、`--retune efficiency`；单写 `cool` 表示 `--cool-strength` 的强度），只清除该模式的调校结果，各显卡其他模式的结果保留。与 `--tune-card` 一起使用时，只重新调校其中列出的显卡，各按列出的模式（`--tune-card 07:00.0=efficiency --retune`）；它们其他模式的结果以及其他显卡的调校结果都保留。调校开始后请删掉它：如果一直留着（例如 HiveOS 飞行表），每次启动都会重新调校 |
| `--tune-reset` | 清除已保存的调校结果、各卡模式和排除列表，并关闭调校 |
| `--tune-at-once N` | 同时调校最多 N 张显卡（默认 1）。**每张正在调校的显卡以出厂设置运行 1–2 小时，比你自己的超频更热、更吵**：同时 N 张就是 N 张显卡同时处于出厂设置。请让风扇随温度调节（HiveOS 或 mmpOS 的 AutoFan、风扇曲线），或设置 70% 以上的固定转速，并确认散热和电源能承受；出现崩溃时也更难确定是哪张显卡引起的。等待中的显卡保留自己的设置，或以较低功耗运行。如果多张显卡同时调校时不断有显卡停止响应，剩下的调校会改为一次一张；如果仍然如此，调校会暂停（[说明](auto-tune.zh-CN.md#多显卡矿机)） |
| `--tune-power-budget 瓦数` | 显卡调校期间，让整台矿机保持在这个瓦数以下（0 或 `off`：不限制，默认）。会先降低等待中显卡的功耗；只有在预算允许时显卡才开始调校。也可在设置中修改 |
| `--speed-power-raise max` | “算力最高”可以给每张显卡增加多少功耗，从安全到冒险：`none`（从不高于默认）、`low`（最多多 10%）、`medium`（最多多 25%）或 `max`（最高到显卡自身的上限，默认）；也可以写每张显卡最多增加的瓦数，如 `50`。也可在设置中修改。见[多显卡矿机](auto-tune.zh-CN.md#多显卡矿机) |
| `--speed-power-raise-card 0=none,1=50` | 为单张显卡（按编号或 PCI 总线 ID）设置同样的内容，取代 `--speed-power-raise`；`rig` 表示重新跟随矿机的设置。保存为 `speed_power_raise_cards` |
| `--temp-limit auto` | GlintMiner 通过降低功耗让每张显卡保持在其下的温度（需要管理员权限）：`auto`（默认，取自每张显卡自身的安全最高温度）、60 到 95 之间的数字（°C；绝不高于显卡自身的上限）或 `off`。也可在设置中修改 |
| `--temp-limit-card 0=75,2=70` | 为每张显卡（按编号或 PCI 总线 ID）单独设置温度上限，取代 `--temp-limit`，范围 60 到 95 °C，且绝不高于显卡自身的上限；`auto` 表示重新跟随矿机的上限。适合位置闷热的显卡，比如夹在两张卡之间的那张。自动调校也会遵守它。保存为 `temp_limits` |
| `--tune-ignore-tools` | 即使 MSI Afterburner 或类似工具正在运行也进行调校（它可能在调校途中改动频率） |
| `--schedule 23:00-07:00=cool:coolest,17:00-21:00=pause` | 为某些时段选择另一种模式（`off`、`speed`、`efficiency`、`cool:cool`、`cool:cooler`、`cool:coolest`；只写 `cool` 表示矿机的程度）或暂停（`pause`）；`--schedule off` 关闭。见[计划](auto-tune.zh-CN.md#计划) |
| `--game-pause`、`--no-game-pause` | Windows：游戏使用显卡时暂停挖矿（默认开启） |
| `--share-diff N` | 仅限 Kryptex：向矿池申请的份额难度（0 = 自动） |
| `--auto-update ask` | 更新：`ask`（默认：由你选择立即更新、稍后或跳过）、`auto`（在没有显卡处于调优过程中时安装，然后重启）或 `off`（不检查）。见[更新](../README.zh-CN.md#更新) |
| `--affiliate 推荐码` | 推荐你的人的推荐码（`off` 可删除；保存在 `glint.json` 的 `"affiliate"` 中）。你仍然只付 1%：其中四分之一归推荐人。见[常见问题](faq.zh-CN.md#常见问题) |
| `--github-proxy 网址` | 用于无法访问 GitHub 的网络（中国大陆）：通过它请求 GitHub 链接的代理，例如 `https://v4.gh-proxy.org/`（`off` 可删除；保存在 `glint.json` 的 `"github_proxy"` 中，也可在 设置 → 挖矿 中设置）。用于推荐码列表和更新，它们仍然校验签名。见[常见问题](faq.zh-CN.md#常见问题) |
| `--api-port 4078` | 面板端口 |
| `--api-bind 0.0.0.0` | 向你的网络开放面板（其他设备仅可查看） |
| `--api-allow-remote-control` | 同时允许从这些设备更改设置，需输入远程控制码（启动时打印，并显示在本机控制面板上；仅在你信任的网络中使用） |
| `--open-dashboard`, `--no-open-dashboard` | 启动时是否在浏览器中打开面板 |
| `--telegram-token TOKEN`, `--telegram-chat ID` | 显卡停止或矿池断开时通过 Telegram 提醒 |
| `--plain` | 输出纯文本日志行，而不是实时表格（适用于系统服务、矿机系统、读屏软件） |
| `--no-log-file` | 不写入 `glint.log` |
| `--no-log-share` | 不随签到发送 GlintMiner 日志的脱敏片段（默认开启；在 `glint.json` 中保存为 `"log_share"`，也可在“设置 → 控制台”中设置）。`--no-telemetry` 会同时关闭签到和日志。见[诊断日志](../README.zh-CN.md#诊断日志129-起) |
| `--save` | 将这些参数写入 `glint.json` |
| `--config PATH` | 使用其他设置文件（默认：`glint` 旁边的 `glint.json`） |

完整列表随时可以用 `glint --help` 查看。自动调校的详细说明：[自动调校](auto-tune.zh-CN.md)。

## 诊断

| 命令 | 作用 |
|---|---|
| `glint --self-test` | 端到端检查显卡、驱动和挖矿代码，然后退出。提交 bug 报告时请附上它的输出 |
| `glint --gpu-info` | 列出你的 NVIDIA 显卡及其编号、显存、驱动和计算能力 |
| `glint --bench 60` | 离线挖矿 60 秒并报告算力（结果会被保存）。RTX 50 显卡会先像每次启动时那样比较它的几种挖矿方式（需要几分钟），然后用它保留的那种方式测试；结果行会说明是哪一种 |
| `glint --benchmarks` | 显示已保存的基准测试结果 |
| `glint --pools ADDRESS` | 显示某个地址会使用哪个矿池和线路 |
| `glint --net-test host:port` | 测试到矿池服务器的连接 |
| `glint --update [版本]` | 检查新版本，校验签名后安装并启动（如果这台电脑上已在运行 GlintMiner，则由它自行更新）；`版本` 可指定某个发布版本，也可以是更旧的；`--no-start` 只安装 |
| `glint --become-affiliate` | 在没有屏幕的矿机上申请成为推荐人：显示将发送的全部内容，只在你输入 `yes` 后发送；再次运行可查看状态（等待中、已通过并附推荐码、未通过或已撤销）。申请等待期间，正在运行的矿工也会大约每小时自动查询一次，通过后把推荐码写进日志并显示在面板上 |

## 多显卡与多台矿机

- **一台电脑，多张显卡。** GlintMiner 会自动使用电脑中所有受支持的 NVIDIA 显卡，型号可以混搭（例如 3080 加 4070）。每张显卡在控制台和面板中都有单独一行，显示各自的算力、温度、功耗和份额。所有显卡共用一个矿池连接，所以矿池看到的是每台电脑一个矿工。
- **选择用哪些显卡挖矿：** `--devices 0,2`，或 设置 → 挖矿 → 使用的显卡。
- **一张卡出问题，不影响其他卡。** 某张显卡无法启动时，其他显卡继续挖矿，控制台会说明原因。某张显卡失去响应时，GlintMiner 会自动重启并继续挖矿。
- **每张显卡单独照看：** 温度保护和自动调校都分别对待每一张显卡。见 [多显卡矿机](auto-tune.zh-CN.md#多显卡矿机)。比其他显卡更热的显卡（在一叠显卡中间、靠近电源的位置）可以有自己更低的上限：`--temp-limit-card 1=72`。
- **显存过热：** RTX 3080、3090、3090 Ti 和 4070 Ti 及以上的显卡，显存可能在显卡温度读数正常时就达到自身的极限（这些显卡的驱动不报告显存温度）。当显卡因此自行降频时，GlintMiner 会降低它的功耗，直到不再需要降频，日志中会注明。显卡背面保持良好的气流最有帮助。
- **电源：** 排队等待调校的显卡以较低功耗运行，`--tune-power-budget` 会在调校期间让整台矿机保持在某个瓦数以下。“算力最高”在有收益时可能给显卡提供高于默认的功耗（默认最高到显卡自身的上限），而矿机只有在每张显卡都运行各自的调校设置时才会同时用到全部功耗：如果矿机已接近电源的上限，可以用 `--speed-power-raise none|low|medium`（设置 → 温度和功耗 → “算力最高”可增加的功耗）选少一些、设置预算，或改用“更省电”调校。
- **多台电脑：** 每台电脑运行 GlintMiner 时用不同的矿工名（`--worker rig2`），都挖到同一个钱包。矿池会分别列出每台电脑，面板的收益页面也会显示这个钱包下的每台矿机。
- **内存：** 每张显卡约需 1.5 GB 系统内存（RAM）。

## 矿池与结算

- **自动选择矿池。** 对于 Pearl 地址，GlintMiner 会选择最近的 HeroMiners 服务器，服务器无法访问时自动切换到另一台。连接经过加密（TLS）。
- **自定义矿池：** `--pool stratum+ssl://host:port`，或 设置 → 挖矿 → 自定义矿池。
- **在 HeroMiners 和 Kryptex 上份额更小。** 一个 Pearl 份额约 2 MB。在 HeroMiners 上，GlintMiner 会压缩后发送（每个约 14 KB）；如果某台 HeroMiners 服务器不接受，本次运行中会改为向该服务器发送未压缩的份额。在 Kryptex 上，只要 Kryptex 在登录时同意，份额就会压缩发送（约 11 KB）。流量更少，网络慢时过期份额也更少。
- **Kryptex 上的份额难度。** 大型矿机（超过 500 TH/s）会自动向 Kryptex 申请更高的份额难度，约每 30 秒一个份额，避免向矿池发送过多份额。也可以用 `--share-diff N` 自行设置。Kryptex 的默认值是 2097152；公式为 *算力（H/s）× 每个份额的秒数 ÷ 4294967296*。你的收益不会因此改变：每个份额只是算得更多。

## HiveOS、MMPOS、Docker 与 Linux 服务

- **HiveOS：** 使用 Releases 中 `glint-….tar.gz` 的链接添加自定义矿工。包括统计数据和从其他电脑打开面板在内的分步说明：[HiveOS](../hiveos/README.md)。
- **MMPOS：** [MMPOS](../mmpos/README.md)。
- **Docker：** [Docker](../docker/README.md)。宿主机上需要安装 NVIDIA Container Toolkit。
- **Linux 服务（systemd）：** 把 [`glint.service`](../glint.service) 复制到 `/etc/systemd/system/`，在其中填入你的钱包，然后运行 `systemctl enable --now glint`。之后 GlintMiner 会开机启动，意外停止时也会自动重启。系统服务请使用 `--plain`，这样在 `journalctl -u glint` 中查看的日志更清晰。
- **Linux 上的自动调校**需要 root 权限，因为改动频率需要。

## 统计 API

GlintMiner 在面板端口上提供 JSON，供你自己的监控和矿机系统使用：

- `GET http://127.0.0.1:4078/api/stats`：总算力和每张显卡的算力（H/s）、温度、风扇、功耗、份额（已接受、拒绝、过期）、运行时间、版本、收益估算以及矿池的钱包数据。因游戏或计划暂停挖矿时，`status.state` 为 `held`，`hold` 说明原因（`{"kind": "game", "program": "…"}` 或 `{"kind": "schedule", "until": "07:00"}`）。当处理器太忙、无法及时准备新工作，显卡仍在挖矿池已替换的任务时，`work.late` 为 true；`work.job_lag_s` 是矿池发来新任务至今的秒数，`work.trees_s` 是上一个任务的准备时间；每张显卡也有自己的 `job_lag_s`。

它只在 `127.0.0.1` 上响应，除非你用 `--api-bind 0.0.0.0` 启动 GlintMiner。算力单位为 H/s，其中 1 H 表示一次 Pearl 乘加运算。

## GlintMiner 保存的文件

都在程序旁边（或在用 `--config` 指定的文件旁边）：

| 文件 | 内容 |
|---|---|
| `glint.json` | 你的设置、已保存的调校结果（每张显卡每种模式一份）、计划以及不会触发暂停的程序。更新时请保留；删除它可以重新进行设置 |
| `glint.log` | 日志：发生了什么、什么时候发生，以及任何错误的技术细节。提交 bug 报告时请附上相关内容 |
| `glint-history.jsonl` | 每分钟一条的算力、功耗和收益记录，用于面板的图表和统计 |
| `glint-benchmarks.json` | `--bench` 的结果 |
| `glint-update.json` | 你对更新的选择（跳过的版本、稍后）以及新版本最初几分钟的记录，用于回退 |
| `glint.prev.exe` / `glint.prev` | 更新时保留的旧程序（新版本运行不正常时会恢复它） |

这些文件都不包含密码。`glint.json` 包含你的收款地址，如果你设置了的话，还包含 Telegram 机器人令牌和聊天 ID。
