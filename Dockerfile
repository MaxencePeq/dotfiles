# A Linux sandbox to try this Neovim/tmux config without installing anything
# on your machine.
#
#   docker build -t dotfiles .
#   docker run -it --rm dotfiles
#
# Then run `cvim .` inside the container.

FROM ubuntu:24.04

ARG NVIM_VERSION=0.12.2
ARG TREE_SITTER_VERSION=0.27.1

# TERM/COLORTERM give Neovim true colors; SHELL lets install.sh pick ~/.bashrc
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    TERM=xterm-256color \
    COLORTERM=truecolor \
    SHELL=/bin/bash

# The system packages listed in the README
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates git curl tar gzip unzip build-essential nodejs npm \
        php-cli php-xml php-mbstring php-curl composer ripgrep fd-find tmux \
    && rm -rf /var/lib/apt/lists/*

# Neovim and the tree-sitter CLI come from their GitHub releases: Ubuntu's
# packages are too old. The archive name depends on the CPU (Intel/AMD or ARM).
RUN case "$(uname -m)" in \
        aarch64 | arm64) nvim_arch=arm64; ts_arch=arm64 ;; \
        *) nvim_arch=x86_64; ts_arch=x64 ;; \
    esac \
    && curl -fsSL "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${nvim_arch}.tar.gz" \
        | tar -xz -C /opt \
    && ln -s "/opt/nvim-linux-${nvim_arch}/bin/nvim" /usr/local/bin/nvim \
    && curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/download/v${TREE_SITTER_VERSION}/tree-sitter-linux-${ts_arch}.gz" \
        | gunzip > /usr/local/bin/tree-sitter \
    && chmod +x /usr/local/bin/tree-sitter

# Work as a regular user, like on a real machine
RUN useradd -m -s /bin/bash dev
USER dev
WORKDIR /home/dev/dotfiles

COPY --chown=dev:dev . .

# The same script a real user runs: it copies the configs, then downloads the
# plugins and language servers, so the container starts ready to use.
RUN ./install.sh

CMD ["bash"]
