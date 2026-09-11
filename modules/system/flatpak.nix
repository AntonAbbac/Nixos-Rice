{inputs, ...}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
  services.flatpak = {
    enable = true;
    packages = [
      "io.gitlab.librewolf-community"
      "com.spotify.Client"
      "org.signal.Signal"
    ];
  };
}
