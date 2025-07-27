#!/usr/bin/env xonsh

from pathlib import Path

if not Path(f"{$HOME}/.cargo"):
	print("Installing cargo")
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	cargo install tree-sitter-cli
	cargo install starship

if not Path(f"{$HOME}/.config"):
	cp -rf /opt/.config /root/

nvim --headless --listen 0.0.0.0:9999
