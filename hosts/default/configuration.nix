# System-level NixOS configuration.
# Rebuild with: sudo nixos-rebuild switch --flake /home/nix/.dotfiles#nixos
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ── Boot ────────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Networking ──────────────────────────────────────────────────────────
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ── Locale & Time ──────────────────────────────────────────────────────
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

  # ── Nix Settings ────────────────────────────────────────────────────────
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # ── Graphics / NVIDIA ──────────────────────────────────────────────────
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

  # ── Fonts ───────────────────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];

  # ── Desktop Environment ────────────────────────────────────────────────
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = false;
  programs.hyprland.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ── Qt / KDE theming ───────────────────────────────────────────────────
  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  # ── Audio (PipeWire) ───────────────────────────────────────────────────
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ── Printing ───────────────────────────────────────────────────────────
  services.printing.enable = true;

  # ── Zsh (system-wide) ──────────────────────────────────────────────────
  # Must be enabled at the system level so NixOS registers it as a valid login shell.
  programs.zsh.enable = true;

  # ── Docker ─────────────────────────────────────────────────────────────
  virtualisation.docker.enable = true;

  # ── Firefox ────────────────────────────────────────────────────────────
  programs.firefox.enable = true;

  # ── User Account ───────────────────────────────────────────────────────
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

  # ── System Packages ────────────────────────────────────────────────────
  # User-level tools (neovim, ripgrep, lazygit, etc.) live in home.nix.
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  # Only system-wide essentials go here.
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    ffmpeg
    htop
    kitty
    wofi
    networkmanagerapplet
    brave
    waybar

    kdePackages.systemsettings
    kdePackages.qqc2-desktop-style
    kdePackages.dolphin
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.kirigami
    kdePackages.kcmutils
  ];

  # ── Tailscale ──────────────────────────────────────────────────────────
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

  # Faster boot — don't wait for network online with VPN
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # ── Misc ───────────────────────────────────────────────────────────────
  system.stateVersion = "25.11";
}
