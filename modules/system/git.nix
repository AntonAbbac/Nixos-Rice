_: {
  programs.git = {
    enable = true;
    config.safe.directory = "/etc/dotfiles";
    extraConfig = {
      credential.helper = "store";
    };
  };
  programs.ssh.startAgent = true;
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
    };
  };
}
