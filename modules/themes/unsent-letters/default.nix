{pkgs, ...}: {
  stylix = {
    enable = true;

    base16Scheme = {
      base00 = "0d1821";
      base01 = "111e2b";
      base02 = "162435";
      base03 = "1c2d40";
      base04 = "243448";
      base05 = "ddeeff";
      base06 = "c8e8ff";
      base07 = "ffffff";

      base08 = "f08080";
      base09 = "f0d87a";
      base0A = "f0d87a";
      base0B = "80e8c0";
      base0C = "7de8d8";
      base0D = "a8d8f0";
      base0E = "b8a0f0";
      base0F = "c8e8ff";
    };
    polarity = "dark";
    image = ../../themes/wallpapers/firewatch.png;
    opacity = {
      terminal = 0.85;
      popups = 0.90;
      applications = 1.0;
    };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };
  };
}
