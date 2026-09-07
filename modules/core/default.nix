{ config, pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./boot.nix
    ./games.nix
    ./users.nix
    ./network.nix
    ./thunar.nix
    ./virtualisation.nix
    ./fonts.nix
    ./services.nix
    ./packages.nix
  ];
}
