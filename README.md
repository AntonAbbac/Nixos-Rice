# NixOS Rice — versão atualizada

Reconstrução do rice antigo (`NixOS-Rice-main.zip`), corrigindo o que estava
quebrado e trocando pra um tema coeso: **Catppuccin Mocha** em tudo
(Hyprland, Waybar, Kitty, Dunst, Rofi).

## O que estava quebrado no rice original

- **Imports com `~`**: `index-modules.nix` e `waybar/default.nix` usavam
  `~/.config/home/modules/...`. O Nix não expande `~` — isso quebrava o
  build. Trocado por caminhos relativos (`./hypr/hyprland.nix`).
- **`animations { enabled = yes, please :) }`**: sintaxe inválida do
  Hyprland (era brincadeira em alguma dotfile copiada). Corrigido pra
  `enabled = yes`.
- **`dusnt.nix` (nome errado) e `alacritty.nix`**: estavam vazios, não
  faziam nada. Dunst agora tem config de verdade; Alacritty foi removido
  (você usa Kitty).
- **`programming.nix` misturava NixOS e Home Manager**: opções como
  `virtualisation.docker.enable` e `nix.settings.experimental-features`
  são do NixOS (system-level), não existem no namespace do Home Manager.
  Docker/Podman e flakes agora estão no `configuration.nix`; só os pacotes
  de usuário (linguagens, editores, git) ficam em `programming.nix`.
- **Waybar referenciava módulos que não existiam** (`power-menu`,
  `custom/notificantion` com erro de digitação). Removidos; a barra ficou
  mais enxuta mas 100% funcional.
- **`kubernetes` e outros pacotes duvidosos** removidos da lista fullstack
  — se precisar do cliente `kubectl`, é melhor adicionar sob demanda.

## Estrutura

```
flake.nix                  # trava as versões de nixpkgs e home-manager
flake.lock                 # gerado por você (nix flake lock) — não incluso aqui
configuration.nix          # sistema (boot, rede, Docker, fontes)
home.nix                   # entrada do Home Manager, importa modules/
modules/
  index-modules.nix        # agrega todos os módulos de usuário
  hypr/hyprland.nix        # Hyprland: binds, animações, autostart
  waybar/waybar.nix        # barra (config + estilo no mesmo arquivo)
  kitty/kitty.nix          # terminal, tema Catppuccin Mocha
  dunst/dunst.nix          # notificações, mesmo tema
  rofi/rofi.nix            # launcher, mesmo tema
  programming/programming.nix  # pacotes de dev (Home Manager)
  zsh/zsh.nix              # shell: aliases, plugins, prompt (Starship)
wallpapers/
  wallpaper.png            # Firewatch (noite), do rice original
```

## Migração para flakes

Esta config usa **flakes** em vez do modo clássico de channels. A diferença
prática: antes, o `home-manager` era baixado via `builtins.fetchTarball` no
`configuration.nix` — isso significa que a cada rebuild ele podia trazer uma
versão nova (foi o que causou os erros de `nodePackages` e `du-dust`
removidos: o nixpkgs mudou por baixo dos seus pés).

Com flakes, o `flake.nix` declara exatamente qual branch/release de
`nixpkgs` e `home-manager` usar, e o `flake.lock` (gerado no primeiro
`nix flake lock`) trava o commit exato. Nada muda sozinho — você só
atualiza quando roda `nix flake update` de propósito.

## Zsh

`modules/zsh/zsh.nix` configura:

- **Starship** como prompt (git branch/status, versão de node/python/rust/go,
  contexto docker).
- **autosuggestions** e **syntax highlighting** (sugestões conforme digita,
  cores pra comandos válidos/inválidos).
- **Ferramentas modernas** substituindo as clássicas via alias: `eza` (ls),
  `bat` (cat), `ripgrep` (grep), `fd` (find), `dust` (du), `procs` (ps),
  `zoxide` (navegação por frequência — `z nome-da-pasta` pula direto pra
  qualquer pasta visitada antes).
- **fzf** integrado: `Ctrl+R` busca no histórico, `Ctrl+T` busca arquivos
  com preview (usando bat/eza).
- **Aliases de atalho** pra git, docker, npm/yarn/pnpm, NixOS/Home Manager
  (`rebuild`, `nix-clean`, etc).
- **Funções**: `mkcd` (mkdir + cd), `extract` (descompacta qualquer formato
  detectando sozinho), `gcp "msg"` (commit + push), `gclone url` (clone +
  entra na pasta), `killport 3000`, `bak arquivo`, `cdf arquivo.txt` (entra
  na pasta do arquivo).

O zsh é definido como shell padrão do usuário `anton` no `configuration.nix`
(`users.users.anton.shell = pkgs.zsh`) — depois do rebuild, pode ser
necessário logout/login pra valer.

## Como instalar

1. Copie `flake.nix`, `configuration.nix`, `home.nix`, `modules/` e
   `wallpapers/` para `/etc/nixos/` (mantendo a mesma estrutura de pastas —
   os `imports` usam caminhos relativos).
2. Confira se `./hardware-configuration.nix` já existe em `/etc/nixos/`
   (é gerado pelo instalador, não mexemos nele — o `flake.nix` não precisa
   listá-lo, pois ele já é importado dentro do `configuration.nix`).
3. Dentro de `/etc/nixos/`, gere o arquivo de trava (só precisa fazer isso
   uma vez, ou quando quiser atualizar as versões depois):
   ```bash
   sudo nix flake lock
   ```
   Isso cria o `flake.lock`, baixando e travando os hashes exatos de
   nixpkgs e home-manager.
4. Rode:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#nixos
   ```
   O `#nixos` no final é o nome da configuração declarada em
   `flake.nix` (`nixosConfigurations.nixos`) — se você trocar o
   `networking.hostName` para outro valor, não precisa mudar isso: o
   nome depois do `#` é só o rótulo da configuração no flake, não o
   hostname da máquina.
5. Faça logout/reboot e selecione a sessão Hyprland no seu display
   manager (ou rode `Hyprland` direto do TTY se não tiver um).

### Atualizando depois

Para atualizar nixpkgs/home-manager para versões mais novas (de propósito,
quando você quiser):
```bash
cd /etc/nixos
sudo nix flake update
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

## Coisas que você pode querer ajustar

- **Docker/Podman fullstack**: deixei os dois habilitados
  (`virtualisation.docker.enable` e `.podman.enable`). Normalmente só se
  usa um dos dois — me avisa se quiser remover algum.
- **Bancos de dados**: só deixei os *clientes* (postgresql, sqlite) no
  Home Manager. Se quiser os *servidores* rodando localmente
  (postgres, mongo, redis como serviços), isso é configuração de sistema
  (`services.postgresql.enable`, etc.) — posso adicionar se precisar.
- **Teclado**: mantive `br`/`abnt2` como no original. Ajuste em
  `modules/hypr/hyprland.nix` (`kb_variant`) se não for ABNT2.
- **Wallpaper**: troquei o autostart pra usar `swww` (mais moderno que
  `hyprpaper`, com transições suaves). Troque o arquivo em
  `wallpapers/wallpaper.png` por outro se quiser mudar a imagem sem mexer
  no código.
- **Bateria no Waybar**: adicionado o módulo `battery`. Em desktops sem
  bateria, o Waybar detecta a ausência e simplesmente não mostra o módulo
  — não é erro.
