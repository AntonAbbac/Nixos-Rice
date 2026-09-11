{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    httpie
    postman
    gdb
  ];
}
