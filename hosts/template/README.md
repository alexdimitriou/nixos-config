# Host Template

This directory contains the template for creating new host configurations.

## Creating a New Host

1. **Copy this template directory**:
   ```bash
   cp -r hosts/template hosts/your-hostname
   ```

2. **Update the configuration files**:
   - Edit `your-hostname.nix` with host-specific settings
   - Replace `hardware-configuration.nix` with output from `nixos-generate-config`

3. **Add to flake.nix**:
   ```nix
   nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
     modules = [
       ./hosts/your-hostname/your-hostname.nix
       # ... home-manager config
     ];
   };
   ```

4. **Rebuild**:
   ```bash
   sudo nixos-rebuild switch --flake .#your-hostname
   ```

## Host Structure

Each host directory should contain:
- `hostname.nix` - Main system configuration
- `hardware-configuration.nix` - Hardware-specific settings
- Optional: `default.nix` - Host-specific module imports
