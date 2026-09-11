{...}: {
  imports = [
    ./hardware-configuration.nix
    ./host-packages.nix
    ../../modules/system/default.nix
  ];

  system.stateVersion = "26.05";
}
