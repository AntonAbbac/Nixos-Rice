{pkgs, ...}: {
  home.packages = with pkgs; [
    yarn
    pnpm
  ];
}
