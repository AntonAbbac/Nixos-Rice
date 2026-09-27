{pkgs, ...}: let
  workspaceSelector = import ./scripts/workspace_selector.nix {inherit pkgs;};
in {
  imports = [
    ./config.nix
    ./keybindings.nix
    ./services/hypridle.nix
    ./services/wlogout.nix
  ];

  home.packages = with pkgs; [
    workspaceSelector
    hyprland
    hyprpicker
    hypridle
    hyprlock
    waybar
    awww
    grim
    slurp
    wl-clipboard
    cliphist
    brightnessctl
    playerctl
    pamixer
    pavucontrol
    networkmanagerapplet
    wlogout
    swappy
  ];

  programs.hyprlock.enable = true;
}
