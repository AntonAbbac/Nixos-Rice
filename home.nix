{ config, pkgs, ... }:

{
  imports = [
    ./modules/index-modules.nix
  ];

  ##############################################################
  # Basic info
  ##############################################################

  home.username = "anton";
  home.homeDirectory = "/home/anton";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  ##############################################################
  # Dotfiles
  ##############################################################

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr/wallpaper.png".source = ./wallpapers/wallpaper.png;
  };

  ##############################################################
  # Environment variables
  ##############################################################

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  ##############################################################
  # Let Home Manager manage itself
  ##############################################################

  programs.home-manager.enable = true;
}
