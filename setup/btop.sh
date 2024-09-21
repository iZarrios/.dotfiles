#! /usr/bin/env bash
# set -eux

BTOP_VERSION=$(curl -s "https://api.github.com/repos/aristocratos/btop/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo btop.tbz "https://github.com/aristocratos/btop/releases/download/v${BTOP_VERSION}/btop-x86_64-linux-musl.tbz"
tar -xf btop.tbz
sudo cp ./btop/bin/btop ~/.local/bin
rm -rf btop.tbz ./btop
