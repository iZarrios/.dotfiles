{ inputs, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = with pkgs; [
    bat
    btop
    delta
    fd
    ffmpeg
    fish
    fzf
    git-lfs
    htop
    jq
    kitty
    lazygit
    ripgrep
    tmux
    unzip
    yazi
    yt-dlp
    zip
    zoxide

    cargo
    clang
    cmake
    gcc
    gdb
    go
    gopls
    lua
    lua-language-server
    neovim
    ninja
    nodejs
    python3
    pyright
    ruff
    rust-analyzer
    rustc
    tree-sitter
    typescript-language-server
    uv

    alacritty
    brave
    ghostty
    libreoffice
    librewolf
    obsidian
    pavucontrol
    playerctl
    qbittorrent
    vlc
    waybar
    xclip
    xdg-utils
    vscodium
    zed-editor

    # Native Noctalia v5. Configuration is shared with Arch through
    # .config/noctalia/config.toml.
    inputs.noctalia.packages.${system}.default
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.local/bin/go"
    "$HOME/.local/scripts"
  ];
}
