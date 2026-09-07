{ lib, config, ... }:

{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
    services.openssh.enable = true;
}
