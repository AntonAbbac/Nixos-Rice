{ pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    efiInstallAsRemovable = true;
  };
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024; # 8GB — dá folga suficiente pra builds pesados com 4GB de RAM
    }
  ];

}
