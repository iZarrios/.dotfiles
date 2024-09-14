#! /usr/bin/env bash
# set -eux

if command -v cargo &> /dev/null; then
    # if cargo is found then we can install alacritty
    if command -v alacritty &> /dev/null; then
        # if alacritty is found then we need to update it
        cd ~/custom_build/alacritty
    else
        mkdir -p ~/custom_build
        cd ~/custom_build
        git clone https://github.com/alacritty/alacritty.git
        cd alacritty

        # src: https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu
        sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y
    fi
    cargo build --release
    ln -sf `realpath ./target/release`/alacritty ~/.local/bin/alacritty
else
    echo "'cargo' has to be installed"
    echo "You can install it using the following command:"
    echo -e "\e[1mcurl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh\e[0m"
fi

