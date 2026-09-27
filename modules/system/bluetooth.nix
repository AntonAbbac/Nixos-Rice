{config, ...}: {
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
