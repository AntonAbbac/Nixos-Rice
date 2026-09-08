{ lib, pkgs, ... }:

{

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.anton = import ../../modules/default.nix;
    users.miranha = import ../../modules/default.nix;
  };
  users.users.anton = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "input"
    ]; # Enable `sudo` for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  users.users.miranha = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "input"
    ]; # Enable `sudo` for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };
}
