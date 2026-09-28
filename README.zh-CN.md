<div align="center">

# GlintMiner

### 大约一分钟，让你的 NVIDIA 显卡开始挖 Pearl。

**选择收款方式，粘贴地址，开始赚钱。**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

### [⬇ 下载 GlintMiner 1.2.4](../../releases/latest)
Windows · Linux · HiveOS · 免费使用，开发者抽水 1%

[English](README.md) · [Русский](README.ru.md) · **简体中文**

<img src="images/dashboard-desktop.jpg" width="860" alt="GlintMiner 面板：是否正常运行、赚了多少、显卡调优情况和什么时候到账，一目了然">

</div>

---

GlintMiner 是一款在 NVIDIA 显卡上挖 **Pearl (PRL)** 的矿工软件。它的目标是让每一瓦电挖出更多 Pearl，同时也是上手最简单的：
不用改配置文件，不用写 bat 脚本，也不用学命令行。它会问你想用什么方式收款、收益发到哪里，然后实时显示你的显卡按法币计算能赚多少。

**1.2.4 新功能：** 自动调校的结果改为在正常挖矿时测量，与实时算力一致（在我们的 RTX 4090 上：**330–333 TH/s，比出厂约 +7–8%**）·
错误提示更清楚、更平和：矿池或价格网站连不上时，面板会用简单的话说明，并继续显示上次的数据及其时间。

**1.2.3 新功能：** 每张显卡挖得更快（RTX 40 约 +1%，RTX 50 约 +1.8%；RTX 5090、3080 等显卡因工作量现在平均分配到整个芯片，
最多再快 3.6%）· 更聪明的自动调校（在我们的 RTX 4090 上：**算力 +7.3%**，或保持出厂算力的同时**功耗降低 24%**；
"利润"模式现在会计算电费；矿机上的每张显卡可以有各自的模式）· 在 Kryptex 和 HeroMiners 上份额小得多（约 11–14 KB，而不是 2 MB）。

**1.2 新功能：** 全新面板，手机和电脑都好用，支持英文、俄文和中文 · 可选的**自动调校**（在我们的 RTX 4090 上：**算力 +6%**，或保持出厂算力的同时**功耗降低 24%**）· 设置时可选择用 Pearl（HeroMiners 或 Kryptex）、通过 Kryptex 收 Bitcoin/USDT/USDC，或其他币种收款。

## 为什么选择 GlintMiner

| RTX 4090，默认频率 | **GlintMiner** | 最接近的竞品 |
|---|:-:|:-:|
| 算力 @ 435 W | **304 TH/s** | 302 TH/s |
| 算力 @ 300 W | **258 TH/s** | 235 TH/s |
| 能效 @ 300 W | **每瓦 0.86 TH/s** | 0.78 |
| 全部费用（PRL 结算） | **1%**（HeroMiners 矿池费 0%） | 1–3%（软件 0%，矿池 1–3%） |
| 上手方式 | **粘贴钱包地址** | 修改 .bat 文件 |

<sub>测试于 2026 年 9 月：单张 RTX 4090，两款软件在同一张卡、同一天测试。“最接近的竞品”指我们测试过的其他 Pearl 挖矿软件中最快的一款；它不收软件抽水，但只能在自家矿池挖矿，而该矿池收费。实际结果因显卡、驱动和设置而异。</sub>

**开启自动调校（可选）。** 让 GlintMiner 为你的显卡找到最佳稳定设置：

| RTX 4090 | 算力 | 功耗 | 每瓦 TH/s |
|---|:-:|:-:|:-:|
| 出厂 | 310 TH/s | 443 W | 0.70 |
| **自动调校：速度** | **333 TH/s**（+7%） | 431 W | 0.77 |
| **自动调校：能效** | 310 TH/s | **338 W**（−24%） | **0.92** |

<sub>GlintMiner 1.2.3 在 Kryptex 实际挖矿，2026 年 9 月，单张 RTX 4090。每颗芯片都略有不同，你的显卡结果也会不同。</sub>

