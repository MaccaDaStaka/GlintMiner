<div align="center">

# GlintMiner

### 大约一分钟，让你的 NVIDIA 显卡开始挖 Pearl。

**粘贴钱包地址，按回车，开始赚钱。**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

[English](README.md) · [Русский](README.ru.md) · **简体中文**

</div>

---

GlintMiner 是一款在 NVIDIA 显卡上挖 **Pearl (PRL)** 的矿工软件。它的目标是让每一瓦电挖出更多 Pearl，同时也是上手最简单的：
不用改配置文件，不用写 bat 脚本，也不用学命令行。它只问你一个问题——收益发到哪里——然后实时显示你的显卡按法币计算能赚多少。

## 为什么选择 GlintMiner

| | **GlintMiner** | WildRig | SRBMiner | RGMiner | BzMiner |
|---|:-:|:-:|:-:|:-:|:-:|
| 开发者抽水 | **1%** | 0%\* | 2% | 2% | 2% |
| 矿池费（PRL 结算） | **0%**（HeroMiners） | 1–3%\*（Pearlhash） | 自选矿池 | 自选矿池 | 自选矿池 |
| RTX 4090 @ 435 W | **304 TH/s** | 302 | 301 | ~300 | 294 |
| RTX 4090 @ 300 W | **258 TH/s** | 235 | | | |
| 能效 @ 300 W | **0.86 TH/s 每瓦** | 0.78 | | | |
| 上手方式 | **粘贴钱包地址** | 修改 .bat | 修改 .bat | 修改 .bat | 修改配置文件 |

<sub>我们的实测，2026 年 9 月：单张 RTX 4090，默认频率；WildRig 0.51.3、SRBMiner 3.6.9、RGMiner 1.0.9b、BzMiner v100.36。
空白表示未测试。\*WildRig 的 0% 抽水仅适用于 Pearlhash 矿池，而该矿池另收矿池费（矿池官网称 1%，独立统计站显示 3%）。
实际结果因显卡、驱动和设置而异。</sub>

- **每瓦挖得更多。** 满功耗时与最快的挖矿软件持平；为了温度、噪音或电费限制功耗时，领先约 10%。
- **PRL 结算总费用仅 1%。** 我们抽水 1%，HeroMiners 不收矿池费。抽水过程全程可见。
- **想要什么币就付什么币。** 可以直接挖到 Pearl 钱包，也可以用 Bitcoin、Litecoin、Dogecoin、Solana 等约 25 种币结算。
- **收益一目了然。** 以 USD、EUR、CNY 或你自己的货币显示每日收益；填入电价后还能显示扣除电费后的利润。
- **保护你的硬件。** 每张显卡的温度都受到监控：温度偏高时自动降低功耗，接近极限时暂停该卡，冷却后再继续。
- **开了就不用管。** 看门狗、自动切换备用矿池、TLS 加密连接，出问题时给出通俗易懂的提示。

---

## 第一次挖矿？从这里开始

从没挖过矿？只需几分钟，不需要任何技术知识。

### 你需要准备

1. **一张 NVIDIA 显卡**，RTX 30、40 或 50 系列（例如 RTX 3060、4070、5060），并安装较新的 NVIDIA 驱动。
   如果你用这台电脑玩游戏，大概率已经有了。
2. **一个钱包地址**，也就是收益的收款地址。有两种选择：
   - **Pearl 地址**（以 `prl1` 开头）：以 Pearl 自己的币 PRL 结算。
   - **你已经在用的其他币的地址**，例如 Bitcoin、Litecoin、Dogecoin、Solana 等。在交易所或钱包 App 的“收款”/“充值”页面可以找到。
     GlintMiner 挖的是 Pearl，收益以你选择的币结算。

   不知道选哪个？如果你已经持有 Bitcoin 或其他主流币，直接用它的地址，这是最快的开始方式。

### 三步开始

**1. 下载。** 打开 [Releases](../../releases) 页面，下载适合你系统的文件：

| 你的系统 | 下载文件 |
|---|---|
| Windows 10 / 11 | `glint-…-windows.zip` |
| Linux | `glint-…-linux.tar.gz` |
| HiveOS 矿机 | `glint-…-hiveos.tar.gz` |

**2. 解压并运行。** 解压到任意文件夹，例如 `C:\GlintMiner`，然后双击 `glint.exe`。Linux 下运行 `./glint`。

**3. 回答设置问题。** 程序界面为英文，只有三个问题：钱包地址、矿机名称，以及（可选）每千瓦时电价。

```
  Welcome to GlintMiner. One thing is needed: where to send what you mine.

  Paste your wallet address: bc1q...
  -> BTC address, mining on unMineable.
  Name for this rig (shown on the pool) [rig1]:
  Electricity price per kWh, for profit after power (e.g. 0.12; Enter to skip): 0.6
  Currency of that price [USD]: CNY
```

完成，已经开始挖矿了。GlintMiner 会记住你的设置，下次启动直接开始。

### 你会看到什么

每张显卡的实时画面：算力、温度、功耗、已接受的份额，以及**每日收益**。GlintMiner 运行时，在浏览器打开
**http://127.0.0.1:4078** 可以查看图表和历史记录。

### 什么时候能收到钱？

