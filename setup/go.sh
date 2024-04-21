#! /usr/bin/env bash

GO_VERSION=$(curl -L https://golang.org/VERSION?m=text | head -n 1)
curl -Lo go.tar.gz "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
tar -xf go.tar.gz
mv go ~/custom_build/
rm go.tar.gz 

# If you wanna install the LSP
# go install -v golang.org/x/tools/gopls@latest