- **每瓦挖得更多。** 满功耗时全速运行；为了温度、噪音或电费限制功耗时，GlintMiner 能保留更多算力。
- **PRL 结算总费用仅 1%。** 我们抽水 1%，HeroMiners 不收矿池费。抽水过程全程可见。
- **想要什么币就付什么币。** 可以直接挖到 Pearl 钱包，也可以用 Bitcoin、Litecoin、Dogecoin、Solana 等约 25 种币结算。
- **收益一目了然。** 以 USD、EUR、CNY 或你自己的货币显示每日收益；填入电价后还能显示扣除电费后的利润。
- **保护你的硬件。** 每张显卡的温度都受到监控：温度偏高时自动降低功耗，接近极限时暂停该卡，冷却后再继续。温度上限自动取自显卡自身的安全上限（RTX 4090：出厂设置 80 °C，自动调校后 83 °C），绝不超过；也可在设置中自行指定。
- **想要更多，也可以。** 可选的[自动调校](#自动调校可选)会在挖矿时为你的显卡找到最佳稳定设置：更高的算力，或以明显更低的功耗保持同样算力。
- **开了就不用管。** 看门狗、自动切换备用矿池、TLS 加密连接，出问题时给出通俗易懂的提示。

<p align="center">
  <img src="images/phone-home.jpg" width="260" alt="手机上的面板：运行状态、每日利润和调优结果">
  &nbsp;&nbsp;
  <img src="images/phone-tuned.jpg" width="260" alt="自动调校后的显卡：比出厂高 6.3% 的算力，功耗更低">
</p>
<p align="center"><sub>手机上的面板：收益一目了然，以及自动调校后的显卡（截图为英文界面；面板也支持中文）。</sub></p>

---

## 第一次挖矿？从这里开始

从没挖过矿？只需几分钟，不需要任何技术知识。

### 你需要准备

1. **一张 NVIDIA 显卡**，RTX 30、40 或 50 系列（例如 RTX 3060、4070、5060），并安装较新的 NVIDIA 驱动。
   如果你用这台电脑玩游戏，大概率已经有了。
2. **收益发到哪里。** 有三种选择：
   - **Pearl 地址**（以 `prl1` 开头）：以 Pearl 自己的币 PRL 结算。设置时可选两个矿池：**HeroMiners**（不收矿池费）或 **Kryptex**（收取 2%；每个份额都付费，余额稳定增长，满 1 PRL 即打到你的钱包）。
   - **你已经在用的其他币的地址**，例如 Bitcoin、Litecoin、Dogecoin、Solana 等。在交易所或钱包 App 的“收款”/“充值”页面可以找到。
     GlintMiner 挖的是 Pearl，收益以你选择的币结算。
   - **Kryptex 账户 ID**（以 `krx` 开头；在 pool.kryptex.com 免费注册，只需邮箱）。Kryptex 会自动把 Pearl 兑换成比特币，你可以从 Kryptex 账户提现为 **BTC、USDT 或 USDC**。

   不知道选哪个？
   - **最划算：** 在 HeroMiners 上用 **Pearl 地址**。无需兑换，也不收矿池费。可在 Pearl 钱包 App 中免费获取（打开 **Receive**）。
   - **想要 Pearl，而且收益更平稳：** 同一个 Pearl 地址改用 **Kryptex**。多付 2%，换来每个份额都有收益，不用看矿池的运气。
   - **想省心地拿到比特币或稳定币：** **Kryptex 账户**。Kryptex 收取 2%，且不公布兑换汇率，但据我们估算，它很可能比通过 unMineable 兑换明显更划算。
   - **想把其他币直接打到自己的钱包：** 填写该币的地址。unMineable 负责兑换，收取 1% 费用，GlintMiner 会显示 unMineable 自己给出的收益估算。

### 三步开始

**1. 下载。** 打开[最新版本](../../releases/latest)页面，下载适合你系统的文件：

| 你的系统 | 下载文件 |
|---|---|
| Windows 10 / 11 | `glint-…-windows.zip` |
| Linux | `glint-…-linux.tar.gz` |
| HiveOS 矿机 | `glint-…-hiveos.tar.gz` |

**2. 解压并运行。** 解压到任意文件夹，例如 `C:\GlintMiner`，然后双击 `glint.exe`。Linux 下运行 `./glint`。

> 首次运行时，Windows 可能会显示 **“Windows 已保护你的电脑”**。对于下载量还不多的新程序，Windows 都会这样提示。
> 点击 **更多信息**，然后点击 **仍要运行** 即可。只需操作一次。

**3. 回答设置问题。** 程序界面为英文。每个问题输入一个数字并按 Enter（直接按 Enter 选第一项）。先选择收款方式（1：Pearl，HeroMiners；2：Pearl，Kryptex；3：通过 Kryptex 账户收 BTC、USDT 或 USDC；4：其他币种）。如果你已经复制了地址，GlintMiner 会在剪贴板里找到它，不用再粘贴。矿机名称默认用电脑名，电价币种默认建议系统设置中的币种，最后会问你是否开启[自动调校](#自动调校可选)（默认关闭）。

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
    2) Enter it now  (currency from your system: CNY)
  Type 1 or 2 and press Enter [1]: 2
  Price per kWh (e.g. 0.12): 0.6
  Currency of that price:
    1) CNY
    2) USD
    3) EUR
    4) GBP
    5) Other (type 3 letters)
  Type 1-5 and press Enter [1]: 1

  Tune your card? (you can change this any time)
  Tuning needs administrator rights: if you turn it on, setup can restart GlintMiner as administrator.
    1) Off, stock clocks (default)
    2) Speed: more hashrate
    3) Efficiency: less power
    4) Profit: the most profit after power
  Type 1-4 and press Enter [1]: 1

  Open the dashboard (charts, earnings, settings) in your browser at start?
    1) Yes
    2) No
  Type 1 or 2 and press Enter [1]: 1

  All set. Mining...
