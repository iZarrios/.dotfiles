#! /usr/bin/env bash
# set -eux

if command -v zsh &> /dev/null; then
    # installing zsh
    sudo apt install zsh
    # making zsh default shell
    chsh -s `which zsh`
    # installing zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ### Installing the plugins

    # zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # fast-syntax-highlighting
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
fi

