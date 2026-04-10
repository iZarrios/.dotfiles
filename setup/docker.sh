#! /usr/bin/env bash
# set -eux

# install docker
sudo pacman -S --needed docker docker-buildx --noconfirm

# enable and start docker service
sudo systemctl enable --now docker.service

# adding current user to the docker group (so we do not have to use prefix sudo each time we use the `docker` cmd)
sudo usermod -aG docker $USER

sg docker -c "zsh"
