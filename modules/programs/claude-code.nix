{ pkgs, ... }:

let
  # Use npm to run the official @anthropic-ai/claude-code package with auto-yes
  claude-code-wrapper = pkgs.writeShellScriptBin "claude-code" ''
    #!/bin/sh
    # Use --yes flag to automatically install the package if needed
    exec ${pkgs.nodePackages.npm}/bin/npx --yes @anthropic-ai/claude-code "$@"
  '';
in

{
  home.packages = [ claude-code-wrapper ];
}
