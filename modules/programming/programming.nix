{ config, pkgs, ... }:

# Ambiente fullstack. Pacotes de usuário via Home Manager.
# Serviços de sistema (docker, podman) são habilitados no configuration.nix,
# não aqui — essas opções não existem no namespace do Home Manager.

{
  home.packages = with pkgs; [
    # Gerenciamento de ambientes
    direnv
    nix-direnv

    # Editores
    vscode
    tmux

    # Controle de versão
    git
    git-lfs
    gh

    # Frontend
    nodejs_20
    yarn
    pnpm

    # Backend / linguagens
    python311
    python311Packages.pip
    php
    ruby
    openjdk17
    rustc
    cargo
    go

    # Bancos de dados (clientes; os servidores rodam como serviços do sistema)
    postgresql
    sqlite

    # Ferramentas de rede/debug
    curl
    httpie
    postman
    gdb

    # Formatters / LSPs
    pyright
    ruff
    black
    prettier
    typescript-language-server
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      tree-sitter
    ];
  };
}
