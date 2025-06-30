# Template System Configuration
{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "template-hostname"; # Change this to your hostname
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "Europe/London"; # Change to your timezone
  i18n.defaultLocale = "en_US.UTF-8";

  # Users
  users.users.alexdimi = { # Change username as needed
    isNormalUser = true;
    description = "Alex Dimitriou";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  # Enable common services
  services.openssh.enable = true;
  
  # Firewall
  networking.firewall.enable = true;

  # NixOS version
  system.stateVersion = "25.05";
}
