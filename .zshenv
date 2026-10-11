[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Language server settings
export PYRIGHT_PYTHON_FORCE_VERSION=latest

# Python virtual environment requirement
export PIP_REQUIRE_VIRTUALENV=true

# Current user
export DOTFILES_USER="`whoami`"

# Editor settings
export EDITOR='nvim'
export VISUAL=$EDITOR

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

# Add locally installed tools only when their directories exist. This keeps the
# same file usable on a clean NixOS laptop without shadowing Nix packages with
# nonexistent Arch paths.
typeset -U path PATH
for dotfiles_path in \
    "$N_PREFIX/bin" \
    "$HOME/custom_build/go/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.local/scripts" \
    "$HOME/.local/bin/go" \
    "$HOME/.n/bin/node" \
    "/usr/local/bin" \
    "$HOME/.local/bin" \
    "$HOME/custom_build/llama.cpp/build/bin" \
    "$HOME/custom_build/android-studio/bin" \
    "$HOME/.opencode/bin" \
    "$HOME/Android/Sdk/ndk/21.1.6352462" \
    "$HOME/Android/Sdk/platform-tools" \
    "$HOME/custom_build/clion-2026.2.0.1/bin" \
    "/opt/cuda/bin"
do
    [[ -d "$dotfiles_path" ]] && path+=("$dotfiles_path")
done
unset dotfiles_path

export QT_QPA_PLATFORMTHEME=qt6ct
export QT_QPA_PLATFORM="xcb"
