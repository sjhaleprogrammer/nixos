#!/bin/sh

# Define the path to your flake.nix file
FLAKE_PATH="/etc/nixos/"

# Update the flake
nix flake update --flake "$FLAKE_PATH"

# Run the NixOS rebuild with a graphical password prompt
sudo nixos-rebuild switch --flake "$FLAKE_PATH#GV302XI"

# Run the home-manager rebuild as samuel
sudo -u  samuel home-manager switch --flake "$FLAKE_PATH#samuel"

# Collect garbage to free up disk space
nix-collect-garbage -d

