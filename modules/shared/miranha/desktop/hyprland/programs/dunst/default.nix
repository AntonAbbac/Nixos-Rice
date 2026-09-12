{pkgs, ...}: {
  home.packages = with pkgs; [
    dunst
    libnotify # Adicione esta linha
  ];
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 300;
        height = "(30, 100)";
        offset = "(10, 40)";
        origin = "top-right";
        transparency = 10;
        corner_radius = 10;
      };

      urgency_low = {
        timeout = 5;
      };

      urgency_normal = {
        timeout = 8;
      };

      urgency_critical = {
        timeout = 0;
      };
    };
  };
}
