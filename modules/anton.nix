{...}: {
  imports = [
    ./shared/anton/desktop/hyprland
    ./shared/anton/desktop/hyprland/programs/kitty
    ./shared/anton/desktop/hyprland/programs/dunst
    ./shared/anton/desktop/hyprland/programs/rofi
    ./shared/anton/desktop/hyprland/programs/waybar
    ./shared/programming/default.nix
  ];

  home.stateVersion = "25.11";
}