```

如果选择了调校模式，设置程序会用一句话说明风险，只有你输入 **Y** 才会开启调校。它会告诉你这张显卡的自动温度上限；在 Windows 上还会提出以管理员身份重新启动 GlintMiner（调校需要管理员权限，Windows 会请你确认）。如果选择不重启，显卡以出厂设置挖矿，GlintMiner 每次启动时都会再次询问。

完成，已经开始挖矿了。GlintMiner 会记住你的设置，下次启动直接开始。

### 你会看到什么

每张显卡的实时画面：算力、温度、功耗、已接受的份额，以及**每日收益**。想看更多，GlintMiner 运行时在浏览器打开
**http://127.0.0.1:4078** 即可（启动时也可以自动打开）。面板首页按轻重缓急回答四个问题：

- **运行正常吗？** 一行状态：一切正常时为绿色；有问题时为黄色或红色，并写明原因和该怎么做。
- **我赚了多少？** 扣除电费后的每日利润（未填电价时为每日收入）、今天到目前为止和最近 7 天的收益。
- **显卡发挥到最好了吗？** 自动调校是否开启、提升了多少（例如“已调优 +6.3%”）；调校进行中则显示进度和剩余时间。
- **什么时候到账？** 你在矿池的余额、离下次支付还差多少、大约什么时候支付，以及上一笔支付。

**收益**页有每日数据、收益预测和矿池付款记录；**矿机**页有每张显卡和调校控制；**设置**页可以设置收款方式、电价、调校、温度上限、谁可以打开面板和语言。面板同样适用于手机，支持英文、俄文和中文，并把本矿机的收益估算与钱包在矿池的余额和付款分开显示。

### 什么时候能收到钱？

矿池会为你累计余额，超过矿池的最低支付额后打到你的钱包。单张显卡可能需要一天或更久；新挖出的区块需要几个小时确认后才会计入。
面板的**什么时候到账？**会显示你的余额、下次支付的大致时间和每一笔支付记录。在 Kryptex 上挖 Pearl 时，显示的是 Kryptex 自己的数据：哪些已可支付、哪些仍在成熟中、离 1 PRL 起付还差多少，以及 Kryptex 看到的本矿机算力。Kryptex 账户的余额是私密的，只能在 kryptex.com 你的账户中查看。

> **提示：** 让它一直运行。矿池按稳定的工作量付费，全天候运行的显卡比每晚开开关关的显卡赚得多得多。

---

## 1% 开发者抽水，公开透明

- 每张显卡大约每一百秒中有一秒为开发者挖矿。矿池看到的算力是平稳的，不会像某些软件那样出现长达一分钟的空档。
- 实时画面和面板会显示抽水比例和目前为止实际抽取的数量。除此之外不收取任何费用。
- 如果抽水服务器无法连接，你照常挖矿。错过的部分之后会慢慢补上，最多约一小时的量。
- 抽水份额带有一个匿名标签：显卡型号与数量、结算方式、GlintMiner 版本以及是否已调校（例如 `g4687ad-hmv123s-4090x1`），让开发者了解 GlintMiner 的使用情况。绝不包含你的钱包、矿机名、IP 地址或位置。

## 值得信赖

- **每个份额在提交前都会在你的电脑上**用 Pearl 官方校验器验证。如果 Pearl 网络规则变更，GlintMiner 会停下来提示你更新，而不是继续提交会被拒绝的份额。
- **没有意外。** 有新版本时 GlintMiner 会提醒你，但绝不会自行下载或安装任何东西。
- **设置掌握在你手中。** 所有设置都保存在程序旁边的 `glint.json` 中。
- **默认使用出厂设置，除非你另行选择。** 默认情况下 GlintMiner 不改动频率、电压或风扇，只会在显卡过热时调低功耗上限。可选的**自动调校**（见下文）只有在你开启后才会调整频率。GlintMiner 所做的一切更改都会在关闭时恢复。

## 多显卡与多台矿机

- **一台电脑，多张显卡。** GlintMiner 会自动使用电脑中所有受支持的 NVIDIA 显卡，型号可以混搭（例如 3080 加 4070）。每张卡在实时画面和面板中都有单独一行：算力、温度、功耗和份额。所有显卡共用一个矿池连接，所以矿池看到的是每台电脑一个矿工。
- **选择用哪些卡。** `--devices 0,2` 只使用这几张卡（编号与 `glint --gpu-info` 一致）。
- **一张卡出问题，不影响其他卡。** 某张卡无法启动时，其他卡继续挖矿，实时画面会显示原因。某张卡失去响应时，GlintMiner 会自动重启并继续挖矿。
- **每张卡单独保护。** 温度保护会分别监控每一张卡。
- **多台电脑。** 每台电脑运行 GlintMiner 时用不同的矿工名（`--worker rig2`），使用同一个钱包。矿池统计页面会分别列出每台电脑。
- **内存。** 每张显卡约需 1.5 GB 系统内存。
- **无显示器矿机。** 使用 HiveOS、MMPOS、Docker 包或 systemd 服务（见下文）。加上 `--api-bind 0.0.0.0` 即可在局域网内其他设备上查看面板（只读）；如需从这些设备修改设置，请再加上 `--api-allow-remote-control`。

## 随时随地用手机查看矿机（Tailscale）

[Tailscale](https://tailscale.com)（个人使用免费）把你自己的设备私密地连在一起：手机在任何地方都能打开面板，而电脑不必暴露在互联网上。

1. 在挖矿电脑和手机上安装 Tailscale，并在两边登录同一个账号。
2. 在面板中打开 **设置 → 面板 → 谁可以打开**，选择 **其他设备，例如在家或通过 Tailscale 使用的手机（仅查看）**，保存后重启 GlintMiner。其他设备看到的是只读面板（如果也想从这些设备修改设置，请加上 `--api-allow-remote-control`）。
3. 在防火墙中只为 Tailscale 放行面板端口。
   - **Windows：** 以管理员身份打开 PowerShell 并运行：
     ```
     New-NetFirewallRule -DisplayName "GlintMiner dashboard (Tailscale)" -Direction Inbound -Protocol TCP -LocalPort 4078 -RemoteAddress 100.64.0.0/10 -Action Allow
     ```
     如果 GlintMiner 启动时 Windows 弹出防火墙提示，不要勾选公用（Public）网络。
   - **Linux / HiveOS：** Tailscale 通常会自行处理。如果你使用 ufw：`ufw allow in on tailscale0 to any port 4078`。
4. 在手机上打开 `http://100.x.y.z:4078`（电脑的 Tailscale 地址，可在 Tailscale 应用中看到），或 `http://电脑名:4078`，或完整名称 `电脑名.你的网络.ts.net`。

