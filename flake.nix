{
  description = "Configuração NixOS do anton — Hyprland + Home Manager";

  inputs = {
    # nixos-25.11 é o release estável mais recente no momento desta config.
    # Trocar para "nixos-unstable" se quiser pacotes mais novos (com o
    # trade-off de menos testagem).
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # Garante que o Home Manager usa exatamente o mesmo nixpkgs do
      # sistema, em vez de baixar sua própria cópia — evita duplicação
      # e inconsistência de versões entre system e user packages.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/Default/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
