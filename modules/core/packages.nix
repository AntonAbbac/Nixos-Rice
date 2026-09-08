{ lib, pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    foot
    dmenu
    firefox
    unzip
    zip
    obsidian
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
    "librewolf-152.0.2-1"
    "librewolf-unwrapped-152.0.2-1"
  ];
  nixpkgs.config.allowUnfree = true;


}
