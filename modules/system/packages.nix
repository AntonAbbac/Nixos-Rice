{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wget
    unzip
    zip
    obsidian
    proton-pass
    proton-vpn
    protonmail-desktop
    proton-authenticator
    rclone
    syncthing
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  nixpkgs.config.allowUnfree = true;
}
