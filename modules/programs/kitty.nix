{ ... }:

{
  programs.kitty = {
    enable = true;
    
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    
    settings = {
      # Window settings
      remember_window_size = false;
      initial_window_width = 120;
      initial_window_height = 30;
      window_padding_width = 8;
      
      # Tab settings
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      
      # Color scheme (Dracula)
      background = "#282a36";
      foreground = "#f8f8f2";
      cursor = "#f8f8f2";
      
      # Selection colors
      selection_background = "#44475a";
      selection_foreground = "#f8f8f2";
      
      # Normal colors
      color0 = "#21222c";
      color1 = "#ff5555";
      color2 = "#50fa7b";
      color3 = "#f1fa8c";
      color4 = "#bd93f9";
      color5 = "#ff79c6";
      color6 = "#8be9fd";
      color7 = "#f8f8f2";
      
      # Bright colors
      color8 = "#6272a4";
      color9 = "#ff6e6e";
      color10 = "#69ff94";
      color11 = "#ffffa5";
      color12 = "#d6acff";
      color13 = "#ff92df";
      color14 = "#a4ffff";
      color15 = "#ffffff";
      
      # Performance settings
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      
      # Bell settings
      enable_audio_bell = false;
      visual_bell_duration = "0.0";
      
      # Mouse settings
      mouse_hide_wait = "3.0";
      url_style = "curly";
      
      # Advanced
      shell_integration = "enabled";
      allow_remote_control = true;
      listen_on = "unix:/tmp/kitty";
    };
    
    keybindings = {
      # Tab management
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      
      # Window management
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      
      # Font size
      "ctrl+shift+equal" = "increase_font_size";
      "ctrl+shift+minus" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      
      # Copy/paste
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
  };
}
