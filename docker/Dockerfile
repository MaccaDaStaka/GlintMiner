# GlintMiner in a container: needs the NVIDIA Container Toolkit on the host (docker run --gpus all).
FROM ubuntu:22.04
# GLINT_PLATFORM=docker: GlintMiner never replaces itself in a container; it says which version to rebuild with.
ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=compute,utility GLINT_PLATFORM=docker
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /glint
COPY glint /glint/glint
EXPOSE 4078
# docker run --gpus all -p 127.0.0.1:4078:4078 glint --wallet prl1... --worker rig1
# View-only by default: inside the container every request comes from Docker's bridge, so remote control would let any
# other container on the bridge, or the whole network after a "-p 4078:4078" (which also bypasses ufw), change the
# payout wallet and turn the temperature guard off. To change settings from the host's own browser, add
# --api-allow-remote-control to the run command yourself and keep "-p 127.0.0.1:4078:4078" (see README).
ENTRYPOINT ["/glint/glint", "--plain", "--no-log-file", "--config", "/glint/glint.json", "--api-bind", "0.0.0.0"]
