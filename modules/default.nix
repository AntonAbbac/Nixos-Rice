{ config, pkgs, ... }:
{
  imports = [
    ./desktop/hyprland
    ./programs/terminal/kitty
    ./desktop/hyprland/programs/dunst
    ./desktop/hyprland/programs/rofi
    ./desktop/hyprland/programs/waybar
    ./programming
    #./programs/browser/librewolf/default.nix
  ];

 home.stateVersion = "25.11";

}
