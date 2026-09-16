_: {
  programs.git = {
    enable = true;
    config.safe.directory = "/etc/dotfiles";
    extraConfig = {
      credential.helper = "store";
    };
  };
}
