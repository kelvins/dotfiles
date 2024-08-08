{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Kelvin S. do Prado";
    userEmail = "kelvinpfw@gmail.com";
    extraConfig = {
      pull.rebase = false;
    };
  };
}
