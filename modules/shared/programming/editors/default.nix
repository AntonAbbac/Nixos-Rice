{pkgs, ...}: {
  home.packages = with pkgs; [
    tmux
    zed-editor
  ];
}
