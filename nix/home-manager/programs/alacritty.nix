{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      # Dracula color scheme
      colors = {
        primary = {
          background = "#282a36";
          foreground = "#f8f8f2";
        };
        cursor = {
          text = "#282a36";
          cursor = "#f8f8f2";
        };
        normal = {
          black   = "#21222c";
          red     = "#ff5555";
          green   = "#50fa7b";
          yellow  = "#f1fa8c";
          blue    = "#bd93f9";
          magenta = "#ff79c6";
          cyan    = "#8be9fd";
          white   = "#f8f8f2";
        };
        bright = {
          black   = "#6272a4";
          red     = "#ff6e6e";
          green   = "#69ff94";
          yellow  = "#ffffa5";
          blue    = "#d6acff";
          magenta = "#ff92df";
          cyan    = "#a4ffff";
          white   = "#ffffff";
        };
      };

      font = {
        size = 10.0;
      };

      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "full";
      };
    };
  };
}
