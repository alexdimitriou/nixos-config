{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... } @ inputs: {
    nixosConfigurations = {
      mars = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # ({ pkgs, ... }: {
          #   nixpkgs.overlays = [
          #     (self: super: {
          #       unstable = import nixpkgs-unstable {
          #         system = super.system;
          #         config = super.config;
          #       };
          #     })
          #   ];
          # })
          ./hosts/mars/configuration.nix
          nixos-hardware.nixosModules.common-cpu-intel
        ];
      };

      jupiter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # ({ pkgs, ... }: {
          #   nixpkgs.overlays = [
          #     (self: super: {
          #       unstable = import nixpkgs-unstable {
          #         system = super.system;
          #         config = super.config;
          #       };
          #     })
          #   ];
          # })
          ./hosts/jupiter/configuration.nix
          # nixos-hardware.nixosModules.common-cpu-intel
        ];
      };
    };

    # homeConfigurations = {
    #   "alexdimi@mars" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #     extraSpecialArgs = { inherit inputs; };
    #     modules = [ ./home-manager/home.nix ];
    #   };
    # };
  };
}
