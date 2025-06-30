{ config, pkgs, ... }:

{
  # Example program configuration template
  # Replace 'example' with your actual program name
  
  programs.example = {
    enable = true;
    
    # Add program-specific configuration here
    # settings = {
    #   key = "value";
    # };
  };
  
  # If the program doesn't have a programs.* option,
  # you can use home.file to manage config files directly:
  # home.file.".config/example/config.conf".text = ''
  #   # Configuration content here
  # '';
  
  # Or you can install packages related to this program:
  # home.packages = with pkgs; [
  #   example-package
  # ];
}
