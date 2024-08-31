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
    cd ~/custom_build/neovim/neovim
    git pull
    # building neovim
    make $serial CMAKE_BUILD_TYPE=Release
    # default install location is '/usr/local/bin'
    sudo make install
else 
    # the `custom_build` directory is a custom directory that I build things from sources in.
    mkdir -p ~/custom_build/neovim
    cd ~/custom_build/neovim
    # cloning neovim repo
    git clone https://github.com/neovim/neovim.git
    # installing dependencies
    sudo apt update
    sudo apt-get install ninja-build gettext cmake unzip curl -y
    # building neovim
    cd neovim && make $serial CMAKE_BUILD_TYPE=Release
    # default install location is '/usr/local/bin'
    sudo make install
fi
