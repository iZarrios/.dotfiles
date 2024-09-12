#! /usr/bin/env bash
# set -eux

if command -v cargo &> /dev/null; then
    # if cargo is found then we can install alacritty
    if command -v rg &> /dev/null; then
        # if ripgrep is found then we need to update it
        rm -f ~/.local/bin//rg # using -f flag to not produce an error if the file does not exist
        cd ~/custom_build/ripgrep
        cargo build --release
        ln -sf `realpath ./target/release`/rg ~/bin/rg
    else
        mkdir -p ~/custom_build
        cd ~/custom_build
        git clone git@github.com:BurntSushi/ripgrep.git
        cd ripgrep
        # Installing dependencies
        # https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu
        cargo build --release
        ln -sf `realpath ./target/release`/rg ~/.local/bin/rg
    fi
else
    echo "'cargo' has to be installed"
    echo "You can install it using the following command:"
    echo -e "\e[1mcurl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh\e[0m"
fi

