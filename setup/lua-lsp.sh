#! /usr/bin/env bash
# set -eux

#now we want to install the lua language server
LUA_LSP_VERSION=$(curl -s "https://api.github.com/repos/LuaLS/lua-language-server/releases/latest" | tee out | grep -Po '"tag_name": "\K[^"]*')

mkdir -p "$HOME/custom_build"
cd "$HOME/custom_build"

curl -Lo lua-lsp.tar.gz "https://github.com/LuaLS/lua-language-server/releases/download/${LUA_LSP_VERSION}/lua-language-server-${LUA_LSP_VERSION}-linux-x64.tar.gz"
mkdir -p lua-lsp
tar xf lua-lsp.tar.gz --directory lua-lsp
# # remove the tar file that we downloaded
rm lua-lsp.tar.gz
cd lua-lsp
# make symlink to local binaries (which is in my PATH)
mkdir -p "$HOME/.local/bin"
ln -sf `realpath bin/lua-language-server` "$HOME/.local/bin/lua-language-server"

