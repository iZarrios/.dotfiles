#! /usr/bin/env bash
# set -eux

GO_VERSION=$(curl -L 'go.dev/VERSION?m=text' | head -n 1)
curl -Lo go.tar.gz "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
tar -xf go.tar.gz
mv go ~/custom_build/
rm go.tar.gz

# NOTE: now you need to have ~/custom_build/go/bin in your `PATH`

# If you wanna install the LSP
echo "You can install gopls (Go LSP server)"
echo -e "\e[1mgo install -v golang.org/x/tools/gopls@latest\e[0m"
