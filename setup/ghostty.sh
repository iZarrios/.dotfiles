#! /usr/bin/env bash
# set -eux

if command -v zig &> /dev/null; then
    # if zig is found then we can install ghostty
    if command -v ghostty &> /dev/null; then
        # if ghostty is found then we need to update it
        cd ~/custom_build/ghostty
    else
        mkdir -p ~/custom_build
        cd ~/custom_build
        git clone https://github.com/ghostty-org/ghostty.git
        cd ghostty

        # src: https://ghostty.org/docs/install/build
        sudo apt install libgtk-4-dev libadwaita-1-dev git
    fi
    zig build -Doptimize=ReleaseFast
    echo -e "Artifacts will be in zig-out btw"
else
    echo "zig has to be installed"
    echo "You can install it using from here: "
    echo -e "\e[1mhttps://ziglang.org/download/\e[0m"
fi