矿池会为你累计余额，超过矿池的最低支付额后打到你的钱包。单张显卡可能需要一天或更久；新挖出的区块需要几个小时确认后才会计入。
面板上可以看到你的余额和每一笔支付记录。

> **提示：** 让它一直运行。矿池按稳定的工作量付费，全天候运行的显卡比每晚开开关关的显卡赚得多得多。

---

## 1% 开发者抽水，公开透明

- 每张显卡大约每一百秒中有一秒为开发者挖矿。矿池看到的算力是平稳的，不会像某些软件那样出现长达一分钟的空档。
- 实时画面和面板会显示抽水比例和目前为止实际抽取的数量。除此之外不收取任何费用。
- 如果抽水服务器无法连接，你照常挖矿。错过的部分之后会慢慢补上，最多约一小时的量。

## 值得信赖

- **每个份额在提交前都会在你的电脑上**用 Pearl 官方校验器验证。如果 Pearl 网络规则变更，GlintMiner 会停下来提示你更新，而不是继续提交会被拒绝的份额。
- **没有意外。** 有新版本时 GlintMiner 会提醒你，但绝不会自行下载或安装任何东西。
- **设置掌握在你手中。** 所有设置都以纯文本保存在程序旁边的 `glint.json` 中。
- **显卡默认设置。** GlintMiner 从不超频。可选的利润模式（profit mode）只会尝试更低的功耗上限，并选出收益最高的一档。

## 矿机用户与进阶用户

设置向导里的所有选项也可以通过命令行指定：

```
glint --wallet prl1... --worker rig1
glint --wallet BTC:bc1q... --kwh-price 0.6 --currency CNY
glint --wallet prl1... --devices 0,1 --api-bind 0.0.0.0 --plain
```

| 参数 | 作用 |
|---|---|
| `--worker NAME` | 在矿池中显示的矿机名称 |
| `--pool URL` | 使用自定义矿池，而不是自动选择 |
| `--devices 0,1` | 只使用指定的显卡 |
| `--kwh-price`, `--currency` | 显示扣除电费后的利润 |
| `--profit-mode` | 自动寻找收益最高的功耗上限（需以管理员身份运行） |
| `--api-bind 0.0.0.0` | 允许局域网内其他设备查看面板 |
| `--telegram-token`, `--telegram-chat` | 通过 Telegram 接收提醒 |
| `--plain` | 纯文本日志，适用于系统服务和矿机系统 |
| `--save` | 将这些参数保存到 `glint.json` |

诊断工具：`--self-test`、`--gpu-info`、`--bench 60`、`--benchmarks`。完整列表：`glint --help`。

- **HiveOS：** 使用 Releases 中 `glint-…-hiveos.tar.gz` 的链接添加自定义矿工。钱包地址填在 *Wallet and worker template*，
  其他参数填在 *Extra config arguments*。参见 [`hiveos/`](hiveos)。
- **MMPOS：** 参见 [`mmpos/`](mmpos)。
- **Docker：** 参见 [`docker/`](docker)。需要 NVIDIA Container Toolkit。
- **Linux 服务：** 现成的 `systemd` 单元文件见 [`glint.service`](glint.service)。
- **统计 API**，可接入你自己的监控：`GET http://127.0.0.1:4078/api/stats`（JSON）。

## 校验下载文件

每个版本的 `SHA256SUMS.txt` 列出了所有文件的 SHA-256 校验值。校验方法：

- **Windows：** `certutil -hashfile glint.exe SHA256`
- **Linux：** `sha256sum glint`

杀毒软件经常把加密货币挖矿软件整类标记，即使是正规软件也不例外。如果遇到这种情况，请将校验值与 Releases 页面上的对比。
请只从本仓库下载 GlintMiner。

## 系统要求

- NVIDIA RTX 30 系列或更新（计算能力 8.0+），并安装最新驱动
- Windows 10/11 64 位，或 Linux x86-64（glibc 2.17+）
- 每张显卡约需 1.5 GB 系统内存
- 无需安装 CUDA Toolkit 或其他软件

## 常见问题

**对显卡安全吗？**
GlintMiner 使用显卡的默认设置，从不超频。它持续监控温度：温度偏高时降低功耗，接近极限时暂停该卡，冷却后再继续。

**挖矿时还能用电脑吗？**
可以，但游戏和视频剪辑会变慢。需要显卡全部性能时，关闭 GlintMiner 即可（Ctrl+C 或直接关闭窗口）。

**我能赚多少？**
这取决于你的显卡、Pearl 价格和全网难度，这些都在不断变化。GlintMiner 从启动那一刻起就实时显示你的真实每日收益。

**我有多台矿机用同一个钱包。**
用 `--worker` 给每台矿机起不同的名字，矿池的统计页面就会分别列出每台矿机。

**遇到问题了。**
运行 `glint --self-test`，然后提交 [issue](../../issues)，附上输出内容、显卡型号和驱动版本。

## 支持

发现 bug 或有建议？请提交 [issue](../../issues)（可以用中文）。请附上显卡型号、驱动版本以及 `glint.log` 中的相关内容。

## 许可

GlintMiner 可免费用于个人和商业挖矿。程序为闭源软件。详见 [LICENSE.txt](LICENSE.txt)，以及列出所用开源组件的 `THIRD_PARTY_NOTICES.txt`。
