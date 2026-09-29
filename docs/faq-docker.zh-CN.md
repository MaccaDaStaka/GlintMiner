# Docker 中的 GlintMiner：常见问题

[← 返回 FAQ](faq.zh-CN.md) · [English](faq-docker.md) · [Русский](faq-docker.ru.md) · **简体中文**

在 Docker 容器中运行 GlintMiner 时常见的问题，按 GlintMiner 及其 `Dockerfile` 目前的实际工作方式解答。简要设置见 [Docker 指南](../docker/README.md)。

- [设置](#设置)
- [参数与设置](#参数与设置)
- [运行、停止与重启](#运行停止与重启)
- [面板](#面板)
- [自动调校与功耗上限](#自动调校与功耗上限)
- [日志与更新](#日志与更新)

---

## 设置

**宿主机需要什么？** NVIDIA 驱动（550 或更新，RTX 50 显卡需要 580 或更新）和 [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)，这样 `docker run --gpus all` 才能把显卡交给容器。

**从哪里获取 `Dockerfile`？** 它在 Linux 版本 `glint-…-linux.tar.gz` 的 `docker/` 文件夹中。把同一版本中的 `glint` 程序放在它旁边，然后构建并运行：

```
docker build -t glint .
docker run -d --restart unless-stopped --gpus all -p 127.0.0.1:4078:4078 glint --wallet prl1... --worker rig1
```

**镜像里有什么？** Ubuntu 22.04 及其 `ca-certificates` 软件包，以及 `glint` 程序。镜像会向 NVIDIA 运行时请求驱动的计算库和管理库，GlintMiner 挖矿以及读取温度和功耗都需要它们。

**它会进行设置问答吗？** 不会，请在命令行中用 `--wallet` 提供你的钱包。用 `-d` 启动的容器没有终端，没有钱包时 GlintMiner 会停止并提示 *no wallet configured: run glint in a terminal for the setup, or pass --wallet ADDRESS*（未配置钱包：请在终端中运行 glint 进行设置，或传入 --wallet ADDRESS）。

## 参数与设置

**哪些参数在镜像中是固定的？** 镜像总是用以下参数启动 GlintMiner：

```
--plain --no-log-file --config /glint/glint.json --api-bind 0.0.0.0 --api-allow-remote-control
```

在镜像名后面重复其中某个参数不会改变它：GlintMiner 使用它找到的第一个，而镜像的参数排在前面。

**可以添加哪些参数？** 其他所有参数，写在镜像名后面：`--wallet`、`--worker`、`--pool`、`--devices`、`--kwh-price`、`--currency`、`--tune` 和其他调校参数、`--telegram-token` 和 `--telegram-chat`、`--share-diff`。完整列表见[全部参数](advanced.zh-CN.md#全部参数)。

**我的设置保存在哪里，会保留吗？** 在容器内的 `/glint/glint.json` 中，已保存的调校结果和面板图表所用的历史记录也在它旁边。容器停止后再启动，它们都会保留。容器被删除时（例如为了更新到新镜像），它们就会丢失。所以请把想保留的一切都写在 `docker run` 命令行中；在面板上所做的更改只在那个容器存在期间有效。

## 运行、停止与重启

**为什么要用 `--restart unless-stopped`？** 当某张显卡停止响应时（自动调校测试显卡极限时可能发生），GlintMiner 会重启自己：启动一个新的副本，旧的退出。在容器中，旧的那个是容器的主进程，所以它退出时容器也会结束，而把它重新拉起来的正是 Docker 的重启策略。

**如何正常停止？** `docker stop <container>`。GlintMiner 收到停止信号后，会在退出前恢复它对显卡所做的一切更改。

**如果容器被强行结束会怎样？** 如果再次启动同一个容器，GlintMiner 会在挖矿之前恢复调校改动过的设置。如果容器被删除，这份记录也随之消失，重启宿主机即可清除 GlintMiner 所做的更改。

**如何选择它使用哪些显卡？** `--gpus all` 会把所有显卡交给容器，GlintMiner 会在所有显卡上挖矿。在镜像名后面加上 `--devices 0,2`，只在其中一部分显卡上挖矿。

## 面板

**面板在哪里？** 在宿主机上打开 **http://127.0.0.1:4078**。在容器中，它不会自动在浏览器中打开。

**为什么 `-p` 中必须保留 `127.0.0.1:`？** 在容器内部，每个请求都来自 Docker 的网络，而不是来自机器本身，所以镜像允许从任何地方更改（`--api-allow-remote-control`）。使用 `-p 127.0.0.1:4078:4078` 时，只有宿主机能访问这个页面。把端口发布到你的网络，会让网络中的每台设备都能更改你的设置和调校。

**宿主机上可以用其他端口吗？** 可以，更改 `-p` 中宿主机一侧的端口，例如 `-p 127.0.0.1:5000:4078`，然后打开 `http://127.0.0.1:5000`。

**页面只显示一个单词 “forbidden”。** 请用 `http://127.0.0.1:4078`（或 `http://localhost:4078`）打开。GlintMiner 会拒绝其他域名下的名称，以保护你免受恶意网页的攻击。

## 自动调校与功耗上限

**GlintMiner 能在容器中调校或更改功耗上限吗？** 它在容器内以 root 身份运行，所以会尝试。NVIDIA 驱动是否允许容器更改功耗上限和频率，取决于你的宿主机是如何设置的。如果被拒绝，GlintMiner 会提示（*Tuning needs administrator rights: …* 或 *the power limit cannot be changed*），显卡以出厂设置挖矿。挖矿本身不受影响。

**如何开启自动调校？** 在镜像名后面加上 `--tune speed --confirm-tuning`（也可用 `efficiency`、`cool`，或 `profit` 加上 `--kwh-price`）。请先阅读[自动调校](auto-tune.zh-CN.md)。因为已保存的调校结果会随容器一起丢失，新容器会从出厂设置重新调校。

## 日志与更新

**日志在哪里？** `docker logs <container>`。镜像传入了 `--no-log-file`，所以没有 `glint.log`；错误的技术细节在同一行中，放在那句简短说明后面的方括号里。时间为 UTC 时间。

**如何更新？** 把新版本的 `glint` 放到 `Dockerfile` 旁边，重新构建镜像，然后删除旧容器，用同样的 `docker run` 命令启动一个新容器。只在面板上设置过的内容不会保留（见[上文](#参数与设置)）。有新版本时 GlintMiner 会在日志中提示；它绝不会自行更新。
