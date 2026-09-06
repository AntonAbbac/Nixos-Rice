{ config, pkgs, ... }:

{
  ##############################################################
  # Ferramentas modernas de CLI (substitutas das clássicas)
  ##############################################################

  home.packages = with pkgs; [
    eza          # ls
    bat          # cat
    zoxide       # cd (com memória de diretórios frequentes)
    fzf          # busca fuzzy (histórico, arquivos)
    ripgrep      # grep
    fd           # find
    dust         # du (uso de disco)
    procs        # ps
  ];

  ##############################################################
  # Zsh
  ##############################################################

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    # ------------------------------------------------------------
    # Aliases
    # ------------------------------------------------------------
    shellAliases = {
      # Navegação
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # ls -> eza
      ls = "eza --icons --group-directories-first";
      ll = "eza -lh --icons --group-directories-first";
      la = "eza -lah --icons --group-directories-first";
      lt = "eza -lah --icons --group-directories-first --sort=modified";
      tree = "eza --tree --icons";

      # cat -> bat
      cat = "bat --paging=never";

      # grep -> ripgrep
      grep = "rg";

      # find -> fd
      find = "fd";

      # du -> dust
      du = "dust";

      # ps -> procs
      ps = "procs";

      # Git — os mais usados no dia a dia
      g = "git";
      gs = "git status -sb";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -m";
      gca = "git commit --amend";
      gp = "git push";
      gpl = "git pull";
      gco = "git checkout";
      gcb = "git checkout -b";
      gb = "git branch";
      gd = "git diff";
      gds = "git diff --staged";
      gl = "git log --oneline --graph --decorate -20";
      gla = "git log --oneline --graph --decorate --all";
      glast = "git log -1 HEAD";
      gundo = "git reset --soft HEAD~1";
      gstash = "git stash";
      gpop = "git stash pop";

      # Docker
      d = "docker";
      dc = "docker compose";
      dps = "docker ps";
      dpsa = "docker ps -a";
      dimg = "docker images";
      dlog = "docker logs -f";
      dexec = "docker exec -it";
      dprune = "docker system prune -f";

      # NixOS / Home Manager
      rebuild = "sudo nixos-rebuild switch";
      rebuild-test = "sudo nixos-rebuild test";
      hm-news = "home-manager news";
      nix-clean = "sudo nix-collect-garbage -d";
      nix-search = "nix search nixpkgs";

      # Node/JS
      ni = "npm install";
      nr = "npm run";
      nrd = "npm run dev";
      nrb = "npm run build";
      y = "yarn";
      yd = "yarn dev";
      pn = "pnpm";
      pnd = "pnpm dev";

      # Python
      py = "python3";
      venv = "python3 -m venv .venv";
      activate = "source .venv/bin/activate";

      # Utilitários
      c = "clear";
      e = "$EDITOR";
      reload = "source ~/.zshrc";
      path = "echo $PATH | tr ':' '\\n'";
      myip = "curl -s ifconfig.me";
      ports = "sudo ss -tulpn";
      weather = "curl -s wttr.in";
    };

    # ------------------------------------------------------------
    # Funções e "aliases inteligentes" (dependem de argumento/contexto)
    # ------------------------------------------------------------
    initContent = ''
      # mkdir + cd num comando só
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      # Extrai qualquer arquivo compactado, detectando o tipo sozinho
      extract() {
        if [ -f "$1" ]; then
          case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.tar.xz)  tar xJf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "extract: formato não reconhecido: $1" ;;
          esac
        else
          echo "extract: arquivo não encontrado: $1"
        fi
      }

      # git commit + push num comando (gcp "mensagem")
      gcp() {
        git commit -m "$1" && git push
      }

      # git clone e já entra na pasta
      gclone() {
        git clone "$1" && cd "$(basename "$1" .git)"
      }

      # cd inteligente: se o argumento for um arquivo, entra na pasta dele
      # (chamada explícita "cdf", não sobrescreve o cd padrão)
      cdf() {
        if [ -f "$1" ]; then
          builtin cd "$(dirname "$1")"
        else
          builtin cd "$1"
        fi
      }

      # Busca um processo pelo nome e mostra PID
      psg() {
        procs | rg -i "$1"
      }

      # Mata processo pela porta
      killport() {
        lsof -ti :"$1" | xargs kill -9
      }

      # Cria um backup rápido de um arquivo (arquivo.txt -> arquivo.txt.bak)
      bak() {
        cp "$1" "$1.bak"
      }

      # zoxide
      eval "$(zoxide init zsh)"

      # fzf: Ctrl+R (histórico) e Ctrl+T (arquivos) com preview
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
      export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
      export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} 2>/dev/null || eza --tree --icons {}'"
    '';
  };

  ##############################################################
  # Ferramentas usadas pelos aliases/funções acima
  ##############################################################

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  ##############################################################
  # Prompt: Starship
  ##############################################################

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;

      format = ''
        $directory$git_branch$git_status$nodejs$python$rust$golang$docker_context
        $character'';

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      directory = {
        style = "bold cyan";
        truncation_length = 4;
        truncate_to_repo = true;
      };

      git_branch = {
        symbol = " ";
        style = "bold purple";
      };

      git_status = {
        style = "bold yellow";
      };

      nodejs = {
        symbol = " ";
        format = "[$symbol($version )]($style)";
      };

      python = {
        symbol = " ";
        format = "[$symbol($version )]($style)";
      };

      rust = {
        symbol = " ";
      };

      golang = {
        symbol = " ";
      };

      docker_context = {
        symbol = " ";
        only_with_files = true;
      };

      cmd_duration = {
        min_time = 2000;
        format = "took [$duration]($style) ";
      };
    };
  };
}
