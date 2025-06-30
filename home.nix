{ config, pkgs, ... }:

{
  # Import additional configuration modules
  imports = [
    ./modules/programs/vscode.nix
    ./modules/programs/git.nix
    ./modules/programs/bash.nix
    ./modules/programs/zsh.nix
    ./modules/programs/kitty.nix
    ./modules/programs/neovim-minimal.nix
    ./modules/packages.nix
  ];

  # User configuration
  home.username = "alexdimi";
  home.homeDirectory = "/home/alexdimi";

  # Set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "25.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