**切勿在路由器上转发 4078 端口。** 那样整个互联网都能打开你的面板。

其他查看方式：
- **矿池网站：** 搜索你的钱包地址，即可看到算力和余额。
- **Telegram 提醒：** 显卡停止或与矿池断开时发消息给你（`--telegram-token` 和 `--telegram-chat`，或 设置 → Telegram 提醒）。

## 自动调校（可选）

每颗显卡芯片都略有不同。自动调校会在挖矿的同时，为**你的**显卡自动找到最佳的稳定设置，只保留经 Pearl 官方校验器验证无误、并留有安全余量的设置。在我们的 RTX 4090 上，**速度**模式找到了**比出厂设置高 6% 的算力，同时功耗降低 30 W**；**能效**模式在保持出厂算力的同时，**功耗降低约四分之一**（337 W，出厂为 445 W）。

| 模式 | 目标 |
|---|---|
| **关闭**（默认） | 出厂设置 |
| **速度** | 显卡能零错误稳定运行的最高算力 |
| **能效** | 以尽可能低的功耗保持出厂算力（更凉、更安静） |
| **利润** | 扣除电费后收益最高：按今天的币价和电价，在速度与能效两个结果中选收益更高的一个运行（需要填写电价） |

在面板中开启（**设置 → 调优**），或使用 `glint --tune speed --confirm-tuning`（也可用 `efficiency`、`profit`）。`--confirm-tuning` 只需第一次添加，用来确认你接受下文所述的风险；`--tune off` 关闭调校。需要以管理员（Windows）或 root（Linux）身份运行；在 Windows 上开启调校后，GlintMiner 会主动提出以管理员身份重新启动。在高性能显卡上调校约需一小时（能效模式约 30 分钟），期间显卡照常挖矿。面板会显示进度和剩余时间，完成后显示结果（例如 **已调优 +6.3%**）；结果会保存，并在每次启动时自动应用。显卡处于调校状态时，它的自动温度上限就是显卡自身的安全最高温度。

