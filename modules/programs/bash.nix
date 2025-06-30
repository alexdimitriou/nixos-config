{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
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
    };
    
    bashrcExtra = ''
      # Custom bash configuration
      export EDITOR="code --wait"
      export BROWSER="google-chrome-stable"
      
      # History settings
      export HISTSIZE=10000
      export HISTFILESIZE=20000
      export HISTCONTROL=ignoreboth
      
      # Better ls colors
      eval "$(dircolors -b)"
    '';
  };
}
