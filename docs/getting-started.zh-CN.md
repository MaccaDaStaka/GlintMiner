# 入门指南

[← 返回 README](../README.zh-CN.md) · [English](getting-started.md) · [Русский](getting-started.ru.md) · **简体中文**

从没挖过矿？这份指南带你从零开始，几分钟内就能挖上矿。你不需要任何技术知识，也不需要配置文件或命令行。

- [你需要准备](#你需要准备)
- [选择收款方式](#选择收款方式)
- [下载](#下载)
- [运行](#运行)
- [逐一说明设置问题](#逐一说明设置问题)
- [你会看到什么](#你会看到什么)
- [什么时候能收到钱？](#什么时候能收到钱)
- [更新](#更新)
- [停止与卸载](#停止与卸载)

---

## 你需要准备

1. **一张 RTX 30、40 或 50 系列的 NVIDIA 显卡**，例如 RTX 3060、3080、4070、4090、5060 或 5090。如果你用它玩近几年的游戏，那几乎肯定没问题。较老的显卡（GTX、RTX 20）以及 AMD 或 Intel 显卡不受支持。
2. **较新的 NVIDIA 驱动。** 如果你的驱动已经超过一年，请先从 nvidia.com 或 NVIDIA App 更新。
3. **Windows 10/11（64 位）或 Linux。** 也可以是运行 HiveOS 或 MMPOS 的矿机。
4. **每张显卡约 1.5 GB 可用内存（RAM）。**
5. **一个收款的地方**（见下一节）。

不需要安装其他任何东西：不需要 CUDA Toolkit，不需要 Python，除了平常的 NVIDIA 驱动外也不需要其他驱动。

## 选择收款方式

GlintMiner 挖的是 **Pearl (PRL)**。你可以选择收款方式：

| 方式 | 你提供 | 你收到 | 在 1% 开发者抽水之外的费用 |
|---|---|---|---|
| **HeroMiners 上的 Pearl** | Pearl 地址（`prl1…`） | PRL，打到你的钱包 | 无 |
| **Kryptex 上的 Pearl** | Pearl 地址（`prl1…`） | PRL，打到你的钱包，每个份额都付费 | 2% |
| **通过 Kryptex 收 Bitcoin/USDT/USDC** | Kryptex 账户（`krx…` 或你的邮箱） | BTC，可提现为 BTC、USDT 或 USDC | 2% |
| **通过 unMineable 收其他币** | 该币的地址（Bitcoin、Litecoin、Dogecoin、Solana 以及另外约 25 种） | 该币种，打到你的钱包 | 1% |

**该选哪个？**

- **最划算：在 HeroMiners 上用 Pearl 地址。** 无需兑换，也不收矿池费。可在 Pearl 钱包 App 中免费获取 Pearl 地址：打开 **Receive** 并复制。
- **想要 Pearl，而且收益更平稳：同一个地址改用 Kryptex。** 多付 2%，换来 Kryptex 为你找到的每个份额付费，余额稳定增长，不用看矿池的运气。满 1 PRL 即把 PRL 打到你的钱包。
- **想省心地拿到比特币或稳定币：用 Kryptex 账户。** 在 pool.kryptex.com 免费注册（只需邮箱）。Kryptex 会自动把你的 Pearl 兑换成比特币，你可以从账户提现 BTC、USDT 或 USDC。Kryptex 收取 2%，且不公布兑换汇率，但据我们估算，它很可能比通过 unMineable 兑换付得明显更多。
- **想把其他币直接打到自己的钱包：填写该币的地址。** 在交易所或钱包 App 中，它显示为你的 *收款*或*充值*地址。unMineable 负责兑换，收取 1% 费用，GlintMiner 会显示 unMineable 自己给出的预计收益。

如果一个地址可能属于多种币（例如 `0x…` 地址），请在前面写上币种，例如 `USDT:0x…` 或 `DOGE:D…`。之后可以在 **设置 → 钱包和结算** 中更改收款方式。

## 下载

打开[最新版本](https://github.com/MaccaDaStaka/GlintMiner/releases/latest)页面，下载适合你电脑的文件：

| 你的电脑 | 下载文件 |
|---|---|
| Windows 10 / 11 | `glint-…-windows.zip` |
| Linux | `glint-…-linux.tar.gz` |
| HiveOS 矿机 | `glint-….tar.gz`（见 [HiveOS](../hiveos/README.md)） |
| MMPOS 矿机 | Linux 文件（见 [MMPOS](../mmpos/README.md)） |
| Docker | Linux 文件（见 [Docker](../docker/README.md)） |

请只从本仓库的 Releases 页面下载 GlintMiner。要确认下载的文件是正版，请看 [校验下载文件](faq.zh-CN.md#校验下载文件)。

## 运行

**Windows：** 把文件解压到你选择的文件夹，例如 `C:\GlintMiner`，然后双击 `glint.exe`。

> 首次运行时，Windows 可能会显示 **“Windows 已保护你的电脑”**。对于下载量还不多的新程序，Windows 都会这样提示。点击 **更多信息**，然后点击 **仍要运行** 即可。只需操作一次。
>
> 杀毒软件也可能会报毒。杀毒软件经常把加密货币挖矿软件整类标记，包括正规软件。如果遇到这种情况，请核对文件的校验值（[方法](faq.zh-CN.md#校验下载文件)），然后允许运行。

**Linux：** 解压后在终端中运行 `./glint`。

```
tar xzf glint-*-linux.tar.gz
cd glint
./glint
```

## 逐一说明设置问题

第一次运行时，GlintMiner 会问几个问题。每个问题都用数字回答：输入数字并按 **Enter** （直接按 Enter 选第一项，即方括号中显示的选项）。

```
  Welcome to GlintMiner. How do you want to be paid?
    1) Pearl to your Pearl wallet (HeroMiners, no fee)
    2) Pearl to your Pearl wallet (Kryptex, 2%, steady pay per share)
    3) Bitcoin/USDT/USDC via a Kryptex account (2%)
    4) Another coin to your own wallet (unMineable, 1%)
  Type 1-4 and press Enter [1]: 1

  Found a Pearl address on your clipboard:
    prl1pn0q...4syvu78w
    1) Use it
    2) Paste a different one
  Type 1 or 2 and press Enter [1]: 1
  -> Paid in PRL to your Pearl wallet, mining on HeroMiners (no pool fee).

  Name this rig on the pool:
    1) GAMING-PC (this computer)
    2) rig1
    3) Type one
  Type 1-3 and press Enter [1]: 1

  Electricity price (for profit after power)?
    1) Skip, set it later in the dashboard
    2) Enter it now  (currency from your system: EUR)
  Type 1 or 2 and press Enter [1]: 2
  Price per kWh (e.g. 0.12): 0.25
  Currency of that price:
    1) EUR
    2) USD
    3) GBP
    4) Other (type 3 letters)
  Type 1-4 and press Enter [1]: 1

  Tune your card? (you can change this any time)
  Tuning needs administrator rights: if you turn it on, setup can restart GlintMiner as administrator.
    1) Off: factory settings (default)
    2) Best earnings: GlintMiner picks what makes the most money at your electricity price (recommended)
    3) Most hashrate: as fast as your card safely goes
    4) Less power: same speed, much less power
    5) Coolest and quietest: lowest power, a little slower
  Type 1-5 and press Enter [1]: 1

  Open the dashboard (charts, earnings, settings) in your browser at start?
    1) Yes
    2) No
  Type 1 or 2 and press Enter [1]: 1

  All set. Mining...
```

每个问题的作用：

- **想用什么方式收款？** 见[选择收款方式](#选择收款方式)。
- **你的地址。** 如果你在启动前复制了地址，GlintMiner 会在剪贴板里找到它，不用再粘贴。使用前它会先检查地址。
- **矿机名称。** 这台电脑在矿池网站上显示的名称。如果你有多台电脑，每台请用不同的名称。
- **电价。** 可选。填写后，GlintMiner 会显示扣除电费后的利润，而不只是收入。电费单上有每 kWh 的价格。所选货币也决定收益的显示方式。
- **要调校显卡吗？** 可选，默认关闭。你按想要的结果来选：收益最高（推荐；如果你跳过了电价，设置程序会询问）、算力最高、速度不变但更省电，或让显卡最凉最静。选择其中一项后，设置程序会用一句话说明风险，只有你输入 **Y** 才会开启调校。在 Windows 上，它会提出以管理员身份重新启动 GlintMiner，因为调校需要管理员权限。如果选择不重启，显卡以出厂设置挖矿。请先阅读[自动调校](auto-tune.zh-CN.md)。
- **启动时打开面板？** 面板是 GlintMiner 在你自己电脑上提供的网页，包含图表、收益和设置。

GlintMiner 会把你的回答保存在程序旁边的 `glint.json` 中，下次启动直接开始挖矿。之后你可以在面板的 **设置** 中更改任何一项。

## 你会看到什么

**控制台**（黑色窗口）显示一张实时表格：每张显卡的算力、温度、功耗、已接受的份额，以及 **每天能赚多少**，还有目前为止的开发者抽水。

GlintMiner 运行时，在浏览器中打开 **http://127.0.0.1:4078** 即可看到**面板**。它的首页按轻重缓急回答四个问题：

- **运行正常吗？** 一切正常时为绿色；有问题时为黄色或红色，并写明原因和该做的那一件事。
- **我赚了多少？** 扣除电费后的每日利润（未填电价时为每日收入）、今天到目前和过去 7 天的收益。
- **显卡发挥到最好了吗？** 自动调校是否开启、提升了多少；调校进行中则显示进度。
- **什么时候到账？** 你在矿池的余额、离下次支付还差多少，以及上一笔支付。

完整介绍见[面板](dashboard.zh-CN.md)。你也可以[用手机查看](phone-access.zh-CN.md)。

> **给它几分钟。** 算力一两分钟内就会稳定。矿池网站和面板上的矿池数据会滞后 10–30 分钟，因为矿池报告的是平均值。第一笔支付可能需要一天或更久（见下文）。

## 什么时候能收到钱？

矿池会为你累计余额，超过矿池的最低支付额后打到你的钱包：

- **HeroMiners（Pearl）：** 余额超过最低额度时支付。新挖出的区块需要几个小时确认才会计入，所以单张显卡的第一笔支付可能需要一天或更久。
- **Kryptex（Pearl）：** 为每个份额记账，收益成熟后满 1 PRL 即打到你的钱包。面板会显示哪些已可支付、哪些仍在成熟中，以及 Kryptex 看到的本机情况。
- **Kryptex 账户：** 余额累积在你的 Kryptex 账户中，只有你自己能看到；请在 kryptex.com 查看和提现。
- **unMineable：** 超过该币种的最低额度后以你的币支付；面板显示 unMineable 的数据。

面板上的 **什么时候到账？** 卡片会显示你的余额、下次支付的大致时间以及你收到的每一笔支付（最近几笔，另有链接可查看矿池上的完整记录）。

> **提示：** 让它一直运行。矿池按稳定的工作量付费，全天候运行的显卡比每晚开开关关的显卡赚得多得多。

## 更新

有新版本时 GlintMiner 会提醒你（在控制台和面板上）。它绝不会自行下载或安装任何东西。更新方法：

1. 关闭 GlintMiner。
2. 从[最新版本](https://github.com/MaccaDaStaka/GlintMiner/releases/latest)页面下载新文件。
3. 解压到同一个文件夹并替换文件。你的设置（`glint.json`）、历史记录和基准测试数据不在压缩包里，所以会保留。
4. 重新运行 `glint.exe`，它会按你的设置继续挖矿。

在 Linux 上替换 `glint`。在 HiveOS 上，把自定义矿工的安装链接改为新版本。

## 停止与卸载

- **停止：** 关闭窗口或按 **Ctrl+C**。GlintMiner 对显卡所做的一切更改（功耗上限，以及使用自动调校时的频率）都会在关闭时恢复。
- **在这台电脑上玩游戏？** 在 Windows 上不需要停止它：游戏使用显卡时 GlintMiner 会自动暂停挖矿，退出游戏一分钟后继续（见[游戏与计划](auto-tune.zh-CN.md#游戏与计划)）。如果要停止，请正常关闭，不要用任务管理器。
- **卸载：** 先停止它，然后删除文件夹。GlintMiner 不会安装其他任何东西：没有服务、没有注册表项、没有后台程序。（如果你把它设置成了 Linux 服务或在矿机系统上运行，也要在那里删除。）
