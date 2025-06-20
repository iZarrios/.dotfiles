#! /usr/bin/env bash
# set -eux

# finds latest LUA_VERSION on GitHub
LUA_VERSION=$(curl -s "https://api.github.com/repos/lua/lua/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

mkdir -p "$HOME/custom_build"
cd "$HOME/custom_build"

curl -Lo lua.tar.gz "https://github.com/lua/lua/archive/refs/tags/v${LUA_VERSION}.tar.gz"
tar xf lua.tar.gz
# remove the tar file that we downloaded
rm lua.tar.gz

cd "lua-$LUA_VERSION"
# build lua
make -j`nproc`

# make symlink to local binaries (which is in my PATH)
mkdir -p "$HOME/.local/bin"
ln -sf `realpath lua` "$HOME/.local/bin/"
