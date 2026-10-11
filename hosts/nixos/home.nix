{ lib, username, ... }:

{
  imports = [
    ../../modules/home/dotfiles.nix
    ../../modules/home/packages.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.activation.createScreenshotDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p /home/${username}/media/screenshots
  '';
}
