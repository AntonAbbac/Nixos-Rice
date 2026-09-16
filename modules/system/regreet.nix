{pkgs, ...}: {
  services.greetd.enable = true;

  programs.regreet = {
    enable = true;

    cageArgs = ["-s"];

    extraCss = ''
      window {
        border-radius: 12px;
      }
    '';
  };
}