利润模式会先找出这两个结果（所以第一次调校时间更长），之后每半小时根据币价和你的电价重新比较一次，只有另一个结果明显更赚钱时才切换。速度模式下，如果显卡之后明显比调校时更凉（例如寒冷的夜晚、更好的机箱），它会再往上调一点，每天最多一次，并保留已保存的结果作为后备。

**每张显卡各自的模式。** 在多卡矿机上，每张显卡都可以有自己的模式：例如一张用速度，另一张用能效，再一张保持出厂设置。没有单独设置的显卡跟随矿机的模式。可在**设置 → 调优**（矿机模式下方的显卡列表）或**矿机**页面的每张显卡上设置；在那里还可以只重新调校某一张卡或暂停它，其他显卡照常挖矿并保持各自的调校结果。首页会汇总显示，例如：*已调优 2/3 张显卡：GPU 0 +6.4%，GPU 1 功耗 −22%；GPU 2 保持默认*。命令行：`glint --tune-card 0=speed,1=efficiency,2=off --confirm-tuning`。显卡重新编号时模式不会丢失（按显卡插槽保存）；把显卡切回曾经调校过的模式时，会直接使用那次的结果。

**坦白说明风险：**自动调校会让显卡运行在出厂设置之外。它在第一个错误时就会退回，绝不超频显存，不会超过显卡自身的最大功耗，并在 GlintMiner 关闭时（或崩溃后的下一次启动时）恢复一切。但不稳定的设置仍可能导致挖矿程序崩溃，极少数情况下导致显卡驱动重置。开启与否由你决定，风险自负；你不开启，它就一直关闭。

## 矿机用户与进阶用户

设置向导里的所有选项也可以通过命令行指定：

