{ pkgs, username, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  security.sudo.wheelNeedsPassword = true;

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
  };

  users.users.${username}.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    curl
    git
    pciutils
    usbutils
    vim
    wget
  ];
}
