if (!Test-Parth $HOME/.cargo)
{
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	cargo install tree-sitter-cli
	cargo install starship
}

if (!Test-Path /root/.config)
{
	cp -rf /opt/.config /root/
}

nvim --headless --listen 0.0.0.0:9999
