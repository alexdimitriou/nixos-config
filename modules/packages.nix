{ config, pkgs, ... }:

{
  # Development packages
  home.packages = with pkgs; [
    # Browsers
    google-chrome

    # Development tools and language servers
    git
    nodejs
    python3
    nil  # Nix language server

    # Fonts for development
    fira-code

    # Nerd Fonts (patched fonts with icons and glyphs)
    nerd-fonts.fira-code

    # Compression tools
    zip
    xz
    unzip
    p7zip

    # System tools
    htop
    tree
    wget
    curl
    jq
  ];
}
