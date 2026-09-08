{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./host-packages.nix
    ../../modules/core/default.nix
  ];


  system.stateVersion = "26.05";
}
