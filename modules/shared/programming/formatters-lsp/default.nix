{pkgs, ...}: {
  home.packages = with pkgs; [
    pyright
    ruff
    black
    prettier
    typescript-language-server
  ];
}
