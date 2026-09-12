{pkgs, ...}: {
  environment.shells = [pkgs.zsh];
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    eza # ls
    bat # cat
    zoxide # cd com memória
    fzf # busca fuzzy
    ripgrep # grep
    fd # find
    dust # du
    procs # ps

    git
    lsof
    unzip
    p7zip
    gnutar
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histSize = 50000;
    histFile = "$HOME/.zsh_history";

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      ls = "eza --icons --group-directories-first";
      ll = "eza -lh --icons --group-directories-first";
      la = "eza -lah --icons --group-directories-first";
      lt = "eza -lah --icons --group-directories-first --sort=modified";
      tree = "eza --tree --icons";

      cat = "bat --paging=never";

      grep = "rg";

      find = "fd";

      du = "dust";

      ps = "procs";

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

      d = "docker";
      dc = "docker compose";
      dps = "docker ps";
      dpsa = "docker ps -a";
      dimg = "docker images";
      dlog = "docker logs -f";
      dexec = "docker exec -it";
      dprune = "docker system prune -f";

      rebuild-test = "sudo nixos-rebuild test --flake /etc/dotfiles#nixos";
      hm-news = "home-manager news";
      nix-clean = "sudo nix-collect-garbage -d";
      nix-search = "nix search nixpkgs";
      d-nix = "nix run nixpkgs#deadnix -- --edit /etc/dotfiles";
      stix = "nix run nixpkgs#statix -- fix /etc/dotfiles";
      fmt-nix = "alejandra --write /etc/dotfiles";

      ni = "npm install";
      nr = "npm run";
      nrd = "npm run dev";
      nrb = "npm run build";
      y = "yarn";
      yd = "yarn dev";
      pn = "pnpm";
      pnd = "pnpm dev";

      py = "python3";
      venv = "python3 -m venv .venv";
      activate = "source .venv/bin/activate";

      c = "clear";
      e = "$EDITOR";
      reload = "source ~/.zshrc";
      path = "echo $PATH | tr ':' '\\n'";
      myip = "curl -s ifconfig.me";
      ports = "sudo ss -tulpn";
      weather = "curl -s wttr.in";
    };

    interactiveShellInit = ''
      rebuild() {
        cd /etc/dotfiles && git add -A
        sudo nixos-rebuild switch --flake /etc/dotfiles#''${1:-nixos}
      }
      nixclean() {
        local dir="''${1:-/etc/dotfiles}"

        echo "🧹 Limpando código morto (deadnix)..."
        nix run nixpkgs#deadnix -- --edit "$dir" || return 1

        echo "🔧 Corrigindo antipadrões (statix)..."
        nix run nixpkgs#statix -- fix "$dir" || return 1

        echo "🎨 Formatando (alejandra)..."
        alejandra "$dir" || return 1

        echo "✅ Pronto!"
      }
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_SPACE
      setopt SHARE_HISTORY

      mkcd() {
        mkdir -p "$1" && cd "$1"
      }

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

      gcp() {
        git commit -m "$1" && git push
      }

      gclone() {
        git clone "$1" && cd "$(basename "$1" .git)"
      }

      cdf() {
        if [ -f "$1" ]; then
          builtin cd "$(dirname "$1")"
        else
          builtin cd "$1"
        fi
      }

      psg() {
        procs | rg -i "$1"
      }

      killport() {
        lsof -ti :"$1" | xargs kill -9
      }

      bak() {
        cp "$1" "$1.bak"
      }

      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
      export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
      export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} 2>/dev/null || eza --tree --icons {}'"
    '';
  };

  programs.zoxide = {
    enable = true;
  };

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  programs.starship = {
    enable = true;

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
