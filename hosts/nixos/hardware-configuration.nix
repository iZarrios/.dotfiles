{ lib, ... }:

{
  # This deliberately prevents deploying another machine's disk UUIDs or GPU
  # assumptions. Replace this entire file with the one generated on the laptop:
  #
  #   cp /etc/nixos/hardware-configuration.nix \
  #     /home/nixos/.dotfiles/hosts/nixos/hardware-configuration.nix
  assertions = [
    {
      assertion = false;
      message = ''
        hosts/nixos/hardware-configuration.nix is a safety placeholder.
        Replace it with the file generated on the new laptop before building.
      '';
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
