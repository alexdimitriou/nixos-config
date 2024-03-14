# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:


# let
#    # Define an overlay that adds the unstable attribute to pkgs
#    addUnstable = self: super: {
#     unstable = import (builtins.fetchTarball {
#      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
#      # Optional: Same as above, include sha256 to pin the version
#     }) { config.allowUnfree = true;  };
#    };

#    nixosHardware = builtins.fetchTarball {
#      url = "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz";
#      # Optional: sha256 can be specified for reproducibility
#    };
# in
{
  # nixpkgs.overlays = [ addUnstable ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # "${nixosHardware}/common/cpu/intel"
      #inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelParams = [ "i915.modeset=1" "i915.enable_rc6=0" ];
  
  networking.hostName = "mars"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Support for nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "el_GR.UTF-8";
    LC_IDENTIFICATION = "el_GR.UTF-8";
    LC_MEASUREMENT = "el_GR.UTF-8";
    LC_MONETARY = "el_GR.UTF-8";
    LC_NAME = "el_GR.UTF-8";
    LC_NUMERIC = "el_GR.UTF-8";
    LC_PAPER = "el_GR.UTF-8";
    LC_TELEPHONE = "el_GR.UTF-8";
    LC_TIME = "el_GR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome = {
  #   enable = true;
  #   extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
  #   extraGSettingsOverrides = ''
  #     [org.gnome.mutter]
  #     experimental-features=['scale-monitor-framebuffer']
  #   '';
  # };

  # Enable KDE Plasma6 Desktop Environment
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;

  # Exclude gnome apps
  # environment.gnome.excludePackages = (with pkgs; [
  #   gnome-photos
  #   gnome-tour
  # ]) ++ (with pkgs.gnome; [
  #   cheese # webcam tool
  #   gnome-music
  #   gnome-terminal
  #   gedit # text editor
  #   epiphany # web browser
  #   geary # email reader
  #   evince # document viewer
  #   gnome-characters
  #   totem # video player
  #   tali # poker game
  #   iagno # go game
  #   hitori # sudoku game
  #   atomix # puzzle game
  # ]);

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Add keyd configuration to disable wlan toggle when attaching
  # detaching keyboard
  # TODO: find a way to catch keyboard (now they are ignored)
  # environment.etc."keyd/default.conf".text = ''
  #   [ids]

  #   *
    
  #   [keycodes]
  #   # Disable keycode 246
  #   wlan = noop
  # '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound firmware
  hardware.firmware = with pkgs; [
    sof-firmware
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };  

  # Enable thunderbolt
  services.hardware.bolt.enable = true;

  # Enable HW Video/3d
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };  

  # Enable accelerometer
  hardware.sensor.iio.enable = true;
  
  # Enable bluetooth paring
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;  
  
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alexdimi = {
    isNormalUser = true;
    description = "Alex Dimitriou";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  # Home-manager declaration
  # home-manager = {
  #  # also pass inputs to home-manager modules
  #  extraSpecialArgs = { inherit inputs; };
  #  users = {
  #    "alexdimi" = import ./home.nix;
  #  };
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    #gsettings-desktop-schemas
    git
    gnumake
    # gnome.dconf-editor
    vscode
    # gnome.gnome-tweaks
    distrobox
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    obsidian
    warp-terminal
    # keyd
  ];

  # Add docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      setSocketVariable = true;
    };
  };

  # TODO: In home manager, install vscode nix and nix format extensions

  # Fractional scaling
  #services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  [org.gnome.mutter]
  #  experimental-features = [ "scale-monitor-framebuffer" ]
  #  [org.gnome.desktop.interface]
  #  scaling-factor = 1
  #'';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
