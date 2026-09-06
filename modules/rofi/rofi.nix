{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral "#1e1e2e";
        bg-alt = mkLiteral "#313244";
        fg = mkLiteral "#cdd6f4";
        accent = mkLiteral "#cba6f7";

        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@fg";
        border-color = mkLiteral "@accent";
      };

      window = {
        width = mkLiteral "480px";
        border = mkLiteral "2px";
        border-radius = mkLiteral "12px";
        padding = mkLiteral "8px";
      };

      inputbar = {
        padding = mkLiteral "8px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@bg-alt";
      };

      element = {
        padding = mkLiteral "6px";
        border-radius = mkLiteral "8px";
      };

      "element selected" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg";
      };
    };
  };
}
