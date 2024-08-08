{ pkgs, lib, ... }:

let
  theme = lib.importTOML .config/alacritty/themes/dracula.toml;
in {
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      colors = theme.colors or {};
    };
  };

  home.file = {
    ".config/alacritty/themes/dracula.toml".source = ../../../.config/alacritty/themes/dracula.toml;
  };
}
