#!/usr/bin/env bash

set -e

mkdir -p "$HOME"/.config

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-get install -y \
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
    build-essential \
    python3-pip \
    python3-venv \
    golang \
    openjdk-21-jdk \
    shellcheck \
    libsqlite3-dev \
    fzf

# Docker
if [ "$(which docker || true)" == "" ]; then
    sudo bash -c "curl -sSf https://get.docker.com | sh"
fi

export PATH="$PATH:$HOME/.cargo/bin"

# Rust
curl https://sh.rustup.rs -sSf | sh
cargo install --locked tree-sitter-cli
cargo install --locked starship
cargo install --locked zoxide
cargo install --locked ripgrep
cargo install --locked bottom
cargo install --locked diskonaut
cargo install --locked bat
export PROJECT_NAME_FOR_VERSION_STRING="uutils coreutils" &&
    cargo install --locked coreutils
export PROJECT_NAME_FOR_VERSION_STRING="uutils findutils" &&
    cargo install --locked findutils

# xonsh
TARGET_DIR=$HOME/.local/xonsh-env PYTHON_VER=3.11 XONSH_VER='xonsh[full]>=0.19.0' \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/anki-code/xonsh-install/main/mamba-install-xonsh.sh)"

# Nvim
git clone https://github.com/neovim/neovim.git "$HOME"/neovim &&
    cd "$HOME"/neovim &&
    make &&
    sudo make install

# Go
git clone https://github.com/go-nv/goenv.git "$HOME"/.goenv

# Python
git clone https://github.com/pyenv/pyenv.git "$HOME"/.pyenv

# Node
git clone https://github.com/nodenv/nodenv.git "$HOME"/.nodenv

# Ruby
git clone https://github.com/rbenv/rbenv.git "$HOME"/.rbenv

# Configs
git clone https://github.com/Kraust/nvim.git "$HOME/.config/Local/nvim"
git clone https://github.com/Kraust/starship.git "$HOME/.config/starship"
git clone https://github.com/Kraust/xonsh.git "$HOME/.config/xonsh"

(
    "$HOME/.local/xonsh-env/xbin/xonsh"
    xpip install \
        xontrib-fzf-completions \
        xontrib-prompt-starship \
        xontrib-langenv
)

cat <<EOF | sudo tee -a /etc/systemd/user/nvimd.service
[Unit]
Description=Neovim Daemon Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/nvim --headless --listen 0.0.0.0:9000
Restart=always
RestartSec=5
WorkingDirectory=%h

[Install]
WantedBy=default.target
EOF
systemctl --user enable nvimd
systemctl --user start nvimd
