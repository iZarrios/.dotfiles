# NOTE: I will be appending a suffix of _v42069 to every custom variable

current_user_v42069=$(whoami)

# Use a case statement to act based on the current user
case "$current_user_v42069" in
  zarrios)
    export EXTERNAL_DRIVE_v42069="$HOME"
    ;;
  phormico)
    export EXTERNAL_DRIVE_v42069="/mnt/vsh"
    ;;
  sherdle)
    export EXTERNAL_DRIVE_v42069="$HOME"
    ;;
  hpv)
    export EXTERNAL_DRIVE_v42069="$HOME"
    ;;
  biluka)
    export EXTERNAL_DRIVE_v42069="$HOME"
    ;;
  *)
    echo "Hello, $current_user_v42069! You are not currently listed in the .zshrc, will default to $HOME"
    export EXTERNAL_DRIVE_v42069="$HOME"
    ;;
esac

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PYRIGHT_PYTHON_FORCE_VERSION=latest

export PATH=$N_PREFIX/bin:$PATH
export PIP_REQUIRE_VIRTUALENV=true

export DOTFILES_USER="`whoami`"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set list of themes to pick from when loading at random
ZSH_THEME="eastwood"
# ZSH_THEME="robbyrussell"
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	sudo
	fast-syntax-highlighting # cfg: fast-theme zdharma
)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# The $VISUAL is an environment shell variable. It defines the user's preferred utility (or command) to edit text files.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL=$EDITOR
else
  export EDITOR='nvim'
  export VISUAL=$EDITOR
fi

## cfg: custom scripts
function yt-dlp-best() {
    # Check if yt-dlp is installed
    if ! command -v yt-dlp &> /dev/null; then
        echo "yt-dlp is not in your PATH. Please add it or add `yt-dlp` to your PATH."
        return 1
    fi

    if [[ -z $1 ]]; then
        echo "Usage: ytdlp <URL>"
        return 1
    fi
    yt-dlp "$1" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
}

## cfg: FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--extended --ansi --border=none --color=fg:#ebdbb2,bg:#282828,hl:#458588,fg+:#d5c4a1,bg+:#3c3836,hl+:#b8bb26,info:#83a598,prompt:#d79921,pointer:#fe8019,marker:#d3869b,spinner:#fabd2f,header:#98971a"

# # src: https://github.com/MariaSolOs/dotfiles/blob/887b21756c27c112e38818caf590647601617e31/.zshenv#L33
# export FZF_DEFAULT_OPTS="--extended --color=fg:#f8f8f2,bg:#0e1419,hl:#e11299,fg+:#f8f8f2,bg+:#44475a,hl+:#e11299,info:#f1fa8c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#a4ffff,header:#6272a4 \
# --cycle --pointer=▎ --marker=▎"

# Bindings
bindkey -s ^f "tmux-sessionizer\n"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

## cfg: ALISES
alias ping-="ping 4.2.2.1"
alias rp="realpath"
alias cclip="xclip -selection clipboard"
alias pclip="xclip -selection clipboard"
alias fd="fdfind"
alias gst="git status"
alias lg="lazygit"
alias tmux="tmux -2"
alias v="nvim"
alias path='echo -e ${PATH//:/\\n}' # print path on multiple lines
alias mv='mv -i'
alias dl='cd ~/Downloads'
# alias grep="rg"
alias mktmux='tmux new -s "$(realpath .| tr " " _ | xargs basename | tr . _)"'
alias v.="v ."
alias fman="compgen -c | fzf | xargs man"
alias venv="source .venv/bin/activate"
alias python="python3"
alias py="python"

## cfg: PATH
# Adding go binaries
export PATH=$PATH:"$HOME/bin/go"
export PATH=$PATH:"$HOME/.cargo/bin"

# Adding local scripts
export PATH=$PATH:"$HOME/.local/scripts/"
export PATH=$PATH:"$HOME/.local/bin/"
# Adding `go` and `gofmt`
export PATH=$PATH:"$HOME/custom_build/go/bin"
# NOTE: check `GOBIN`
export PATH=$PATH:"$HOME/.local/bin/go"
# Adding node
export PATH=$PATH:"$HOME/.n/bin/node"

export PATH=$PATH:"/usr/local/bin/"
export PATH=$PATH:"$HOME/.local/bin/"

export PATH=$PATH:"/usr/lib/llvm-18/bin/"
# Adding llvm to PATH (to avoid having to use the suffix of the llvm version)
export PATH=$PATH:"$HOME/custom_build/clang_llvm_18.1.8/bin"

export PATH=$PATH:"$HOME/custom_build/ghostty/zig-out/bin"

# Adding nvidia toolkit to PATH
export PATH=$PATH:"/usr/local/cuda/bin/"

# Go cache module location overwrite
export GOMODCACHE="$HOME/caches"
export GOBIN="$HOME/.local/bin/go"
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Sourcing some scret keys
source "$HOME/secret.zsh"

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

export MANPAGER='nvim +Man!'

