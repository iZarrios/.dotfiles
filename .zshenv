. "$HOME/.cargo/env"

# Language server settings
export PYRIGHT_PYTHON_FORCE_VERSION=latest

# Python virtual environment requirement
export PIP_REQUIRE_VIRTUALENV=true

# Current user
export DOTFILES_USER="`whoami`"

# Editor settings
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL=$EDITOR
else
  export EDITOR='nvim'
  export VISUAL=$EDITOR
fi

# FZF settings
export FZF_DEFAULT_OPTS="--extended --ansi --border=none"

# Pager for man pages
export MANPAGER='nvim +Man!'

# Node prefix (n-install)
export N_PREFIX="$HOME/.n"

# Go settings
export GOMODCACHE="$HOME/caches"
export GOBIN="$HOME/.local/bin/go"

# apply 12H date format gloablly
# +%I:%M %p
export TIME_STYLE=+%D\ %I:%M\ %p

# PATH configuration
export PATH=$N_PREFIX/bin:$PATH
export PATH=$PATH:"$HOME/bin/go"
export PATH=$PATH:"$HOME/.cargo/bin"
export PATH=$PATH:"$HOME/.local/scripts/"
export PATH=$PATH:"$HOME/.local/bin/go"
export PATH=$PATH:"$HOME/.n/bin/node"
export PATH=$PATH:"/usr/local/bin"
export PATH=$PATH:"$HOME/.local/bin/"
export PATH=$PATH:"$HOME/custom_build/llama.cpp/build/bin"
export PATH=$PATH:"$HOME/custom_build/android-studio/bin"
export PATH=$PATH:"$HOME/.opencode/bin"
export PATH=$PATH:"$HOME/Android/Sdk/ndk/21.1.6352462"
export PATH=$PATH:"/opt/cuda/bin"

export QT_QPA_PLATFORMTHEME=qt6ct
export QT_QPA_PLATFORM="xcb"
