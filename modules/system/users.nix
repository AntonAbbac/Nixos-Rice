{pkgs, ...}: {
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
