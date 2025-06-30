{ pkgs, ... }:

let
  claude-code = pkgs.writeShellScriptBin "claude-code" ''
    #!/bin/sh
    # Check if claude-code is installed globally
    if ! command -v claude-code > /dev/null 2>&1; then
      echo "Installing claude-code globally..."
      ${pkgs.nodePackages.npm}/bin/npm install -g claude-code
      echo "claude-code installed successfully!"
    fi

    # Run claude-code with all passed arguments
    exec ${pkgs.nodejs}/bin/node "$(${pkgs.nodePackages.npm}/bin/npm root -g)/claude-code/bin/claude-code" "$@"
  '';
in

{
  home.packages = [ claude-code ];
}
