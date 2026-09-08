{
  description = "Configuração NixOS — Hyprland + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    # URL oficial e funcional do nix-flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, ... }@inputs:
    let
      mkHost = { hostname, username }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          # Passamos o inputs e o username para os módulos do NixOS
          specialArgs = { inherit inputs username; };

          modules = [
            ./hosts/${hostname}/configuration.nix

            # Módulo do nix-flatpak importado
            inputs.nix-flatpak.nixosModules.nix-flatpak

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";

              # Passamos o inputs e o username para os módulos do Home Manager
              home-manager.extraSpecialArgs = { inherit inputs username; };

              home-manager.users.${username} = import ./modules/default.nix;
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nixos = mkHost { hostname = "Default"; username = "anton"; };
        outro-pc = mkHost { hostname = "outro-pc"; username = "miranha"; };
      };
    };
}
