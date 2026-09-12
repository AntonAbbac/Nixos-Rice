{
  description = "Configuração NixOS — Hyprland + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
    sysc-greet = {
      url = "github:Nomadcxx/sysc-greet";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: let
    mkHost = {hostname}:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs;};

        modules = [
          ./hosts/${hostname}/configuration.nix
          inputs.sysc-greet.nixosModules.default
          inputs.nix-flatpak.nixosModules.nix-flatpak
          stylix.nixosModules.stylix

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
