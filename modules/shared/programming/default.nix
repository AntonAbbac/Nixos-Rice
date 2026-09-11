{...}:
# Ambiente fullstack de desenvolvimento (Home Manager).
# Serviços de sistema (docker, podman) são habilitados em
# modules/core/virtualisation.nix, não aqui — essas opções não
# existem no namespace do Home Manager.
#
# Cada categoria vive na sua própria pasta para facilitar
# adicionar/remover ferramentas sem mexer num arquivo gigante.
{
  imports = [
    ./environment
    ./editors
    ./vcs
    ./languages
    ./databases
    ./network-tools
    ./formatters-lsp
  ];
}
