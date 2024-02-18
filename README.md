# This is the dotfiles for my linux enviroment
This directory utilized the GNU `stow` binary

## Installing GNU stow

```bash
sudo apt install stow
```
## Configuring symlinks using stow
**Note: you must put this repo in current user's home directory (/home/USER_NAME eg.. `~`)**

```bash
# you can also use stow --adopt .  
stow .
```
