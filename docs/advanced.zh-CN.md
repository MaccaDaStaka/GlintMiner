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
| `--tune MODE` | 自动调校：`profit`（收益最高）、`speed`（算力最高）、`efficiency`（更省电）、`cool`（最凉最静）或 `off`（需要管理员权限；第一次需加 `--confirm-tuning`） |
| `--confirm-tuning` | 确认你接受自动调校的风险（会被保存） |
| `--tune-card 0=speed,1=cool,2=off` | 为每张显卡设置模式（`default` 跟随 `--tune`）；未列出的显卡跟随 `--tune` |
| `--tune-exclude 0,2` | 其他显卡调校时，让这几张显卡保持出厂设置 |
| `--retune` | 清除已保存的调校结果，所有显卡从出厂设置重新调校 |
| `--tune-reset` | 清除已保存的调校结果、各卡模式和排除列表，并关闭调校 |
| `--tune-ignore-tools` | 即使 MSI Afterburner 或类似工具正在运行也进行调校（它可能在调校途中改动频率） |
| `--schedule 23:00-07:00=cool,17:00-21:00=pause` | 为某些时段选择另一种模式（`off`、`speed`、`efficiency`、`cool`）或暂停（`pause`）；`--schedule off` 关闭。见[计划](auto-tune.zh-CN.md#计划) |
| `--game-pause`、`--no-game-pause` | Windows：游戏使用显卡时暂停挖矿（默认开启） |
| `--share-diff N` | 仅限 Kryptex：向矿池申请的份额难度（0 = 自动） |
| `--api-port 4078` | 面板端口 |
| `--api-bind 0.0.0.0` | 向你的网络开放面板（其他设备仅可查看） |
| `--api-allow-remote-control` | 同时允许从这些设备更改设置（仅在你信任的网络中使用） |
| `--open-dashboard`, `--no-open-dashboard` | 启动时是否在浏览器中打开面板 |
| `--telegram-token TOKEN`, `--telegram-chat ID` | 显卡停止或矿池断开时通过 Telegram 提醒 |
| `--plain` | 输出纯文本日志行，而不是实时表格（适用于系统服务、矿机系统、读屏软件） |
| `--no-log-file` | 不写入 `glint.log` |
| `--save` | 将这些参数写入 `glint.json` |
| `--config PATH` | 使用其他设置文件（默认：`glint` 旁边的 `glint.json`） |

完整列表随时可以用 `glint --help` 查看。自动调校的详细说明：[自动调校](auto-tune.zh-CN.md)。

## 诊断

| 命令 | 作用 |
|---|---|
| `glint --self-test` | 端到端检查显卡、驱动和挖矿代码，然后退出。提交 bug 报告时请附上它的输出 |
| `glint --gpu-info` | 列出你的 NVIDIA 显卡及其编号、显存、驱动和计算能力 |
| `glint --bench 60` | 离线挖矿 60 秒并报告算力（结果会被保存） |
| `glint --benchmarks` | 显示已保存的基准测试结果 |
| `glint --pools ADDRESS` | 显示某个地址会使用哪个矿池和线路 |
| `glint --net-test host:port` | 测试到矿池服务器的连接 |

## 多显卡与多台矿机

- **一台电脑，多张显卡。** GlintMiner 会自动使用电脑中所有受支持的 NVIDIA 显卡，型号可以混搭（例如 3080 加 4070）。每张显卡在控制台和面板中都有单独一行，显示各自的算力、温度、功耗和份额。所有显卡共用一个矿池连接，所以矿池看到的是每台电脑一个矿工。
- **选择用哪些显卡挖矿：** `--devices 0,2`，或 设置 → 挖矿 → 使用的显卡。
- **一张卡出问题，不影响其他卡。** 某张显卡无法启动时，其他显卡继续挖矿，控制台会说明原因。某张显卡失去响应时，GlintMiner 会自动重启并继续挖矿。
- **每张显卡单独照看：** 温度保护和自动调校都分别对待每一张显卡。见 [多显卡矿机](auto-tune.zh-CN.md#多显卡矿机)。
- **多台电脑：** 每台电脑运行 GlintMiner 时用不同的矿工名（`--worker rig2`），都挖到同一个钱包。矿池会分别列出每台电脑，面板的收益页面也会显示这个钱包下的每台矿机。
- **内存：** 每张显卡约需 1.5 GB 系统内存（RAM）。

## 矿池与结算

- **自动选择矿池。** 对于 Pearl 地址，GlintMiner 会选择最近的 HeroMiners 服务器，服务器无法访问时自动切换到另一台。连接经过加密（TLS）。
- **自定义矿池：** `--pool stratum+ssl://host:port`，或 设置 → 挖矿 → 自定义矿池。
- **在 HeroMiners 和 Kryptex 上份额更小。** 一个 Pearl 份额约 2 MB。在 HeroMiners 上，GlintMiner 会压缩后发送（每个约 14 KB）；如果某台 HeroMiners 服务器不接受，本次运行中会改为向该服务器发送未压缩的份额。在 Kryptex 上，只要 Kryptex 在登录时同意，份额就会压缩发送（约 11 KB）。流量更少，网络慢时过期份额也更少。
- **Kryptex 上的份额难度。** 大型矿机（超过 500 TH/s）会自动向 Kryptex 申请更高的份额难度，约每 30 秒一个份额，避免向矿池发送过多份额。也可以用 `--share-diff N` 自行设置。Kryptex 的默认值是 2097152；公式为 *算力（H/s）× 每个份额的秒数 ÷ 4294967296*。你的收益不会因此改变：每个份额只是算得更多。

## HiveOS、MMPOS、Docker 与 Linux 服务

- **HiveOS：** 使用 Releases 中 `glint-…-hiveos.tar.gz` 的链接添加自定义矿工。包括统计数据和从其他电脑打开面板在内的分步说明：[HiveOS](../hiveos/README.md)。
- **MMPOS：** [MMPOS](../mmpos/README.md)。
- **Docker：** [Docker](../docker/README.md)。宿主机上需要安装 NVIDIA Container Toolkit。
- **Linux 服务（systemd）：** 把 [`glint.service`](../glint.service) 复制到 `/etc/systemd/system/`，在其中填入你的钱包，然后运行 `systemctl enable --now glint`。之后 GlintMiner 会开机启动，意外停止时也会自动重启。系统服务请使用 `--plain`，这样在 `journalctl -u glint` 中查看的日志更清晰。
- **Linux 上的自动调校**需要 root 权限，因为改动频率需要。

## 统计 API

GlintMiner 在面板端口上提供 JSON，供你自己的监控和矿机系统使用：

- `GET http://127.0.0.1:4078/api/stats`：总算力和每张显卡的算力（H/s）、温度、风扇、功耗、份额（已接受、拒绝、过期）、运行时间、版本、收益估算以及矿池的钱包数据。因游戏或计划暂停挖矿时，`status.state` 为 `held`，`hold` 说明原因（`{"kind": "game", "program": "…"}` 或 `{"kind": "schedule", "until": "07:00"}`）。

它只在 `127.0.0.1` 上响应，除非你用 `--api-bind 0.0.0.0` 启动 GlintMiner。算力单位为 H/s，其中 1 H 表示一次 Pearl 乘加运算。

## GlintMiner 保存的文件

都在程序旁边（或在用 `--config` 指定的文件旁边）：

| 文件 | 内容 |
|---|---|
| `glint.json` | 你的设置、已保存的调校结果（每张显卡每种模式一份）、计划以及不会触发暂停的程序。更新时请保留；删除它可以重新进行设置 |
| `glint.log` | 日志：发生了什么、什么时候发生，以及任何错误的技术细节。提交 bug 报告时请附上相关内容 |
| `glint-history.jsonl` | 每分钟一条的算力、功耗和收益记录，用于面板的图表和统计 |
| `glint-benchmarks.json` | `--bench` 的结果 |

这些文件都不包含密码。`glint.json` 包含你的收款地址，如果你设置了的话，还包含 Telegram 机器人令牌和聊天 ID。
