# Windows 上的 GlintMiner：常见问题

[← 返回 FAQ](faq.zh-CN.md) · [English](faq-windows.md) · [Русский](faq-windows.ru.md) · **简体中文**

在 Windows 10 或 11 上用 GlintMiner 挖矿时常见的问题，按 GlintMiner 目前的实际工作方式解答。

- [安装与首次运行](#安装与首次运行)
- [运行](#运行)
- [管理员权限](#管理员权限)
- [Windows 上的自动调校](#windows-上的自动调校)
- [温度与功耗](#温度与功耗)
- [面板与手机](#面板与手机)
- [日志](#日志)
- [更新与卸载](#更新与卸载)
- [多张显卡](#多张显卡)
- [提示信息及其含义](#提示信息及其含义)
- [获得最佳算力](#获得最佳算力)

---

## 安装与首次运行

**下载哪个文件？** [最新版本](https://github.com/MaccaDaStaka/GlintMiner/releases/latest)页面中的 `glint-…-windows.zip`。其中包含 `glint.exe`、README、这些指南、更新日志和许可证文件。没有安装程序：解压后运行 `glint.exe` 即可。

**应该解压到哪里？** 解压到一个单独的、你的 Windows 账户有写入权限的文件夹，例如 `C:\GlintMiner`。GlintMiner 把所有东西都放在 `glint.exe` 旁边：你的设置（`glint.json`）、日志（`glint.log`）、图表所用的历史记录（`glint-history.jsonl`）和基准测试结果。`C:\Program Files` 这样的文件夹不合适，因为正常启动的程序无法在那里写入。

**需要安装 CUDA 或其他东西吗？** 不需要。GlintMiner 使用你已经安装的 NVIDIA 驱动。你需要 Windows 10 或 11（64 位）、一张 RTX 30、40 或 50 系列显卡，以及较新的驱动：550 或更新，RTX 50 显卡需要 580 或更新。

**Windows 提示“Windows 已保护你的电脑”，有问题吗？** 没有问题。Windows SmartScreen 会对还没有被广泛下载的新程序显示这个提示。点击 **更多信息**，然后点击 **仍要运行**。只需操作一次。

**杀毒软件删除或阻止了 `glint.exe`。** 杀毒软件会把加密货币挖矿软件整类标记，包括正版的。先确认你的文件是正版的（[校验下载文件](faq.zh-CN.md#校验下载文件)），然后在杀毒软件中允许它；如果文件已被删除，请重新解压。

**设置程序是怎么知道我的地址、矿机名和货币的？** 它读取剪贴板中的文字，只有当它是你所选收款方式的有效地址时才会建议使用（不会从剪贴板获取其他任何内容）。它建议的矿机名是你电脑的名称，货币来自 Windows 的区域设置。这些都可以在设置时更改，之后也可以在面板的 **设置** 中更改。

**窗口显示了一条错误和 “Press Enter to close.”（按回车键关闭）。** GlintMiner 无法继续运行时，会打印原因并等待你按回车键，这样窗口不会在你看清之前就消失。常见原因和解决方法见[提示信息及其含义](#提示信息及其含义)。

## 运行

**如何停止 GlintMiner？** 关闭它的窗口或按 **Ctrl+C**。它对显卡所做的一切更改（它调低的功耗上限，以及使用自动调校时的频率）都会在关闭时恢复。如果是 Windows 替你关闭它（注销或关机），GlintMiner 也会利用 Windows 给出的几秒钟把显卡恢复原样。

**如果在任务管理器中（或用 `taskkill /F`）结束它会怎样？** 它没有机会收尾，所以下次启动时会先处理：在任何显卡开始挖矿之前，被自动调校改动过的显卡会被恢复，日志会显示 *auto-tune: GlintMiner didn't close cleanly last time; 1 card(s) put back to stock*（上次没有正常关闭，已将 1 张显卡恢复为出厂设置）。仅由温度保护调低的功耗上限不在这份记录中，所以可能要到电脑重启后才会恢复原值。正常关闭窗口可以避免这两种情况。

**在那之前，调校设置会一直留在显卡上。** 用任务管理器结束 GlintMiner 后，不要玩游戏或运行其他高负载的显卡程序：为挖矿调校的设置（尤其是让显卡以最低电压运行的*最凉最静*）可能导致游戏崩溃或黑屏。请先重新启动 GlintMiner 再正常关闭它，或者重启电脑。**要玩游戏，可以让 GlintMiner 继续运行（它会自动暂停，见下文），或用窗口的 X 或 Ctrl+C 关闭它。**

**GlintMiner 运行时可以玩游戏吗？** 可以。开启 **玩游戏时暂停**（默认开启）后，游戏使用显卡时挖矿会在约 10 秒内停止，显卡恢复出厂设置：游戏可以使用整张显卡，也绝不会在挖矿调校下运行。退出游戏一分钟后（或游戏最小化期间），挖矿继续，调校结果恢复。首页会显示 **游戏中，挖矿已暂停** 以及游戏名称。GlintMiner 根据程序对显卡图形引擎的使用程度（即任务管理器显示的那些数字）区分游戏和日常使用，所以桌面、浏览器或视频不会触发暂停。其他高负载程序也会触发（3D 编辑软件、其他挖矿程序）：在首页点 **不因 … 暂停** 放过某个程序，或在 **设置 → 游戏与计划** 中编辑列表或关闭此功能。命令行用 `--no-game-pause` 关闭。需要 Windows 10（1709 或更新）和 11 自带的 GPU 使用计数器。

**能在夜里换一种方式挖矿，或在用电高峰不挖吗？** 可以：**设置 → 游戏与计划 → 使用计划**。选择时段和每个时段的模式（夜里「最凉最静」、电价高峰暂停等）。显卡只会切换到已经调校过的模式，所以计划绝不会启动调校。见[计划](auto-tune.zh-CN.md#计划)。

**GlintMiner 能在 Windows 启动时自动运行吗？** GlintMiner 没有开机自启设置，也不会安装任何东西，所以需要你在 Windows 中设置：

- **不使用自动调校：** 在启动文件夹中放一个 `glint.exe` 的快捷方式（按 Win+R，输入 `shell:startup`，按回车）。
- **使用自动调校：** 调校需要管理员权限，而普通的启动文件夹快捷方式没有这个权限。每次在没有管理员权限的情况下启动时，GlintMiner 都会询问 *Tuning is on, but it needs administrator rights. Restart GlintMiner as administrator now?*（调校已开启，但需要管理员权限。现在以管理员身份重启 GlintMiner 吗？）。无人回答时，它会等待一分钟，然后以出厂设置挖矿（*No answer: mining at stock this time*），显卡不会被调校。要让它启动时就处于调校状态，请在任务计划程序中创建一个在登录时运行 `glint.exe` 的任务，并勾选 **使用最高权限运行**。

**能作为 Windows 服务运行或在后台隐藏运行吗？** 不能。GlintMiner 没有 Windows 服务模式，它在自己的控制台窗口中运行。不想看到它的话，把窗口最小化即可。（在 Linux 上它可以作为服务运行，见 [Linux 常见问题](faq-linux.zh-CN.md)。）

**为什么控制台中的时间和我的时钟不一样？** 控制台中的时间（`[14:02:37]`）是 UTC 时间，不是你的本地时间。

**实时表格在我的控制台窗口中显示不正常。** 在较老的控制台窗口中，GlintMiner 会不带颜色地绘制表格。如果仍然显示不正常，请开启 **设置 → 控制台和日志 → 简洁控制台**（或用 `--plain` 启动）并重启 GlintMiner：之后会显示普通的日志行，而不是表格。

## 管理员权限

**必须以管理员身份运行吗？** 不必。没有管理员权限也能照常挖矿。只有更改显卡的设置时才需要管理员权限：

- 显卡过热时调低它的功耗上限，
- 使用利润模式（**设置 → 温度和功耗 → 利润模式**），
- 使用[自动调校](auto-tune.zh-CN.md)。

*紧急暂停*（在显卡接近关机温度时暂停它）不需要管理员权限也能工作。

**如何以管理员身份运行？** 右键点击 `glint.exe`，选择 **以管理员身份运行**。也可以让 GlintMiner 来做：调校已开启而它没有以管理员身份运行时，设置程序（以及之后的每次启动）会询问 *Restart GlintMiner as administrator now?*（现在以管理员身份重启 GlintMiner 吗？）。选择 **1**，在 Windows 询问时允许，GlintMiner 就会以管理员身份在新窗口中重新打开，旧窗口随之关闭。选择 **2**，这次就以出厂设置挖矿；一分钟无人回答时也是如此。如果你拒绝了 Windows 的请求，它会显示 *Not restarted (the request was declined): mining at stock. Tuning starts when you run GlintMiner as administrator.*（未重启，请求被拒绝：以出厂设置挖矿。以管理员身份运行 GlintMiner 后调校就会开始。）

**面板显示“调优还无法开始”。** 调校已开启，但 GlintMiner 没有以管理员身份运行。在此期间你的显卡以出厂设置挖矿，这完全没问题。关闭 GlintMiner，右键点击它，选择 **以管理员身份运行**，调校就会自动开始。

## Windows 上的自动调校

完整指南见[自动调校](auto-tune.zh-CN.md)。以下是 Windows 特有的部分。

**哪些程序会让调校无法开始？** 只要以下程序之一在运行，调校就不会开始：MSI Afterburner、EVGA Precision X1、ASUS GPU Tweak、GIGABYTE AORUS Engine、GIGABYTE Graphics Engine、ZOTAC FireStorm、Palit ThunderMaster 和 GALAX Xtreme Tuner。它们随时可能应用自己的频率设置，这会破坏调校的测量。显卡会继续以出厂设置挖矿，面板、控制台和日志会告诉你要关闭哪个程序，例如 *MSI Afterburner is running. Close it (and turn off its 'apply overclocking at startup'), then tuning starts by itself.*（MSI Afterburner 正在运行。关闭它，并关掉它的“启动时应用超频”，调校就会自动开始。）GlintMiner 每分钟检查一次。

**如果在某张显卡调校期间打开 MSI Afterburner 会怎样？** 这张显卡会恢复出厂设置，程序关闭后继续调校。已经完成调校的显卡会继续用它的调校结果挖矿。

**RivaTuner 的屏幕显示有影响吗？** 没有。RivaTuner Statistics Server 本身不会改动频率，GlintMiner 不会管它。

**我确实想在调校时开着我的工具。** 用 `--tune-ignore-tools` 启动 GlintMiner（或在 `glint.json` 中设置 `"tune_ignore_tools": true`）。只有在你确定这个工具不会在调校期间改动显卡频率时才这样做。

**我已经给显卡超频了（在 MSI Afterburner 或 NVIDIA App 中），会怎样？** 调校之前，GlintMiner 会把显卡恢复为出厂设置，让调校从真正的出厂状态开始，日志会显示 *Your card had its own overclock; tuning starts from factory settings and puts yours back when GlintMiner closes.*（你的显卡有自己的超频设置；调校从出厂设置开始，GlintMiner 关闭时会恢复你的设置。）你自己的设置会在 GlintMiner 关闭时恢复，崩溃后则在下次启动时恢复。为获得最佳结果，还请关闭 NVIDIA App 的自动调优（[开始之前](auto-tune.zh-CN.md#开始之前)）。

**调校时屏幕黑了一下（或驱动重置了）。** 这是调校在寻找显卡的极限。GlintMiner 会记录 *a GPU stopped responding; restarting GlintMiner*（某张显卡停止响应，正在重启 GlintMiner），自行重新启动，把显卡恢复到安全的设置并继续。这时它不会再打开一个浏览器标签页。如果某个调校结果应用后不久整台电脑死机或崩溃，下次启动时会使用更稳妥的设置。

**调校时可以玩游戏吗？** 请不要这样做。调校测量的差异大约只有 1%，所以游戏、视频、本地 AI 应用和动态壁纸都会让结果变差。让电脑保持空闲，最好在夜间进行。显卡调校完成后，你就可以照常使用电脑了。

**显示“这张显卡的厂商不允许调优（笔记本电脑常见）”。** 有些显卡（其中包括许多笔记本电脑）几乎不允许做任何改动。这张显卡会以出厂设置挖矿，GlintMiner 不会尝试调校它。

## 温度与功耗

**GlintMiner 如何让显卡保持凉爽？** 它一直监控每张显卡的温度。超过显卡的上限时，它会调低功耗上限（这需要管理员权限）。接近显卡的关机温度时，它会暂停这张显卡直到冷却，即使没有管理员权限也会这样做。上限默认从显卡读取；你可以在 **设置 → 温度和功耗** 中自行设置。详见[温度上限](auto-tune.zh-CN.md#温度上限)。

**日志说功耗上限 “cannot be changed”（无法更改）。** 完整的一行是 *GPU 0: 84 C is over the 80 C limit, but the power limit cannot be changed. Run GlintMiner as administrator to let it manage temperature.*（GPU 0：84 °C 超过了 80 °C 的上限，但功耗上限无法更改。以管理员身份运行 GlintMiner，让它来管理温度。）你的显卡很热，而 GlintMiner 没有被允许降低它的功耗。以管理员身份运行它，或改善通风。

**GlintMiner 会控制我的风扇吗？** 不会。它从不改动风扇转速；由你的显卡或你用来控制风扇的工具负责。如果某张显卡风扇已达 100% 仍然很热，日志会提示 *check airflow and dust*（检查通风和灰尘）。

## 面板与手机

**面板在哪里？** GlintMiner 运行时，在浏览器中打开 **http://127.0.0.1:4078**。可以让它在每次启动时自动打开：**设置 → 面板 → GlintMiner 启动时打开此面板**。完整介绍见[面板](dashboard.zh-CN.md)。

**如何用手机查看？** **设置 → 面板 → 谁可以打开** → *其他设备*，保存，然后重启 GlintMiner。Windows 询问防火墙时，只允许 **专用网络**。之后其他设备就可以查看，但不能更改任何内容。要通过 Tailscale 随时随地查看（包括需要添加的防火墙规则），见[手机查看](phone-access.zh-CN.md)。

**控制台显示 “The dashboard and stats API couldn't start”（面板和统计 API 无法启动）。** 完整的提示会告诉你原因，例如 *port 4078 is already in use (another miner, or a second GlintMiner?)*（端口 4078 已被占用：另一个挖矿软件，还是第二个 GlintMiner？）。挖矿会继续，只是没有面板。关闭那个程序，或用 `--api-port 4079` 换一个端口（或 **设置 → 面板 → 端口**，然后重启）。

**面板只显示一个单词 “forbidden”。** 你是用含有点号的名称打开的，例如 `http://my-pc.lan:4078`。为了保护你免受恶意网页的攻击，GlintMiner 只响应 IP 地址（`http://192.168.1.20:4078`）、不带点号的电脑名（`http://my-pc:4078`）、`.local` 名称，或以 `.ts.net` 结尾的 Tailscale 名称。

## 日志

**日志在哪里？** 在 `glint.exe` 旁边的 `glint.log` 中。每一行以 Unix 时间戳（从 1970 年起的秒数）开头，后面是消息。文件超过 8 MB 后，GlintMiner 会在下次启动时重新开始写一个新文件。最有用的几行也会显示在面板的 **矿机 → 最近事件** 中。

**日志里有哪些屏幕上没有的内容？** 技术细节。控制台和面板用一句简短的话说明发生了什么、该怎么做；背后的网址、Windows 错误代码和错误细节只写入 `glint.log`。

**求助时如何分享我的日志？** 用记事本打开 `glint.log`，复制问题前后的几行，连同 `glint --self-test` 的输出一起附在你的 [issue](faq.zh-CN.md#获取帮助) 中。如果你不想公开钱包地址，请先把它删掉。

**可以关闭日志吗？** 可以：**设置 → 控制台和日志 → 写入日志文件**，或用 `--no-log-file` 启动。

## 更新与卸载

**我怎么知道有新版本？** GlintMiner 在启动时和每天一次检查 GitHub。有更新的版本时，控制台和面板会提示你，原文为 *A newer GlintMiner (…) is available at https://github.com/MaccaDaStaka/GlintMiner/releases*。它绝不会自行下载或安装任何东西。

**如何更新？** 关闭 GlintMiner，把新的 `glint-…-windows.zip` 解压到同一个文件夹（替换文件），然后重新启动 `glint.exe`。你的设置、已保存的调校结果和历史记录不在压缩包里，所以会保留。详见[更新](getting-started.zh-CN.md#更新)。

**如何卸载？** 关闭它，然后删除它的文件夹。GlintMiner 不会创建服务、注册表项或后台程序。如果你为它创建过启动快捷方式、任务计划程序任务或防火墙规则，也请一并删除。

## 多张显卡

**它会使用我所有的显卡吗？** 会，所有受支持的 NVIDIA 显卡都会使用，型号可以混搭。要自行选择，使用 **设置 → 挖矿 → 使用的显卡** 或 `--devices 0,2`。详见[多显卡与多台矿机](advanced.zh-CN.md#多显卡与多台矿机)。

**哪张显卡是 “GPU 1”？** `glint --gpu-info` 会列出每张显卡在 GlintMiner 中的编号、名称和 PCI 总线地址。在装有不同显卡的电脑上，这些编号可能与其他工具显示的不同，所以在使用 `--devices` 或 `--tune-card` 之前先在这里核对。

**需要多少内存？** 每张显卡约需 1.5 GB 系统内存（RAM）。

## 提示信息及其含义

| 你看到的提示 | 含义 | 该怎么做 |
|---|---|---|
| *No NVIDIA driver was found. Install the current GeForce driver from nvidia.com and start again.* | 缺少 NVIDIA 驱动 | 安装最新驱动 |
| *No NVIDIA GPU was found. GlintMiner needs an RTX 30-series or newer card.* | Windows 找不到 GlintMiner 能用的 NVIDIA 显卡 | 检查显卡和驱动；运行 `glint --gpu-info` |
| *Your NVIDIA driver is too old for this GPU. Update to driver 550 or newer (580+ for RTX 50) and start again.* | 驱动比你的显卡或 GlintMiner 更旧 | 更新驱动 |
| *…is not supported: Pearl mining needs an RTX 30-series or newer* | 这张显卡太旧（GTX、RTX 20） | 跳过这张显卡；其他显卡照常挖矿 |
| *The GPU ran out of memory. Close other GPU programs (games, other miners) and start again.* | 有其他程序在占用显卡的显存 | 关闭它，然后重新启动 |
| *Can't look up … — check this PC's internet or DNS settings.* | 无法解析矿池的域名 | 检查电脑的网络连接 |
| *Couldn't set up a secure connection to …; check this PC's date and time, and any antivirus or firewall that inspects traffic.* | 这台电脑上的加密连接被拒绝 | 校正时钟；在扫描网络连接的软件中允许 GlintMiner |
| *The pool is not accepting our work (…). Pearl's rules may have changed (a network upgrade): this version needs an update.* | GlintMiner 停了下来，而不是继续发送会被拒绝的工作 | [更新](#更新与卸载) |
| *…glint.json is not valid (delete it to run the setup again)* | 设置文件已损坏 | 删除 `glint.json`，重新进行设置 |
| *Tuning needs a newer NVIDIA driver: update it and start GlintMiner again.* | 驱动没有提供调校所需的控制功能 | 更新驱动；在此期间显卡以出厂设置挖矿 |

更多内容，包括每一条自动调校提示，见[提示信息的含义](auto-tune.zh-CN.md#提示信息的含义)和[故障排除表](faq.zh-CN.md#故障排除)。

## 获得最佳算力

**我的算力比预期低。** 关闭其他占用显卡的程序：游戏、视频和动态壁纸、正在播放视频的浏览器标签页、本地 AI 应用和其他挖矿软件。在面板上查看显卡温度；接近上限的显卡会跑得更慢。开着的面板标签页没有影响：它放在那里时不占用任何资源。

**CPU 很忙有影响吗？** 有一点。每个结果在发送前都会在你的电脑上用 Pearl 官方校验器检查，电脑非常忙时检查会变慢。显卡调校期间影响更大：调校可能以 *The computer was too busy to make sure this card is stable, so it stays at stock.*（电脑太忙，无法确认这张显卡是否稳定，所以它保持出厂设置。）结束。请在运行较少程序时再试一次。

**应该让它一直运行吗？** 是的。矿池按稳定的工作量付费，全天候挖矿的显卡比每晚开开关关的显卡赚得多得多。
