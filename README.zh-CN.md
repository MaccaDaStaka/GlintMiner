<div align="center">

# GlintMiner

### 大约一分钟，让你的 NVIDIA 显卡开始挖 Pearl。

**选择收款方式，粘贴地址，开始赚钱。**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

### [⬇ 下载 GlintMiner 1.2.1](../../releases/latest)
Windows · Linux · HiveOS · 免费使用，开发者抽水 1%

[English](README.md) · [Русский](README.ru.md) · **简体中文**

<img src="images/dashboard-desktop.jpg" width="860" alt="GlintMiner 面板：每日利润、算力、显卡、份额和矿池一目了然">

</div>

---

GlintMiner 是一款在 NVIDIA 显卡上挖 **Pearl (PRL)** 的矿工软件。它的目标是让每一瓦电挖出更多 Pearl，同时也是上手最简单的：
不用改配置文件，不用写 bat 脚本，也不用学命令行。它会问你想用什么方式收款、收益发到哪里，然后实时显示你的显卡按法币计算能赚多少。

**1.2 新功能：** 全新面板，手机和电脑都好用，支持英文、俄文和中文 · 可选的**自动调校**（在我们的 RTX 4090 上：**算力 +6%**，或保持出厂算力的同时**功耗降低 24%**）· 设置时可选择用 Pearl、通过 Kryptex 收 Bitcoin/USDT/USDC，或其他币种收款。

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
| 出厂 | 308 TH/s | 445 W | 0.69 |
| **自动调校：速度** | **328 TH/s**（+6%） | 414 W | 0.79 |
| **自动调校：能效** | 307 TH/s | **337 W**（−24%） | **0.91** |

<sub>GlintMiner 1.2.0 在 HeroMiners 实际挖矿，2026 年 9 月，单张 RTX 4090。每颗芯片都略有不同，你的显卡结果也会不同。</sub>

