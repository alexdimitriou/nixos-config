# NixOS Configuration Structure

This repository follows a modular approach to NixOS configuration management.

## Directory Structure

```
nixos-config/
├── flake.nix                    # Main flake configuration
├── flake.lock                   # Flake lock file
├── home.nix                     # Home Manager entry point
├── hosts/                       # Host-specific configurations
│   ├── lexbookduo/             # Host: lexbookduo
│   │   ├── lexbookduo.nix      # Main system configuration
│   │   └── hardware-configuration.nix # Hardware-specific settings
│   └── template/               # Template for new hosts
│       ├── README.md
│       ├── template.nix
│       └── hardware-configuration.nix
├── modules/                     # Modular configurations
│   ├── packages.nix            # System-wide packages
│   ├── programs/               # Program-specific configurations
│   │   ├── vscode.nix         # VS Code configuration
│   │   ├── git.nix            # Git configuration
│   │   ├── bash.nix           # Bash shell configuration
│   │   └── template.nix       # Template for new programs
│   └── services/              # Service configurations (future)
├── secrets/                    # Encrypted secrets (if using)
└── README-vscode.md           # VS Code specific documentation
```

## Module Organization

### Programs (`modules/programs/`)
- **`vscode.nix`** - Complete VS Code setup with extensions and settings
- **`git.nix`** - Git configuration with aliases and defaults
- **`bash.nix`** - Shell configuration with aliases and environment

### Packages (`modules/packages.nix`)
- Development tools and language servers
- System utilities
- Fonts and themes

### Hosts (`hosts/`)
- **`lexbookduo/`** - Complete host configuration directory
  - **`lexbookduo.nix`** - System-level configuration (networking, services, etc.)
  - **`hardware-configuration.nix`** - Hardware-specific settings
- **`template/`** - Template for creating new host configurations

## Benefits of This Structure

1. **Modularity**: Each program/service has its own configuration file
2. **Maintainability**: Easy to find and modify specific configurations
3. **Reusability**: Modules can be shared across different hosts
4. **Clarity**: Clear separation between system and user configurations
5. **Scalability**: Easy to add new modules as your setup grows

## Usage

### Adding a New Program Module
1. Create a new file in `modules/programs/`
2. Add the import to `home.nix`
3. Rebuild: `sudo nixos-rebuild switch --flake .#lexbookduo`

### Adding a New Host
1. Copy the template: `cp -r hosts/template hosts/new-hostname`
2. Update the configuration files in the new directory
3. Add the host to `flake.nix` outputs
4. Rebuild: `sudo nixos-rebuild switch --flake .#new-hostname`

### Quick Commands
From the configuration directory:
- **Rebuild system**: `sudo nixos-rebuild switch --flake .#lexbookduo`
- **Update flake**: `nix flake update`
- **Clean old generations**: `sudo nix-collect-garbage -d`

## File Responsibilities

| File/Directory | Purpose |
|----------------|---------|
| `flake.nix` | Entry point, defines inputs/outputs |
| `home.nix` | Home Manager configuration aggregator |
| `hosts/hostname/` | Host-specific configuration directory |
| `modules/programs/` | User program configurations |
| `modules/services/` | Service configurations |
| `modules/packages.nix` | Package installations |

This structure makes your NixOS configuration more maintainable and easier to understand as it grows!
