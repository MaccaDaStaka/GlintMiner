<div align="center">

# GlintMiner

### 大约一分钟，让你的 NVIDIA 显卡开始挖 Pearl。

**选择收款方式，粘贴地址，开始赚钱。**

![Dev fee 1%](https://img.shields.io/badge/dev%20fee-1%25-2ea44f)
![NVIDIA RTX 30 | 40 | 50](https://img.shields.io/badge/NVIDIA-RTX%2030%20%7C%2040%20%7C%2050-76b900)
![Windows | Linux](https://img.shields.io/badge/Windows%20%7C%20Linux-supported-0a66c2)
![HiveOS | MMPOS | Docker](https://img.shields.io/badge/HiveOS%20%7C%20MMPOS%20%7C%20Docker-ready-555)

### [⬇ 下载 GlintMiner 1.2.5](../../releases/latest)
Windows · Linux · HiveOS · 免费使用，开发者抽水 1%

[English](README.md) · [Русский](README.ru.md) · **简体中文**

<img src="images/dashboard-desktop.jpg" width="860" alt="GlintMiner 面板：是否正常运行、赚了多少、显卡调优情况和什么时候到账，一目了然">

</div>

---

GlintMiner 是一款在 NVIDIA 显卡上挖 **Pearl (PRL)** 的矿工软件。它的目标是让每一瓦电挖出尽可能多的 Pearl，同时也是上手最简单的矿工软件：不用改配置文件，不用写 bat 脚本，也不用学命令行。它会问你想用什么方式收款、收益发到哪里，然后实时显示你的显卡实际能赚多少钱。

**1.2.5 新功能：** 自动调校能稳定地找到显卡的最佳设置（在我们的 RTX 4090 上：**实际挖矿 332 TH/s，比出厂 +7.4%**），并在你挖矿时自行核对这个数字 · 从真正的出厂状态开始调校，MSI Afterburner 或类似工具打开时会等待 · 出问题时更安全：导致电脑崩溃的调校结果会被回退，挖矿程序被强行结束后，下次启动会先把显卡恢复原样 · 面板更清爽、外观全新，显示最近几笔支付，完整记录点一下即可查看，事件只保留重要的。[全部更新内容](CHANGELOG.md)

## 为什么选择 GlintMiner

| RTX 4090，出厂频率 | **GlintMiner** | 最接近的竞品 |
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
| **自动调校：速度** | **332 TH/s**（+7%） | 430 W | 0.77 |
| **自动调校：能效** | 310 TH/s | **338 W**（−24%） | **0.92** |

<sub>GlintMiner 在 Kryptex 实际挖矿，2026 年 9 月，单张 RTX 4090。每颗芯片都略有不同，你的显卡结果也会不同。</sub>

- **每瓦挖得更多。** 满功耗时全速运行；为了温度、噪音或电费限制显卡功耗时，也能保留更多算力。
- **PRL 结算总费用仅 1%。** 我们抽水 1%，HeroMiners 不收矿池费。抽水过程全程可见。
- **想要什么币就付什么币。** 可以把 Pearl 直接挖到你自己的钱包，也可以通过 Kryptex 收 Bitcoin/USDT/USDC，或通过 unMineable 收 Bitcoin、Litecoin、Dogecoin、Solana 以及另外约 25 种币。
- **收益一目了然。** 以你的货币显示每日收益；填入电价后还能显示扣除电费后的利润。
- **保护你的硬件。** 每张显卡的温度都对照它自己的安全上限进行监控，上限直接从显卡读取。温度偏高的显卡会自动降低功耗，接近上限的显卡会暂停，冷却后再继续。
- **想从显卡榨出更多，也可以。** 可选的[自动调校](docs/auto-tune.zh-CN.md)会在挖矿时为你的显卡找到最佳稳定设置：更高的算力，或以明显更低的功耗保持同样算力。
- **开了就不用管。** 看门狗、自动切换备用矿池、加密的矿池连接，需要你处理时给出通俗易懂的提示。随时随地都能用[手机](docs/phone-access.zh-CN.md)查看。

<p align="center">
  <img src="images/phone-home.jpg" width="260" alt="手机上的面板：运行状态、每日利润和调优结果">
  &nbsp;&nbsp;
  <img src="images/phone-tuned.jpg" width="260" alt="自动调校后的显卡：比出厂高 6.3% 的算力，功耗更低">
</p>
<p align="center"><sub>手机上的面板：收益一目了然，以及自动调校后的显卡。</sub></p>

---

## 三步开始挖矿

你需要一张 **NVIDIA RTX 30、40 或 50 系列显卡**（并安装较新的驱动），以及**一个收款的地方**：

| 你有 | 收到的币 | 在 1% 开发者抽水之外的费用 |
|---|---|---|
| **Pearl 地址**（`prl1…`，在 Pearl 钱包 App 中免费获取） | PRL，通过 HeroMiners | **无**（最划算） |
| 同一个 Pearl 地址，改用 Kryptex | PRL，每个份额都付费，满 1 PRL 起付 | 2% |
| **Kryptex 账户**（`krx…`，在 pool.kryptex.com 免费注册） | BTC，可提现为 BTC、USDT 或 USDC | 2% |
| **其他币**的地址（BTC、LTC、DOGE、SOL 等） | 该币种，通过 unMineable | 1% |

**1. 下载**：从[最新版本](../../releases/latest)页面下载适合你电脑的文件：`…-windows.zip`、`…-linux.tar.gz`，HiveOS 矿机则下载 `…-hiveos.tar.gz`。

**2. 解压并运行** `glint.exe`（Linux：`./glint`）。如果 Windows 提示 *“Windows 已保护你的电脑”*，点击 **更多信息 → 仍要运行**；对于下载量还不多的新程序，Windows 都会这样提示。

**3. 回答几个问题。** 每个问题都用数字回答：输入数字并按 Enter。如果你已经复制了地址，GlintMiner 会在剪贴板里找到它。之后它就开始挖矿，并记住你的回答，下次直接使用。

你的面板地址是 **http://127.0.0.1:4078**：运行是否正常、赚了多少、显卡调优情况以及什么时候到账。完整的操作说明，包括每个设置问题和支付方式的介绍，请看 **[入门指南](docs/getting-started.zh-CN.md)**。

> **提示：** 让它一直运行。矿池按稳定的工作量付费，全天候运行的显卡比每晚开开关关的显卡赚得多得多。

## 文档

| 指南 | 内容 |
|---|---|
| **[入门指南](docs/getting-started.zh-CN.md)** | 选择收款方式、逐步设置、什么时候到账、更新与卸载 |
| **[面板](docs/dashboard.zh-CN.md)** | 逐一介绍每个页面：首页、收益、矿机和设置 |
| **[自动调校](docs/auto-tune.zh-CN.md)** | 四种模式、如何调出最佳结果、调校期间会发生什么、如何保护你的显卡 |
| **[手机查看](docs/phone-access.zh-CN.md)** | 用手机查看矿机，在家或通过 Tailscale 随时随地 |
| **[矿机用户与进阶用户](docs/advanced.zh-CN.md)** | 全部命令行参数、多显卡与多台矿机、矿池、HiveOS、MMPOS、Docker、systemd、统计 API |
| **[常见问题与故障排除](docs/faq.zh-CN.md)** | 常见问题、常见故障的解决方法、校验下载文件、获取帮助 |
| **平台常见问题：** [Windows](docs/faq-windows.zh-CN.md) · [Linux](docs/faq-linux.zh-CN.md) · [HiveOS](docs/faq-hiveos.zh-CN.md) · [MMPOS](docs/faq-mmpos.zh-CN.md) · [Docker](docs/faq-docker.zh-CN.md) | 各平台的解答：开机启动或作为服务运行、所需的权限、在该平台上使用自动调校、日志、更新与移除 |
| **[HiveOS](hiveos/README.md)** · **[MMPOS](mmpos/README.md)** · **[Docker](docker/README.md)** | 在各平台上设置 GlintMiner |
| **[更新日志](CHANGELOG.md)** | 每个版本的变化 |

## 1% 开发者抽水，公开透明

- 每张显卡大约每一百秒中有一秒为开发者挖矿。矿池看到的算力是平稳的，不会像某些矿工软件那样出现长达一分钟的空档。
- 控制台和面板会显示抽水比例和目前为止实际抽取的数量。除此之外，绝不收取任何费用。
- 如果抽水服务器无法连接，你照常挖矿。错过的部分之后会慢慢补上，最多约一小时的量。
- 抽水份额带有一个匿名标签：显卡型号与数量、结算方式、GlintMiner 版本以及显卡是否已调校（例如 `g4687ad-hmv125s-4090x1`），让开发者了解 GlintMiner 的使用情况。绝不包含你的钱包、矿机名、IP 地址或位置。

## 值得信赖

- **每个份额在提交前都会在你的电脑上**用 Pearl 官方校验器验证。如果 Pearl 网络规则变更，GlintMiner 会停下来提示你更新，而不是继续提交会被拒绝的份额。
- **默认使用出厂设置，除非你另行选择。** 默认情况下 GlintMiner 从不改动频率、电压或风扇，只会在显卡过热时调低功耗上限。只有你开启自动调校后，它才会调整频率；GlintMiner 所做的一切更改都会在关闭时恢复，或在崩溃后的下一次启动时恢复。
- **没有意外。** 有新版本时它会提醒你，但绝不会自行下载或安装任何东西。
- **设置掌握在你手中，** 都保存在程序旁边的 `glint.json` 中。不会在其他地方安装任何东西。
- **每个文件都有校验值。** 对照 `SHA256SUMS.txt` [校验下载文件](docs/faq.zh-CN.md#校验下载文件)。

## 系统要求

- NVIDIA RTX 30 系列或更新（计算能力 8.0+），并安装最新的 NVIDIA 驱动
- Windows 10/11 64 位，或 Linux x86-64（glibc 2.17+）；支持 HiveOS、MMPOS 和 Docker
- 每张显卡约需 1.5 GB 系统内存
- 无需安装其他任何东西：不需要 CUDA Toolkit 或运行库
- 自动调校需要管理员（Windows）或 root（Linux）权限。没有这些权限时，GlintMiner 会以出厂设置正常挖矿

## 支持

发现 bug 或有建议？请提交 [issue](../../issues)，附上显卡型号、驱动版本、`glint --self-test` 的输出以及 `glint.log` 中的相关内容。更多信息见[获取帮助](docs/faq.zh-CN.md#获取帮助)。

## 许可

GlintMiner 可免费用于个人和商业挖矿。程序为闭源软件。详见 [LICENSE.txt](LICENSE.txt)，以及列出所用开源组件的 `THIRD_PARTY_NOTICES.txt`。