- **每瓦挖得更多。** 满功耗时全速运行；为了温度、噪音或电费限制功耗时，GlintMiner 能保留更多算力。
- **PRL 结算总费用仅 1%。** 我们抽水 1%，HeroMiners 不收矿池费。抽水过程全程可见。
- **想要什么币就付什么币。** 可以直接挖到 Pearl 钱包，也可以用 Bitcoin、Litecoin、Dogecoin、Solana 等约 25 种币结算。
- **收益一目了然。** 以 USD、EUR、CNY 或你自己的货币显示每日收益；填入电价后还能显示扣除电费后的利润。
- **保护你的硬件。** 每张显卡的温度都受到监控：温度偏高时自动降低功耗，接近极限时暂停该卡，冷却后再继续。
- **想要更多，也可以。** 可选的[自动调校](#自动调校可选)会在挖矿时为你的显卡找到最佳稳定设置：更高的算力，或以明显更低的功耗保持同样算力。
- **开了就不用管。** 看门狗、自动切换备用矿池、TLS 加密连接，出问题时给出通俗易懂的提示。

<p align="center">
  <img src="images/phone-home.jpg" width="260" alt="手机上的面板：每日利润、算力、功耗和份额">
  &nbsp;&nbsp;
  <img src="images/phone-tuned.jpg" width="260" alt="自动调校后的显卡：比出厂高 6.3% 的算力，每个结果都经过校验">
</p>
<p align="center"><sub>手机上的面板：收益一目了然，以及自动调校后的显卡（截图为英文界面；面板也支持中文）。</sub></p>

---

## 第一次挖矿？从这里开始

从没挖过矿？只需几分钟，不需要任何技术知识。

### 你需要准备

1. **一张 NVIDIA 显卡**，RTX 30、40 或 50 系列（例如 RTX 3060、4070、5060），并安装较新的 NVIDIA 驱动。
   如果你用这台电脑玩游戏，大概率已经有了。
2. **收益发到哪里。** 有三种选择：
   - **Pearl 地址**（以 `prl1` 开头）：以 Pearl 自己的币 PRL 结算。
   - **你已经在用的其他币的地址**，例如 Bitcoin、Litecoin、Dogecoin、Solana 等。在交易所或钱包 App 的“收款”/“充值”页面可以找到。
     GlintMiner 挖的是 Pearl，收益以你选择的币结算。

   - **Kryptex 账户 ID**（以 `krx` 开头；在 pool.kryptex.com 免费注册，只需邮箱）。Kryptex 会自动把 Pearl 兑换成比特币，你可以从 Kryptex 账户提现为 **BTC、USDT 或 USDC**。

   不知道选哪个？
   - **最划算：** **Pearl 地址**。无需兑换，HeroMiners 也不收矿池费。可在 Pearl 钱包 App 中免费获取（打开 **Receive**）。
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

**3. 回答设置问题。** 程序界面为英文。先选择收款方式（1：Pearl；2：通过 Kryptex 账户收 BTC、USDT 或 USDC；3：其他币种），再粘贴对应地址，然后填写矿机名称，以及（可选）每千瓦时电价。

```
  Welcome to GlintMiner. How do you want to be paid?

    1) Pearl (PRL) to your Pearl wallet          best value: no pool fee, no conversion
    2) Bitcoin, USDT or USDC via a free Kryptex account   Kryptex converts for you (2% fee)
    3) Another coin (LTC, DOGE, SOL, ETH...) to your own wallet   unMineable converts (1% fee)

  Choose 1, 2 or 3 [1]: 1
  Paste your Pearl address (starts with prl1; get one free in the Pearl wallet app, Receive): prl1...
  -> Paid in PRL to your Pearl wallet, mining on HeroMiners (no pool fee).
  Name for this rig (shown on the pool) [rig1]:
  Electricity price per kWh, for profit after power (e.g. 0.12; Enter to skip): 0.6
  Currency of that price [USD]: CNY
```

完成，已经开始挖矿了。GlintMiner 会记住你的设置，下次启动直接开始。

### 你会看到什么

每张显卡的实时画面：算力、温度、功耗、已接受的份额，以及**每日收益**。GlintMiner 运行时，在浏览器打开
**http://127.0.0.1:4078** 可以查看图表、历史记录和付款（启动时也可以自动打开）。面板同样适用于手机，支持英文、俄文和中文，并把本矿机的收益估算与钱包在矿池的余额和付款分开显示。

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

## 自动调校（可选）

每颗显卡芯片都略有不同。自动调校会在挖矿的同时，为**你的**显卡自动找到最佳的稳定设置，只保留经 Pearl 官方校验器验证无误、并留有安全余量的设置。在我们的 RTX 4090 上，**速度**模式找到了**比出厂设置高 6% 的算力，同时功耗降低 30 W**；**能效**模式在保持出厂算力的同时，**功耗降低约四分之一**（337 W，出厂为 445 W）。

| 模式 | 目标 |
|---|---|
| **关闭**（默认） | 出厂设置 |
| **速度** | 显卡能零错误稳定运行的最高算力 |
| **能效** | 以尽可能低的功耗保持出厂算力（更凉、更安静） |
| **利润** | 扣除电费后收益最高（需要填写电价） |

在面板中开启（**设置 → 调优**），或使用 `glint --tune speed --confirm-tuning`（也可用 `efficiency`、`profit`）。`--confirm-tuning` 只需第一次添加，用来确认你接受下文所述的风险；`--tune off` 关闭调校。需要以管理员（Windows）或 root（Linux）身份运行。首次调校约需一小时，期间显卡照常挖矿；结果会保存，并在每次启动时自动应用。

**坦白说明风险：**自动调校会让显卡运行在出厂设置之外。它在第一个错误时就会退回，绝不超频显存，不会超过显卡自身的最大功耗，并在 GlintMiner 关闭时（或崩溃后的下一次启动时）恢复一切。但不稳定的设置仍可能导致挖矿程序崩溃，极少数情况下导致显卡驱动重置。开启与否由你决定，风险自负；你不开启，它就一直关闭。

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
| `--tune MODE` | 自动调校：`speed`、`efficiency`、`profit` 或 `off`（需以管理员身份运行；第一次需加 `--confirm-tuning`） |
| `--retune` | 清除已保存的调校结果并重新调校 |
| `--api-bind 0.0.0.0` | 允许局域网内其他设备查看面板（只读） |
| `--api-allow-remote-control` | 同时允许从这些设备修改设置（仅在你信任的网络中使用） |
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
- 自动调校需要管理员（Windows）或 root（Linux）权限以及较新的 NVIDIA 驱动；不满足时 GlintMiner 会以出厂设置正常挖矿

## 常见问题

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
