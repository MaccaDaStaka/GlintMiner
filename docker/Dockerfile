# GlintMiner in a container: needs the NVIDIA Container Toolkit on the host (docker run --gpus all).
FROM ubuntu:22.04
ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=compute,utility
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /glint
COPY glint /glint/glint
EXPOSE 4078
# docker run --gpus all -p 127.0.0.1:4078:4078 glint --wallet prl1... --worker rig1
ENTRYPOINT ["/glint/glint", "--plain", "--no-log-file", "--config", "/glint/glint.json", "--api-bind", "0.0.0.0"]
