# 用手机查看矿机

[← 返回 README](../README.zh-CN.md) · [English](phone-access.md) · [Русский](phone-access.ru.md) · **简体中文**

面板运行在你的挖矿电脑上。你也可以在手机或笔记本电脑上打开它，在家或随时随地都行，而且不必把电脑暴露在互联网上。

- [在家，同一个 Wi-Fi](#在家同一个-wi-fi)
- [随时随地，使用 Tailscale](#随时随地使用-tailscale)
- [仅查看，以及允许更改](#仅查看以及允许更改)
- [无显示器矿机（HiveOS、MMPOS、Linux）](#无显示器矿机hiveosmmposlinux)
- [打不开时](#打不开时)
- [其他查看方式](#其他查看方式)

---

## 在家，同一个 Wi-Fi

1. 在挖矿电脑上打开面板，进入 **设置 → 面板 → 谁可以打开**。选择 **其他设备，例如在家或通过 Tailscale 使用的手机（仅查看）**，保存后重启 GlintMiner。
2. 页面随后会显示要打开的地址，例如 `http://192.168.1.20:4078`。在手机上打开这个地址。
3. 如果 GlintMiner 启动时 Windows 询问防火墙设置，只允许 **专用网络**。不要勾选 **公用网络**。

## 随时随地，使用 Tailscale

[Tailscale](https://tailscale.com)（个人使用免费）把你自己的设备连成一个私有网络。这样你的手机在任何地方都能访问你的电脑，无论是用移动数据还是别人的 Wi-Fi，而且不会向互联网的其他部分开放任何东西。

1. **安装 Tailscale**：在挖矿电脑和手机上都安装，并在两边登录**同一个账号**。
2. **允许其他设备打开面板：** 在挖矿电脑上，**设置 → 面板 → 谁可以打开** → **其他设备，例如在家或通过 Tailscale 使用的手机（仅查看）**。保存后重启 GlintMiner。
3. **在防火墙中只为 Tailscale 放行面板。**
   - **Windows：** 以管理员身份打开 PowerShell（右键点击“开始”→ *终端(管理员)*）并运行：
     ```
     New-NetFirewallRule -DisplayName "GlintMiner dashboard (Tailscale)" -Direction Inbound -Protocol TCP -LocalPort 4078 -RemoteAddress 100.64.0.0/10 -Action Allow
     ```
     这只会放行你自己 Tailscale 网络中的设备（它们的地址以 `100.` 开头）。
   - **Linux / HiveOS：** Tailscale 通常会自行处理。如果你使用 ufw：`ufw allow in on tailscale0 to any port 4078`。
4. **在手机上打开：** `http://100.x.y.z:4078`，其中 `100.x.y.z` 是电脑的 Tailscale 地址（在 Tailscale 应用中可以看到）。也可以用 `http://your-pc-name:4078`，或完整名称 `your-pc-name.your-tailnet.ts.net`。
5. **提示：** 把它添加到手机主屏幕（在浏览器菜单中选择*添加到主屏幕*），打开时就像一个 App。

> **切勿在路由器上转发 4078 端口。** 那样整个互联网都能打开你的面板。Tailscale 能以私密的方式给你同样的访问能力。

## 仅查看，以及允许更改

从挖矿电脑以外的任何设备打开时，面板都**仅可查看**：你能看到所有内容，但不能更改设置，也不能开始或暂停调校。页面顶部会注明。更改需在挖矿电脑上进行。

如果也想允许从其他设备更改，请用 `--api-allow-remote-control` 启动 GlintMiner。只在你信任的网络中这样做（你自己的 Tailscale 网络就是一个）。之后其他设备会要求输入一次远程控制码：GlintMiner 启动时会打印它，挖矿电脑控制面板的“设置”中也会显示。要生成新代码，请从 `glint.json` 中删除 `api_remote_code` 并重启。通过挖矿电脑上的代理（`tailscale serve`、nginx）打开的页面也算作其他设备，同样需要代码。

## 无显示器矿机（HiveOS、MMPOS、Linux）

没有显示器的矿机没有浏览器。用 `--api-bind 0.0.0.0` 启动 GlintMiner（在 HiveOS 上：填在 *Extra config arguments* 中），然后在你网络中的任意电脑上打开 `http://<rig-ip>:4078`，或在任何地方打开矿机的 Tailscale 地址。

## 打不开时

- **GlintMiner 在电脑上运行了吗？** 更改*谁可以打开*之后重启了吗？
- **地址对吗？** 使用面板设置页面上显示的地址，或 Tailscale 地址。除非你改过，端口都是 `4078`。
- **防火墙：** 在 Windows 上，检查上面的规则是否存在（Windows Defender 防火墙 → 入站规则），并确认 GlintMiner 在专用网络中没有被阻止。
- **Tailscale：** 两台设备上都已连接、并登录了同一个账号吗？试试在 Tailscale 应用中 ping 这台电脑。
- **开着 Tailscale 时手机上网变慢？** 这通常是 Tailscale 应用中选择了*出口节点* （所有流量都会经过另一台设备）。访问你的电脑不需要出口节点：把出口节点设为*无*。

## 其他查看方式

- **Telegram 提醒：** 显卡停止或矿池断开时收到消息。用 @BotFather 创建一个机器人，然后在 **设置 → Telegram 提醒** 中填入机器人令牌和你的聊天 ID（或使用 `--telegram-token` 和 `--telegram-chat`）。
- **矿池网站：** 搜索你的钱包地址，即可看到矿池看到的算力和余额（这些数据会滞后 10–30 分钟）。
