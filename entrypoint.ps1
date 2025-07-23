
if ($isWindows)
{
	if (!Test-Path $HOME/AppData/Local/nvim)
	{
		cp -rf /opt/ $HOME
	}
	$ENV:PATH += ";C:\tools\neovim\nvim-win64\bin\"
} else
{
	if (!Test-Parth $HOME/.cargo)
	{
		curl https://sh.rustup.rs -sSf | sh -s -- -y
		cargo install tree-sitter-cli
		cargo install starship
	}

	if (!Test-Path $HOME/.config)
	{
		cp -rf /opt/.config $HOME
	}
}

nvim --headless --listen 0.0.0.0:9999
