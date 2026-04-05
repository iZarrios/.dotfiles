{
  description = "nix's NixOS configuration";

  inputs = {
    # Using nixos-unstable for the latest packages (closer to Arch's rolling model).
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager — manages user-level dotfiles and programs declaratively.
    home-manager = {
      url = "github:nix-community/home-manager";
      # Make home-manager use the same nixpkgs as the system, avoiding duplicate downloads.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }:
  {
    # Define your NixOS system(s) here.
    # "nixos" is the hostname — change it to whatever you set during install.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        # System-level configuration (packages, services, boot, etc.)
        ./hosts/default/configuration.nix

        # Hyprland bleeding-edge — this module overrides the nixpkgs version
        # so `programs.hyprland.enable = true` uses the flake's build.
        hyprland.nixosModules.default

        # Home Manager as a NixOS module — this means `home-manager switch` is
        # part of `nixos-rebuild switch`, so everything stays in sync.
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;   # Use the system-level nixpkgs
          home-manager.useUserPackages = true;  # Install user packages to /etc/profiles
          home-manager.users.nix = import ./hosts/default/home.nix;

          # Pass extra arguments to home.nix if needed later:
          # home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
