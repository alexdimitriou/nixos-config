{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Alex Dimitriou";
    userEmail = "alex.dimitriou@icloud.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "code --wait";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      visual = "!gitk";
    };
  };
}
