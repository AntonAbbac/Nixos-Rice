{pkgs, ...}: {
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "pt_BR.UTF-8";

  console.keyMap = "br-abnt2";

  nix.settings.trusted-users = ["root" "anton"];

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = ["hyprland" "gtk"];
      };
    };
  };

  # Garante suporte a variáveis D-Bus/PAM e Polkit
  security.polkit.enable = true;
}
