{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    foot
    dmenu
    firefox
    unzip
    zip
    obsidian
    proton-pass
    proton-vpn
    protonmail-desktop
    proton-authenticator
    rclone
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  nixpkgs.config.allowUnfree = true;
}
