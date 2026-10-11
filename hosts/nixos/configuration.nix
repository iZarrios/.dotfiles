{ username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/laptop.nix
    ../../modules/nixos/services.nix
  ];

  networking.hostName = "nixos";
  time.timeZone = "America/Montreal";

  users.users.${username} = {
    isNormalUser = true;
    description = "NixOS user";
    extraGroups = [
      "audio"
      "bluetooth"
      "docker"
      "input"
      "networkmanager"
      "video"
      "wheel"
    ];
  };

  # Compatibility baseline for a laptop first installed with NixOS 26.05.
  # Set this to the installer release if the first installation uses another
  # release, then leave it unchanged during normal upgrades.
  system.stateVersion = "26.05";
}
