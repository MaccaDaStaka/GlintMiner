# GlintMiner in Docker

Needs an NVIDIA driver and the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) on the host.

Put the Linux `glint` binary from the [Releases](../../../releases) page next to this `Dockerfile`, then:

```
docker build -t glint .
docker run -d --restart unless-stopped --gpus all -p 127.0.0.1:4078:4078 glint --wallet prl1... --worker rig1
```

The dashboard is then at http://127.0.0.1:4078 on the host. From 1.2.8 it is view-only: inside the container every
request comes from Docker's network, so GlintMiner can't tell the host's browser from any other device. To change
settings and tuning from the host's browser, add `--api-allow-remote-control` after the image name; the page then asks
once for the remote-control code, which `docker logs <container>` shows at each start. Keep the `127.0.0.1:` in `-p`
either way, so only the host can reach the page.
