{ config, inputs, ... }:

let
  repo = "${config.home.homeDirectory}/.dotfiles";
  fromRepo = path: config.lib.file.mkOutOfStoreSymlink "${repo}${path}";
in
{
  xdg.configFile = {
    "alacritty".source = fromRepo "/.config/alacritty";
    "btop".source = fromRepo "/.config/btop";
    "fish".source = fromRepo "/.config/fish";
    "ghostty".source = fromRepo "/.config/ghostty";
    "hypr".source = fromRepo "/.config/hypr";
    "noctalia".source = fromRepo "/.config/noctalia";
    "nvim".source = fromRepo "/.config/nvim";
    "VSCodium".source = fromRepo "/.config/VSCodium";
    "waybar".source = fromRepo "/.config/waybar";
    "zed".source = fromRepo "/.config/zed";
  };

  home.file = {
    ".clang-format".source = fromRepo "/.clang-format";
    ".clangd".source = fromRepo "/.clangd";
    ".gitconfig".source = fromRepo "/.gitconfig";
    ".ideavimrc".source = fromRepo "/.ideavimrc";
    ".tmux.conf".source = fromRepo "/.tmux.conf";
    ".Xresources".source = fromRepo "/.Xresources";
    ".zshenv".source = fromRepo "/.zshenv";
    ".zshrc".source = fromRepo "/.zshrc";

    ".local/scripts".source = fromRepo "/.local/scripts";

    # Recreate the filesystem layout expected by the shared .zshrc without
    # asking Home Manager to generate a second, divergent shell config.
    ".oh-my-zsh/oh-my-zsh.sh".source = inputs.oh-my-zsh.outPath + "/oh-my-zsh.sh";
    ".oh-my-zsh/lib".source = inputs.oh-my-zsh.outPath + "/lib";
    ".oh-my-zsh/plugins".source = inputs.oh-my-zsh.outPath + "/plugins";
    ".oh-my-zsh/themes".source = inputs.oh-my-zsh.outPath + "/themes";
    ".oh-my-zsh/tools".source = inputs.oh-my-zsh.outPath + "/tools";
    ".oh-my-zsh/custom/plugins/zsh-autosuggestions".source = inputs.zsh-autosuggestions.outPath;
    ".oh-my-zsh/custom/plugins/fast-syntax-highlighting".source = inputs.fast-syntax-highlighting.outPath;
    ".oh-my-zsh/custom/themes/my_ys.zsh-theme".source = fromRepo "/setup/my_ys.zsh-theme";
  };
}
