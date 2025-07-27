#!/usr/bin/env xonsh

from pathlib import Path

if not Path(f"{$HOME}/.cargo"):
	print("Installing cargo")
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	cargo install tree-sitter-cli
	cargo install starship

if not Path(f"{$HOME}/.config").exists():
	cp -rf /opt/.config /root/

if not Path(f"{$HOME}/.goenv/bin").exists():
	cp -rf /opt/.goenv /root/

if not Path(f"{$HOME}/.pyenv/bin").exists():
	cp -rf /opt/.pyenv /root/

if not Path(f"{$HOME}/.nodenv/bin").exists():
	cp -rf /opt/.nodenv /root/

xpip install \
	xontrib-prompt-starship \
	xontrib-fzf-completions \
	xontrib-langenv

nvim --headless --listen 0.0.0.0:9999
