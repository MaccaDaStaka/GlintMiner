# GlintMiner in Docker

Needs an NVIDIA driver and the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) on the host.

Put the Linux `glint` binary from the [Releases](../../../releases) page next to this `Dockerfile`, then:

```
docker build -t glint .
docker run -d --restart unless-stopped --gpus all -p 127.0.0.1:4078:4078 glint --wallet prl1... --worker rig1
```

The dashboard is then at http://127.0.0.1:4078 on the host. Keep the `127.0.0.1:` in `-p`: the container lets its
dashboard change settings and tuning, so publishing the port to your network would let other devices do that too.
