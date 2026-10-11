{ inputs, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
  };

  # The NixOS module also opens the firewall ports required for device
  # discovery, which installing the package alone would not do.
  programs.kdeconnect.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    pulseaudio.enable = false;
    udisks2.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "breeze";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];

    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono CJK KR" ];
      sansSerif = [ "Noto Sans CJK KR" ];
      serif = [ "Noto Serif CJK KR" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    grim
    hyprpaper
    hyprsunset
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.dolphin
    kdePackages.kde-cli-tools
    kdePackages.kio-fuse
    kdePackages.okular
    networkmanagerapplet
    qt6Packages.qt6ct
    slurp
    wl-clipboard
    xdg-desktop-portal-gtk
  ];
}
