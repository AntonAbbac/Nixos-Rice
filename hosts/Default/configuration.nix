
{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # O módulo home-manager para NixOS é importado no flake.nix
    # (via inputs.home-manager.nixosModules.home-manager), não aqui.
    ../../modules/core/default.nix

  ];


  ##############################################################
  # Localization
  ##############################################################

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "pt_BR.UTF-8";

  ##############################################################
  # Desktop: Hyprland (Wayland only, no X11)
  ##############################################################

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Keyboard layout used by Wayland/XWayland apps.
  console.keyMap = "br-abnt2";

  ##############################################################
  # Audio
  ##############################################################

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  ##############################################################
  # Home Manager
  ##############################################################

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.anton = import ../../modules/default.nix;
  };

  ############################
  ##################################
  # Development (containers)
  ##############################################################


  ##############################################################
  # Fonts
  ##############################################################

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  ##############################################################
  # Packages
  ##############################################################
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    foot
    dmenu
    firefox
    unzip
    zip
  ];


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
 # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
