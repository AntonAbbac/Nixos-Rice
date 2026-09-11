{
  description = "Configuração NixOS — Hyprland + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    mkHost = {hostname}:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};

        modules = [
          ./hosts/${hostname}/configuration.nix

          inputs.nix-flatpak.nixosModules.nix-flatpak

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.extraSpecialArgs = {inherit inputs;};

            home-manager.users.anton = import ./modules/anton.nix;
            home-manager.users.miranha = import ./modules/miranha.nix;
          }
        ];
      };
  in {
    nixosConfigurations = {
      nixos = mkHost {hostname = "default";};
    };
  };
}
