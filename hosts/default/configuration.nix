# System-level NixOS configuration.
# Rebuild with: sudo nixos-rebuild switch --flake /home/nix/.dotfiles#nixos
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "100.101.127.25" ];

  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Graphics / NVIDIA
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = false;
  programs.hyprland.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  services.tlp = {
      enable = true;
      settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGYY_PER_POLICY_ON_BAT = "power";
          CPU_ENERGYY_PER_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;
      };
  };
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;

  # Must be enabled at the system level so NixOS registers it as a valid login shell.
  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  programs.firefox.enable = true;
  programs.chromium.enable = true;

  # User Account
  users.users.nix = {
    isNormalUser = true;
    description = "nixos";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "input"
      "video"
    ];
  };

  # System Packages
  # NOTE: user-level tools live in home.nix.
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  # Only system-wide essentials go here.
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    ffmpeg
    alacritty
    networkmanagerapplet
    brightnessctl

    kdePackages.systemsettings
    kdePackages.qqc2-desktop-style
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.kirigami
    kdePackages.kcmutils

    grim
    slurp
    jq
  ];



  # Tailscale
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--operator=nix" ];
  };

  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  systemd.user.services.tailscale-systray = {
      description = "Tailscale System Tray";
      after = [ "graphical-session.target" "tailscaled.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
          ExecStart = "${pkgs.tailscale}/bin/tailscale systray";
          Restart = "on-failure";
      };
  };

  # Faster boot — don't wait for network online with VPN
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  system.stateVersion = "25.11";

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
  fonts.fontconfig = {
      enable = true;
      defaultFonts = {
          monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono CJK KR" ];
          sansSerif = [ "Noto Sans CJK KR" ];
          serif     = [ "Noto Serif CJK KR" ];
      };
  };
}
