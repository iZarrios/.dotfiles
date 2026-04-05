# Dotfiles — NixOS + Home Manager

Declarative system and user configuration for NixOS, managed with [Flakes](https://nixos.wiki/wiki/Flakes) and [Home Manager](https://github.com/nix-community/home-manager).

> Previously this repo used GNU Stow + imperative shell scripts. See the `main` branch for that version.

## Structure

```
.dotfiles/
├── flake.nix                          # Entry point — defines inputs and system config
├── hosts/
│   └── default/
│       ├── configuration.nix          # System-level: boot, networking, Docker, users
│       ├── home.nix                   # User-level: packages, shell, dotfile symlinks
│       └── hardware-configuration.nix # Machine-specific (copy yours in — see below)
├── .config/                           # App configs (nvim, hypr, alacritty, etc.)
├── .local/scripts/                    # Personal scripts (tmux-sessionizer, etc.)
├── .tmux.conf                         # Tmux config (sourced by programs.tmux)
├── .clang-format, .clangd, ...        # Other dotfiles (symlinked by Home Manager)
└── setup/                             # DEPRECATED — replaced by home.nix packages
```

## Fresh NixOS Install

### 1. Install NixOS

Boot the NixOS ISO and follow the [installation guide](https://nixos.org/manual/nixos/stable/#sec-installation).

### 2. Clone this repo

```bash
git clone https://github.com/izarrios/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git checkout nix
```

### 3. Copy your hardware configuration

The installer generates a machine-specific `hardware-configuration.nix`. Copy it in:

```bash
cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/hosts/default/
```

### 4. Adjust settings

Edit `hosts/default/configuration.nix` and update:

- `networking.hostName` — your machine's hostname
- `time.timeZone` — your timezone
- `system.stateVersion` — must match the NixOS version you installed
- Boot loader settings — uncomment/adjust if different from the defaults
- GPU drivers — if you have NVIDIA, uncomment the nvidia lines

### 5. Build and switch

```bash
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos
```

> **Note:** If your hostname is not `nixos`, change the `#nixos` part to match `nixosConfigurations.<your-hostname>` in `flake.nix`.

## Day-to-Day Usage

### Apply configuration changes

After editing any `.nix` file or dotfile:

```bash
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos
```

### Update all packages

```bash
# Update flake inputs (nixpkgs, home-manager) to latest
nix flake update --flake ~/.dotfiles

# Rebuild with the updated packages
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos
```

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

## What Replaces What

| Old (Stow + scripts)         | New (NixOS + Home Manager)                     |
| ---------------------------- | ---------------------------------------------- |
| `stow .`                     | `nixos-rebuild switch --flake ...`              |
| `setup/alacritty.sh`         | `home.packages = [ alacritty ]`                |
| `setup/neovim.sh`            | `home.packages = [ neovim ]`                   |
| `setup/docker.sh`            | `virtualisation.docker.enable = true`          |
| `setup/zsh.sh`               | `programs.zsh.oh-my-zsh.enable = true`         |
| `setup/go.sh`                | `home.packages = [ go gopls ]`                 |
| `setup/node.sh`              | `home.packages = [ nodejs ]`                   |
| `setup/lazygit.sh`           | `home.packages = [ lazygit ]`                  |
| `setup/ripgrep.sh`           | `home.packages = [ ripgrep ]`                  |
| `setup/btop.sh`              | `home.packages = [ btop ]`                     |
| `setup/lua.sh`               | `home.packages = [ lua ]`                      |
| `setup/lua-lsp.sh`           | `home.packages = [ lua-language-server ]`      |
| `setup/ghostty.sh`           | `home.packages = [ ghostty ]`                  |
| `setup/get-pip.sh`           | `home.packages = [ python3 ]` + virtualenvs    |
| `.stow-local-ignore`         | Not needed — Home Manager is opt-in             |
| `~/custom_build/*`           | Not needed — Nix builds everything              |
| Manual PATH in `.zshenv`     | `home.sessionPath` + auto PATH from Nix        |

## Secrets

API keys and tokens go in `~/secret.zsh` (not tracked by git). It is sourced automatically with a guard so the shell won't error if the file is missing.
