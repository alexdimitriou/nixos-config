{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Oh My Zsh configuration
    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      plugins = [
        "git"
        "docker"
        "kubectl"
        "npm"
        "node"
        "python"
        "rust"
        "golang"
        "history"
        "colored-man-pages"
        "command-not-found"
        "sudo"
        "z"
        "extract"
        "web-search"
        "copyfile"
        "copybuffer"
        "dirhistory"
      ];
    };
    
    # Custom aliases
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      
      # System management
      rebuild = "sudo nixos-rebuild switch --flake .#lexbookduo";
      update = "nix flake update";
      clean = "sudo nix-collect-garbage -d";
      
      # Development
      code = "code";
      vim = "nvim";
      
      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      gco = "git checkout";
      gb = "git branch";
      
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      
      # System info
      df = "df -h";
      du = "du -h";
      free = "free -h";
      
      # Network
      ping = "ping -c 5";
      ports = "netstat -tulanp";
    };
    
    # Environment variables
    sessionVariables = {
      EDITOR = "code --wait";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      
      # Development
      GOPATH = "$HOME/go";
      CARGO_HOME = "$HOME/.cargo";
      
      # History
      HISTSIZE = "10000";
      SAVEHIST = "10000";
      HISTFILE = "$HOME/.zsh_history";
    };
    
    # Additional zsh configuration
    initContent = ''
      # Better history search
      bindkey '^R' history-incremental-search-backward
      bindkey '^S' history-incremental-search-forward
      
      # Better completion
      setopt AUTO_CD
      setopt GLOB_COMPLETE
      setopt AUTO_LIST
      setopt AUTO_MENU
      setopt AUTO_PARAM_SLASH
      setopt COMPLETE_IN_WORD
      
      # History settings
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_SPACE
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_REDUCE_BLANKS
      setopt HIST_VERIFY
      setopt SHARE_HISTORY
      setopt APPEND_HISTORY
      setopt INC_APPEND_HISTORY
      
      # Directory navigation
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS
      setopt PUSHD_MINUS
      
      # Better ls colors
      eval "$(dircolors -b)"
      
      # Powerlevel10k instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      
      # Load p10k configuration
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      
      # Custom functions
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      # Extract function
      extract() {
        if [ -f "$1" ]; then
          case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.deb)       ar x "$1"        ;;
            *.tar.xz)    tar xf "$1"      ;;
            *.tar.zst)   unzstd "$1"      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }
    '';
  };
  
  # Install additional packages needed for Oh My Zsh themes and plugins
  home.packages = with pkgs; [
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    fzf
    eza  # Modern replacement for ls
    bat  # Modern replacement for cat
    ripgrep  # Modern replacement for grep
    fd   # Modern replacement for find
    tree
    htop
    neofetch
  ];

  # Powerlevel10k configuration file
  home.file.".p10k.zsh".text = ''
    # Powerlevel10k configuration
    # This file is automatically sourced by zsh when powerlevel10k is loaded

    # Enable instant prompt for faster startup
    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi

    # Basic configuration for powerlevel10k
    typeset -g POWERLEVEL9K_MODE=nerdfont-complete
    typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
    typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}❯%f "

    # Left prompt elements
    typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      dir
      vcs
      newline
    )

    # Right prompt elements
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
      status
      command_execution_time
      background_jobs
      virtualenv
      context
      time
    )

    # Directory configuration
    typeset -g POWERLEVEL9K_DIR_FOREGROUND=blue
    typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=blue
    typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=blue
    typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

    # Git configuration
    typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=green
    typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=yellow
    typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=magenta

    # Time configuration
    typeset -g POWERLEVEL9K_TIME_FOREGROUND=gray
    typeset -g POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"

    # Status configuration
    typeset -g POWERLEVEL9K_STATUS_OK=false
    typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=red

    # Command execution time
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=yellow

    # Context configuration (user@hostname)
    typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=gray
    typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%n@%m"
  '';
}
