# TODO: Grab old Windows Dockerfile.

# TODO: Find a better way.
Import-Module 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\Common7\\Tools\\Microsoft.VisualStudio.DevShell.dll';
Enter-VsDevShell -VsInstallPath 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional' -StartInPath "$pwd"

cd $HOME

# Cargo
Invoke-WebRequest -Uri "https://win.rustup.rs/" -OutFile "$env:TEMP\rustup-init.exe"; & "$env:TEMP\rustup-init.exe"

$Env:Path += ";$HOME/.cargo/bin"
$Env:CARGO_TARGET_DIR = "$HOME/.cargo/target"
cargo install --locked tree-sitter-cli
cargo install --locked starship
cargo install --locked zoxide
cargo install --locked ripgrep
cargo install --locked bottom
cargo install --locked brush-shell
cargo install --locked diskonaut
cargo install --locked bat
cargo install --locked skim
$ENV:PROJECT_NAME_FOR_VERSION_STRING="uutils coreutils"; cargo install --locked coreutils
$ENV:PROJECT_NAME_FOR_VERSION_STRING="uutils findutils"; cargo install --locked findutils

pip install xonsh[full] xontrib-fzf-completions xontrib-prompt-starship

Set-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name "DefaultShell" -Value "$HOME\AppData\Local\Programs\Python\Python312\Scripts\xonsh.exe" -Force

# Install neovim - make this a function
git clone https://github.com/neovim/neovim.git "$HOME/neovim"
cd "$HOME/neovim"

cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build .deps --config Release
cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build --config Release
cmake --build buiild --install "C:\Program Files\neovim\"

cd $HOME
# Install neovim - make this a function

git clone https://github.com/Kraust/nvim.git "$HOME/AppData/Local/nvim"
git clone https://github.com/Kraust/starship.git "$HOME/.config/starship"
git clone https://github.com/Kraust/xonsh.git "$HOME/.config/xonsh"

