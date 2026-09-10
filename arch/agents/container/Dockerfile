FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl ca-certificates build-essential sudo bash ripgrep \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 -s /bin/bash agent

USER agent
RUN curl https://mise.run | sh
ENV PATH="/home/agent/.local/bin:/home/agent/.local/share/mise/shims:${PATH}"

RUN mise use -g node python go pi opencode

ENV GOPATH="/home/agent/go"
ENV PATH="${GOPATH}/bin:${PATH}"
RUN go install golang.org/x/tools/gopls@latest \
    && go install mvdan.cc/gofumpt@latest

COPY --chown=agent agents/opencode /home/agent/.config/opencode
COPY --chown=agent agents/pi /home/agent/.pi

WORKDIR /workspace
CMD ["bash"]
