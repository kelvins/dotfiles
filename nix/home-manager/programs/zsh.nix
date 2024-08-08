{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 50000;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["git" "colored-man-pages"];
    };
  };
}
