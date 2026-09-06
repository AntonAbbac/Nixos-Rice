{ config, pkgs, ... }:

{
  imports = [
    ./hypr/hyprland.nix
    ./kitty/kitty.nix
    ./dunst/dunst.nix
    ./rofi/rofi.nix
    ./waybar/waybar.nix
    ./programming/programming.nix
    ./zsh/zsh.nix
  ];
}
