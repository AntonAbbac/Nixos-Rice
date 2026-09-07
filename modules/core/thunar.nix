{ lib, config, pkgs, ... }:
{
  programs.xfconf.enable = true;
  programs.thunar.enable = true;
  services.gvfs.enable = true;
}
