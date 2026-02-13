FROM ubuntu:24.04

ARG S6_OVERLAY_VERSION=3.2.0.2

ENV DEBIAN_FRONTEND=noninteractive
ENV S6_KEEP_ENV=1
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# System packages
RUN apt-get update && apt-get install -y \
      curl git ca-certificates gnupg xz-utils ttyd sudo \
    && rm -rf /var/lib/apt/lists/*

# Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# AI coding CLIs
RUN npm install -g @google/gemini-cli @openai/codex
USER ubuntu
RUN curl -fsSL https://claude.ai/install.sh | bash
RUN curl -fsSL https://opencode.ai/install | bash
USER root
RUN cp -L /home/ubuntu/.local/bin/claude /usr/local/bin/claude
RUN cp -L /home/ubuntu/.opencode/bin/opencode /usr/local/bin/opencode

# VS Code CLI (only available as alpine/static build)
RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' \
      -o /tmp/vscode-cli.tar.gz \
    && tar -xzf /tmp/vscode-cli.tar.gz -C /usr/local/bin \
    && rm /tmp/vscode-cli.tar.gz

# s6-overlay v3
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz \
    && rm /tmp/s6-overlay-*.tar.xz

# ubuntu user (UID 1000) — already exists in base image with sudo group
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ubuntu

# s6 service definitions
COPY rootfs/ /

ENTRYPOINT ["/init"]
