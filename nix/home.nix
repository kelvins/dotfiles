{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kelvins";
  home.homeDirectory = "/home/kelvins";

  programs.git = {
    enable = true;
    userName = "Kelvin S. do Prado";
    userEmail = "kelvinpfw@gmail.com";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # GNOME packages
    pkgs.gnome.eog
    pkgs.gnome.nautilus
    gnomeExtensions.dash-to-dock
    # Essential packages
    git
    tig
    vim
    ack
    htop
    curl
    emacs
    k9s
    zsh
    oh-my-zsh
    terminator
    # Apps
    firefox
    calibre
    docker
    insomnia
    gimp
    steam
    spotify
    slack
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".vimrc".source = ../.vimrc;
    ".k9s/config.yml".source = ../.k9s/config.yml;
    ".config/terminator/config".source = ../.config/terminator/config;
    # ZSH
    ".zshrc".source = ../zsh/.zshrc;
    ".oh-my-zsh/themes/lib/async.zsh".source = ../zsh/lib/async.zsh;
    ".oh-my-zsh/themes/dracula.zsh-theme".source = ../zsh/dracula.zsh-theme;
    # EMACS
    ".emacs.d/init.el".source = ../.emacs.d/init.el;
    ".emacs.d/ispell/dictionary".source = ../.emacs.d/ispell/dictionary;
    ".emacs.d/flycheck/markdownlint.json".source = ../.emacs.d/flycheck/markdownlint.json;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kelvins/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Install vim-plug by downloading the plug.vim script
  home.file.".vim/autoload/plug.vim" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
      sha256 = "sha256-ILTIlfmNE4SCBGmAaMTdAxcw1OfJxLYw1ic7m5r83Ns=";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "dracula";
      plugins = ["git" "colored-man-pages"];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git.enable = true;
}
