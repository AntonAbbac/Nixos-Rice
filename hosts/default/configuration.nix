{...}: {
  imports = [
    ./hardware-configuration.nix
    ./host-packages.nix
    ../../modules/system/default.nix
    ../../modules/themes/unsent-letters/default.nix
  ];

  system.stateVersion = "26.05";
}
