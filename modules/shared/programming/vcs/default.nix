{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    git-lfs
    gh
  ];
}
