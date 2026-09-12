{...}: {
  services.sysc-greet = {
    enable = true;
    compositor = "cagebreak";

    settings.initial_session = {
      command = "Hyprland";
      user = "anton";
    };
  };
}
