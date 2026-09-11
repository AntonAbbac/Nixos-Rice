{pkgs, ...}: {
  home.packages = with pkgs; [
    php
    ruby
  ];
}
