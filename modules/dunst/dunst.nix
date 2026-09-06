{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 300;
        height = 100;
        offset = "10x40";
        origin = "top-right";
        transparency = 10;
        frame_color = "#cba6f7";
        font = "JetBrainsMono Nerd Font 10";
        corner_radius = 10;
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 5;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 8;
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#f38ba8";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}
