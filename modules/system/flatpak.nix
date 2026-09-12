{inputs, ...}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
  services.flatpak = {
    enable = true;
    packages = [
      "io.gitlab.librewolf-community"
    ];
  };
}
