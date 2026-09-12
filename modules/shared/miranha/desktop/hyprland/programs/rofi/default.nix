{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
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
      };

      element = {
        padding = mkLiteral "6px";
        border-radius = mkLiteral "8px";
      };
    };
  };
}
