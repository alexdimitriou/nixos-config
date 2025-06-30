{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      # Extensions to install
      extensions = with pkgs.vscode-extensions; [
        # Language support
        ms-python.python
        ms-vscode.cpptools
        rust-lang.rust-analyzer
        golang.go

        # Git integration
        eamodio.gitlens

        # Themes and UI
        dracula-theme.theme-dracula
        pkief.material-icon-theme

        # Productivity
        ms-vscode-remote.remote-ssh
           # Formatters and linters
      esbenp.prettier-vscode

      # Nix language support
      jnoortheen.nix-ide
      bbenoist.nix
    ];

      # User settings
      userSettings = {
        # Editor settings
        "editor.fontSize" = 14;
        "editor.fontFamily" = "'JetBrains Mono', 'Fira Code', monospace";
        "editor.fontLigatures" = true;
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.wordWrap" = "on";
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "boundary";
        "editor.formatOnSave" = true;
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = "explicit";
        };

        # Workbench settings
        "workbench.colorTheme" = "Dracula";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "newUntitledFile";

        # Terminal settings
        "terminal.integrated.fontSize" = 14;
        "terminal.integrated.fontFamily" = "'JetBrains Mono', monospace";

        # File settings
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;

        # Git settings
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "git.autofetch" = true;

        # Language-specific settings
        "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nil}/bin/nil";

        # Disable nil formatter and use Prettier instead
        "nil.formatting.command" = null;

        # Configure Prettier for Nix files
        "[nix]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.formatOnSave" = true;
        };

        # Telemetry
        "telemetry.telemetryLevel" = "off";
      };

      # Keybindings
      keybindings = [
        {
          key = "ctrl+shift+p";
          command = "workbench.action.showCommands";
        }
        {
          key = "ctrl+shift+e";
          command = "workbench.view.explorer";
        }
      ];
    };
  };
}
