{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wget
    unzip
    zip
    obsidian
    gh
    proton-pass
    proton-vpn
    protonmail-desktop
    proton-authenticator
    rclone
    syncthing
    librewolf
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  nixpkgs.config.allowUnfree = true;
}
