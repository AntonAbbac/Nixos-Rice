{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };
  virtualisation.podman.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
