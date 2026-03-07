if not status is-interactive
    return 0
end

set -gx PYRIGHT_PYTHON_FORCE_VERSION "latest"
set -gx PIP_REQUIRE_VIRTUALENV "true"

set -gx DOTFILES_USER (whoami)

if set -q SSH_CONNECTION
    set -gx EDITOR "vim"
    set -gx VISUAL $EDITOR
else
    set -gx EDITOR "nvim"
    set -gx VISUAL $EDITOR
end

# FZF settings
set -gx FZF_DEFAULT_OPTS "--extended --ansi --border=none"

# Pager for man pages
set -gx MANPAGER "nvim +Man!"

# Node prefix (n-install)
set -gx N_PREFIX "$HOME/.n"

set -gx GOMODCACHE "$HOME/caches"
set -gx GOBIN "$HOME/.local/bin/go"

# apply 12H date format globally
# Fish handles time format via 'set -gx TIME_STYLE' but usually uses 'date' command options.
# If you want this for the prompt, you might use a prompt hook, but here is the global env var.
set -gx TIME_STYLE "+%D %I:%M %p"

# PATH configuration
# Fish uses a list, so we append instead of colon separating.
set -gx PATH $N_PREFIX/bin $PATH
set -gx PATH "$HOME/bin/go" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "$HOME/.local/scripts/" $PATH
set -gx PATH "$HOME/.local/bin/go" $PATH
set -gx PATH "$HOME/.n/bin/node" $PATH
set -gx PATH "$HOME/.local/bin/" $PATH
set -gx PATH "$HOME/.opencode/bin" $PATH
set -gx PATH "/usr/local/bin/" $PATH
set -gx PATH "/opt/cuda/bin" $PATH


function yt-dlp-best
    # Check if yt-dlp is actually installed and executable
    # 'type' returns 0 if found, 1 if not
    if not type -q yt-dlp
        echo "yt-dlp is not installed or not in your PATH."
        return 1
    end

    # Check if an argument (URL) was provided
    if test -z "$argv[1]"
        echo "Usage: ytdlp <URL>"
        return 1
    end

    # Run the command
    # Note: Fish automatically puts arguments into $argv
    yt-dlp $argv[1] --js-runtimes node -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
end

function tmux_sessionizer
    # 1. Handle Arguments
    if test (count $argv) -eq 1
        set selected $argv[1]
    else
        # 2. Find Directories (Fish handles brace expansion and ~ automatically)
        set -l search_paths ~/dev

        # Collect directories into a list
        set -l dirs (find $search_paths -mindepth 1 -maxdepth 1 -type d 2>/dev/null)

        # Add dotfiles to the list
        set -a dirs ~/.dotfiles

        # 3. Pipe to fzf (printf handles newlines between list items automatically)
        set selected (printf '%s\n' $dirs | fzf)
    end

    # 4. Check if selection is empty
    if test -z "$selected"
        return 0
    end

    # 5. Create Session Name (replace dots with underscores)
    set selected_name (basename "$selected" | string replace -a . _)

    # 6. Check if tmux is running
    set tmux_running (pgrep tmux)

    # 7. Tmux Logic
    if test -z "$TMUX"; and test -z "$tmux_running"
        tmux new-session -s $selected_name -c $selected
        return 0
    end

    if not tmux has-session -t=$selected_name 2>/dev/null
        tmux new-session -ds $selected_name -c $selected
    end

    if test -z "$TMUX"
        tmux attach -t $selected_name
    else
        tmux switch-client -t $selected_name
    end
end

bind \cf tmux-sessionizer
bind \cx\ce edit_command_buffer

# Compilation flags
# set -gx ARCHFLAGS "-arch x86_64"

# cfg: ALISES
if test "$XDG_SESSION_TYPE" = "wayland"
    # NOTE: you need to install `wl-clipboard`
    alias cclip="wl-copy"
    alias pclip="wl-paste"
else
    # NOTE: you need to install `xclip`
    alias cclip="xclip -selection clipboard"
    alias pclip="xclip -selection clipboard"
end

alias ping-="ping 4.2.2.1"
alias rp="realpath"
alias fd="fdfind"
alias gst="git status"
alias lg="lazygit"
alias tmux="tmux -2"
alias v="nvim"
alias v.="v ."
alias path='printf "%s\n" $PATH | tr ":" "\n"'
alias mv="mv -i"
alias dl="cd ~/Downloads"
alias mktmux="tmux new -s \"(realpath . | tr ' ' _ | xargs basename | tr . _)\""
alias fman="compgen -c | fzf | xargs man"
alias venv="source .venv/bin/activate.fish"
alias python="python3"
alias py="python"
alias l="ls -larth"

# Linux specific alias
if test "$(uname)" = "Linux"
    alias open="xdg-open"
end

# Sourcing some secret keys
# If you have a .fish file for secrets, uncomment the line below.
# source "$HOME/

starship init fish | source

fzf --fish | source

# Remove the gretting message.
set -U fish_greeting

# set -g fish_key_bindings fish_vi_key_bindings
# set fish_vi_force_cursor 1
# set fish_cursor_default block
# set fish_cursor_insert block
# set fish_cursor_replace_one underscore
