# Dotfiles (NixOS + Stow) system configuration

Declarative system and user configuration for NixOS, managed with [Flakes](https://nixos.wiki/wiki/Flakes) and [Home Manager](https://github.com/nix-community/home-manager).

> This repo serves **two systems**: an Arch Linux setup (using GNU Stow + shell scripts) and a NixOS setup (using Flakes + Home Manager). Both share the same dotfiles.

## Structure

```
.dotfiles/
├── flake.nix                          # Entry point — inputs (nixpkgs, home-manager, hyprland)
├── flake.lock                         # Pinned input versions for reproducible builds
├── hosts/
│   └── default/
│       ├── configuration.nix          # System-level: boot, networking, GPU, Docker, users
│       ├── home.nix                   # User-level: packages, shell, dotfile symlinks
│       └── hardware-configuration.nix # Machine-specific (copy yours in — see below)
├── .config/                           # App configs symlinked by Home Manager (see below)
├── .local/scripts/                    # Personal scripts (tmux-sessionizer)
├── .tmux.conf                         # Tmux config (sourced by programs.tmux)
├── .clang-format, .clangd, ...        # Other dotfiles (symlinked by Home Manager)
├── setup/                             # Install scripts (used on Arch)
├── fixes/                             # Troubleshooting notes
└── ide_settings/                      # IDE settings (VS Code)
```

## Fresh NixOS Install

### 1. Install NixOS

Boot the NixOS ISO and follow the [installation guide](https://nixos.org/manual/nixos/stable/#sec-installation).

### 2. Clone this repo

```bash
git clone https://github.com/izarrios/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 3. Copy your hardware configuration

The installer generates a machine-specific `hardware-configuration.nix`. Copy it in:

```bash
cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/hosts/default/
```

### 4. Update the username

The repo is hardcoded to a user named `nix`. To use your own username, update these locations:

- `home-manager.users.nix` in `flake.nix`
- `users.users.nix` in `hosts/default/configuration.nix`
- `home.username` and `home.homeDirectory` in `hosts/default/home.nix`
- `--operator=nix` in `services.tailscale.extraUpFlags` (in `configuration.nix`)

### 5. Adjust settings

Edit `hosts/default/configuration.nix` and update:

- `networking.hostName` — your machine's hostname
- `time.timeZone` — your timezone
- `system.stateVersion` — must match the NixOS version you installed
- Boot loader settings — adjust if different from the defaults
- **GPU drivers** — this repo ships with Intel + NVIDIA PRIME offload enabled. Adjust or remove the `hardware.nvidia` block and PCI bus IDs (`intelBusId`, `nvidiaBusId`) for your hardware

### 6. Build and switch

```bash
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos
```

> **Note:** The `#nixos` target matches `nixosConfigurations.nixos` in `flake.nix`. If you rename that attribute (e.g. to match a different hostname), update the rebuild command accordingly. Note that `networking.hostName` and the flake output name are **independent settings** — changing one does not change the other.

## Day-to-Day Usage

### Apply configuration changes

After editing any `.nix` file or dotfile:

```bash
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos
```

### Update all packages

```bash
# Update flake inputs (nixpkgs, home-manager, hyprland) to latest
nix flake update --flake ~/.dotfiles

# Rebuild with the updated packages
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos
```

> Commit `flake.lock` after updating if you want to keep the pinned versions.

### Test changes without committing them to the system profile

```bash
sudo nixos-rebuild test --flake ~/.dotfiles#nixos
```

### Roll back to a previous generation

```bash
# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Roll back to the previous one
sudo nixos-rebuild switch --rollback
```

## Arch Linux Setup

### stow

```bash
stow .
```

This symlinks all dotfiles (`.config/`, `.tmux.conf`, `.gitconfig`, etc.) into your home directory.


## Secrets

API keys and tokens go in `~/secret.zsh` (not tracked by git). It is sourced automatically with a guard so the shell won't error if the file is missing.
