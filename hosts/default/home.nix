# Home Manager configuration for nix.
# This replaces GNU Stow + the setup/*.sh scripts.
# Rebuild with: sudo nixos-rebuild switch --flake /home/nix/.dotfiles#nixos
{ config, pkgs, ... }:

{
  home.username = "nix";
  home.homeDirectory = "/home/nix";

  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
    gtk.enable = true;
  };

  # ── Packages ────────────────────────────────────────────────────────────
  # These replace all the setup/*.sh install scripts.
  home.packages = with pkgs; [

    # Shell utilities
    vlc
    ripgrep
    fd
    btop
    htop
    nvtop
    yazi
    lazygit
    yt-dlp
    unzip

    # Clipboard
    wl-clipboard

    # Languages & toolchains
    lua
    lua-language-server
    nodejs
    python3
    cargo
    rustc
    gcc
    clang
    clang-tools
    cmake
    ninja
    uv

    tree-sitter
    neovim
    obsidian
    pavucontrol

    delta
  ];

  # ── Environment Variables ───────────────────────────────────────────────
  # These replace .zshenv exports. They are set for every session (login, interactive, etc.).
  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    FZF_DEFAULT_OPTS = "--extended --ansi --border=none";
    PIP_REQUIRE_VIRTUALENV = "true";
    PYRIGHT_PYTHON_FORCE_VERSION = "latest";
    TIME_STYLE = "+%D %I:%M %p";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORM = "xcb";
    GOMODCACHE = "$HOME/caches";
    GOBIN = "$HOME/.local/bin/go";
  };

  # Extra PATH entries (for your own scripts, Go binaries, etc.)
  home.sessionPath = [
    "$HOME/.local/scripts"
    "$HOME/.local/bin/go"
    "$HOME/.local/bin"
  ];

  # ── Zsh ─────────────────────────────────────────────────────────────────
  # Replaces .zshrc, zsh.sh setup script, and the Oh My Zsh manual install.
  programs.zsh = {
    enable = true;

    # Oh My Zsh — Home Manager installs and manages it for you.
    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh/custom";
      theme = "my_ys";
      plugins = [
        "git"
        "extract"
        "sudo"
        "fzf"
      ];
    };

    # zsh-autosuggestions — managed natively by Home Manager.
    autosuggestion.enable = true;

    # Syntax highlighting — Home Manager's built-in option (uses zsh-syntax-highlighting).
    # Simpler than managing fast-syntax-highlighting manually on NixOS.
    syntaxHighlighting.enable = true;

    # Shell aliases (migrated from .zshrc).
    # NOTE: `fd` is already `fd` on NixOS, so the old `alias fd="fdfind"` is removed.
    shellAliases = {
      ping- = "ping 4.2.2.1";
      rp = "realpath";
      gst = "git status";
      lg = "lazygit";
      tmux = "tmux -2";
      v = "nvim";
      "v." = "nvim .";
      path = "echo -e \${PATH//:/\\\\n}";
      mv = "mv -i";
      dl = "cd ~/Downloads";
      mktmux = ''tmux new -s "$(realpath . | tr " " _ | xargs basename | tr . _)"'';
      fman = "compgen -c | fzf | xargs man";
      venv = "source .venv/bin/activate";
      python = "python3";
      py = "python";
      cd = "z";
      open = "xdg-open";
    };

    initContent = ''
      # ── EDITOR — use vim over SSH, nvim locally ──
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
        export VISUAL='vim'
      else
        export EDITOR='nvim'
        export VISUAL='nvim'
      fi

      # ── Clipboard aliases (Wayland vs X11) ──
      if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        alias cclip="wl-copy"
        alias pclip="wl-paste"
      else
        alias cclip="xclip -selection clipboard"
        alias pclip="xclip -selection clipboard"
      fi

      # ── Keybindings ──
      bindkey -s ^f "tmux-sessionizer\n"

      # ── Custom functions ──

      # Download best quality video with yt-dlp
      function yt-dlp-best() {
        if ! command -v yt-dlp &> /dev/null; then
          echo "yt-dlp is not in your PATH."
          return 1
        fi
        if [[ -z $1 ]]; then
          echo "Usage: yt-dlp-best <URL>"
          return 1
        fi
        yt-dlp "$1" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
      }

      # Yazi wrapper — cd into the directory yazi was in when you quit
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        command yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }

      # ── Source secrets (API keys, tokens, etc.) ──
      [ -f "$HOME/secret.zsh" ] && source "$HOME/secret.zsh"
    '';
  };

  # ── fzf ─────────────────────────────────────────────────────────────────
  # Replaces `[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh` — Home Manager sets up
  # keybindings, completion, and shell integration automatically.
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # ── zoxide ──────────────────────────────────────────────────────────────
  # Replaces `eval "$(zoxide init zsh)"` at the bottom of .zshrc.
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # ── tmux ────────────────────────────────────────────────────────────────
  # Sources your existing .tmux.conf so you can keep editing it as a normal file.
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../../.tmux.conf;
  };

  # ── git ─────────────────────────────────────────────────────────────────
  # Basic enable — your .gitconfig is symlinked below for full control.
  programs.git = {
    enable = true;
    signing.format = null;
  };

  # ── Dotfile Symlinks ────────────────────────────────────────────────────
  # These replace GNU Stow. Home Manager creates symlinks from your home
  # directory into the Nix store, pointing at these source files.
  # You can still edit the files in this repo normally — just rebuild to apply.

  # ~/.config/* directories
  xdg.configFile = {
    "alacritty".source  = ../../.config/alacritty;
    "btop".source       = ../../.config/btop;
    "hypr".source       = ../../.config/hypr;
    "i3".source         = ../../.config/i3;
    "nvim".source       = ../../.config/nvim;
    "waybar".source     = ../../.config/waybar;
    "fish".source       = ../../.config/fish;
    #"fontconfig".source = ../../.config/fontconfig;
    "zed".source        = ../../.config/zed;
    "VSCodium".source   = ../../.config/VSCodium;
  };

  # ~/dotfiles (home directory root)
  home.file = {
    ".clang-format".source = ../../.clang-format;
    ".clangd".source       = ../../.clangd;
    ".gitconfig".source    = ../../.gitconfig;
    ".i3status.conf".source = ../../.i3status.conf;
    ".ideavimrc".source    = ../../.ideavimrc;
    ".Xresources".source   = ../../.Xresources;
    ".oh-my-zsh/custom/themes/my_ys.zsh-theme".source = ../../setup/my_ys.zsh-theme;

    # Scripts
    ".local/scripts/tmux-sessionizer" = {
      source = ../../.local/scripts/tmux-sessionizer;
      executable = true;
    };
  };

  # ── Home Manager Bookkeeping ────────────────────────────────────────────
  # Don't change this after initial setup — it's for internal compatibility.
  home.stateVersion = "24.11";

  # Let Home Manager manage itself.
  programs.home-manager.enable = true;
}
