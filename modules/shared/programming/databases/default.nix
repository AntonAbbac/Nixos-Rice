{pkgs, ...}: {
  # Apenas clientes; os servidores rodam como serviços do sistema
  # (docker/podman), configurados em modules/core/virtualisation.nix
  home.packages = with pkgs; [
    postgresql
    sqlite
  ];
}