```
glint --wallet prl1... --worker rig1
glint --wallet prl1... --pool stratum+ssl://prl.kryptex.network:8048
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
| `--tune MODE` | 自动调校：`speed`、`efficiency`、`profit` 或 `off`（需以管理员身份运行；第一次需加 `--confirm-tuning`） |
| `--retune` | 清除已保存的调校结果并重新调校 |
| `--tune-card 0=speed,1=efficiency,2=off` | 为每张显卡设置各自的模式（`default` = 跟随 `--tune`）；未列出的显卡跟随 `--tune` |
| `--tune-exclude 0,2` | 其他显卡调校时，让这几张卡保持出厂设置（等同于 `--tune-card 0=off,2=off`） |
| `--tune-reset` | 清除已保存的调校结果、各卡模式和排除列表，并关闭调校 |
| `--share-diff N` | 仅限 Kryptex：向矿池申请的份额难度（0 = 自动） |
| `--api-bind 0.0.0.0` | 允许局域网内其他设备查看面板（只读） |
| `--api-allow-remote-control` | 同时允许从这些设备修改设置（仅在你信任的网络中使用） |
| `--telegram-token`, `--telegram-chat` | 通过 Telegram 接收提醒 |
| `--plain` | 纯文本日志，适用于系统服务和矿机系统 |
| `--save` | 将这些参数保存到 `glint.json` |
| `--config PATH` | 使用其他设置文件（默认：`glint` 旁边的 `glint.json`） |

诊断工具：`--self-test`、`--gpu-info`、`--bench 60`、`--benchmarks`。完整列表：`glint --help`。

**在 HeroMiners 上**，份额同样压缩后发送（每个约 14 KB，而不是 2 MB）；如果某台 HeroMiners 服务器不接受，GlintMiner 在本次运行中改为向该服务器发送未压缩的份额。

**在 Kryptex 上**，只要 Kryptex 在登录时同意，份额就会压缩后发送（每个约 11 KB，而不是 2 MB）：流量更少，网络慢时过期份额也更少。大型矿机（超过 500 TH/s）会自动向 Kryptex 申请更高的份额难度，约每 30 秒一个份额，避免向矿池发送过多份额；也可以用 `--share-diff N` 自行设置（Kryptex 默认 2097152；公式：算力（H/s）× 每个份额的秒数 ÷ 4294967296）。收益不会因此改变：每个份额只是算得更多。

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
- 自动调校需要管理员（Windows）或 root（Linux）权限以及较新的 NVIDIA 驱动；不满足时 GlintMiner 会以出厂设置正常挖矿

## 常见问题

**算力比预期低？**
挖矿时请关闭其他占用显卡的程序，例如动态或视频壁纸、游戏、视频编辑软件：它们会占用一部分显卡，挖矿就会变慢（自动调校也会把显卡当成更慢的卡）。

**对显卡安全吗？**
在默认设置下，GlintMiner 不改动频率或电压。它持续监控温度：温度偏高时降低功耗上限（需以管理员身份运行），接近极限时暂停该卡，冷却后再继续。只有开启自动调校后才会调整频率。关闭程序时一切都会恢复。

**挖矿时还能用电脑吗？**
可以，但游戏和视频剪辑会变慢。需要显卡全部性能时，关闭 GlintMiner 即可（Ctrl+C 或直接关闭窗口）。

**我能赚多少？**
这取决于你的显卡、Pearl 价格和全网难度，这些都在不断变化。GlintMiner 从启动那一刻起就实时显示你的真实每日收益。

**如何更新到新版本？**
有新版本时 GlintMiner 会提醒你，无需卸载任何东西。关闭 GlintMiner，从[最新版本](../../releases/latest)页面下载新的压缩包，解压到同一个文件夹并替换文件。你的设置（`glint.json`）、历史记录和基准测试数据不在压缩包里，所以会保留。重新运行 `glint.exe`，它会按你的设置继续挖矿。（Linux：替换 `glint`。HiveOS：把自定义矿工的下载链接改为新版本。）

**我有多台矿机用同一个钱包。**
用 `--worker` 给每台矿机起不同的名字，矿池的统计页面就会分别列出每台矿机。

**遇到问题了。**
运行 `glint --self-test`，然后提交 [issue](../../issues)，附上输出内容、显卡型号和驱动版本。

## 支持

发现 bug 或有建议？请提交 [issue](../../issues)（可以用中文）。请附上显卡型号、驱动版本以及 `glint.log` 中的相关内容。

## 许可

GlintMiner 可免费用于个人和商业挖矿。程序为闭源软件。详见 [LICENSE.txt](LICENSE.txt)，以及列出所用开源组件的 `THIRD_PARTY_NOTICES.txt`。
