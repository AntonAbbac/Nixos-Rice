# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
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
  ];

  ##############################################################
  # Boot
  ##############################################################

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    efiInstallAsRemovable = true;
  };
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  ##############################################################
  # Swap
  ##############################################################

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024; # 8GB — dá folga suficiente pra builds pesados com 4GB de RAM
    }
  ];

  ##############################################################
  # Networking
  ##############################################################

  # networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  ##############################################################
  # Users
  ##############################################################

  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.anton = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "input"
    ]; # Enable `sudo` for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

    users.users.miranha = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "input"
    ]; # Enable `sudo` for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  # Precisa estar habilitado no nível do sistema para o zsh ser registrado
  # em /etc/shells — senão o `shell = pkgs.zsh` acima falha silenciosamente
  # ou o login não aceita o shell. A configuração de verdade (aliases,
  # plugins, prompt) vem do Home Manager em modules/zsh/zsh.nix.
  programs.zsh.enable = true;

  ##############################################################
  # Home Manager
  ##############################################################

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.anton = import ./home.nix;
  };

  ##############################################################
  # Development (containers)
  ##############################################################

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };
  virtualisation.podman.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
  # Note: kitty, rofi and waybar are installed via the Home Manager module
  # (./modules) instead of here, since Home Manager also writes their configs.

  # Thunar (file manager referenced in the Hyprland config, $fileManager).
  programs.xfconf.enable = true;
  programs.thunar.enable = true;
  services.gvfs.enable = true; # trash, network mounts, etc. for Thunar

  ##############################################################
  # Programs & services
  ##############################################################

  # programs.firefox.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  ##############################################################
  # State version
  ##############################################################

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
