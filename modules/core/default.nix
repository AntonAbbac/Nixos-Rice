{ config, pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./boot.nix
    ./games.nix
  ];
}
