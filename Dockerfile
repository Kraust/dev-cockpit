FROM ubuntu:24.04

COPY gitconfig /root/.gitconfig

RUN apt-get update \
    && apt-get install -y software-properties-common

RUN mkdir -p /root/.ssh && ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN mkdir -p /opt/.config

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    make \
    cmake \
    gcc \
    g++ \
    clang \
    fd-find \
    nodejs \
    npm \
    yarn \
    lldb \
    curl \
    python3-pip \
    python3-venv \
    golang \
    openjdk-21-jdk \
    shellcheck \
    libsqlite3-dev \
    fzf

# Docker
RUN curl -sSf https://get.docker.com | sh

# Rust
RUN export CARGO_HOME=/opt/.cargo \
    && export RUSTUP_HOME=/opt/.cargo \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y && . /root/.bashrc \
    && cargo install tree-sitter-cli \
    && cargo install starship \
    && cargo install coreutils \
    && cargo install zoxide \
    && cargo install ripgrep \
    && cargo install bottom \
    && cargo install brush-shell \
    && cargo install diskonaut \
    && cargo install dust \
    && cargo install bat \
    && cargo install skim

# Nvim
RUN git clone https://github.com/neovim/neovim.git /opt/neovim \
    && cd /opt/neovim \
    && make \
    && make install \
    && cd /opt \
    && rm -rf /opt/neovim
RUN git clone https://github.com/Kraust/nvim.git /opt/.config/nvim \
    && echo ".config/nvim" >> /opt/.to-copy

# Go
RUN git clone https://github.com/go-nv/goenv.git /opt/.goenv \
    && echo ".goenv" >> /opt/.to-copy

# Python
RUN git clone https://github.com/pyenv/pyenv.git /opt/.pyenv \
    && echo ".pyenv" >> /opt/.to-copy

# Node
RUN git clone https://github.com/nodenv/nodenv.git /opt/.nodenv \
    && echo ".nodenv" >> /opt/.to-copy

# Ruby
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
    && echo ".rbenv" >> /opt/.to-copy

#Bash/Brush
RUN git clone https://github.com/Kraust/bashrc.git ~/.config/.bashrc \
    && cd /opt/.config/bashrc \
    && ln -s .bashrc ../../.bashrc \
    && echo ".bashrc" >> /opt/.to-copy \
    && echo ".config/bashrc" >> /opt/.to-copy \
    && cd /

ENV PATH="$PATH:/root/.cargo/bin"
ENV PATH="$PATH:/root/bin"
ENV PATH="$PATH:/root/.config/bin"
ENV PATH="$PATH:/root/.pyenv/bin"
ENV PATH="$PATH:/root/.goenv/bin"
ENV PATH="$PATH:/root/.nodenv/bin"
ENV PATH="$PATH:/root/.rbenv/bin"

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

SHELL ["/opt/.cargo/bin/brush", "-c"]
ENTRYPOINT ["/opt/entrypoint.sh"]
