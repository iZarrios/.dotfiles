#! /usr/bin/env bash
# set -eux

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}Building Neovim${NC}"
nproc_output=$(nproc 2>/dev/null)
if [[ "$nproc_output" =~ ^[0-9]+$ ]]; then
    serial="-j $nproc_output"
else
    serial=""
fi


if command -v nvim &> /dev/null; then
    # if it is found, then we probably want to update it
    cd ~/custom_build/neovim
    git pull
    make clean
    # during configure step for 'treesitter' there was an error: CMake Error:
    # The source "neovim/.deps/build/src/treesitter/lib/CMakeLists.txt" does
    # not match the source.
    # This error is prob because we cache treesitter?,so maybe treesitter
    # changed how they build treesitter so we have to get the files again In
    # this script, I use make clean to verify that these things but I guess
    # `make clean` doesn't remove the .deps directory
    rm -rf .deps
else
    mkdir -p ~/custom_build
    cd ~/custom_build
    git clone https://github.com/neovim/neovim.git
    cd neovim
    # installing dependencies
    sudo apt update
    sudo apt-get install ninja-build gettext cmake unzip curl -y
fi

# building neovim
make $serial CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=~/.local
sudo make install
