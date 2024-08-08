{ inputs, config, pkgs, ... }:

{
  # Home metadata
  home = {
    username = "kelvins";
    homeDirectory = "/home/kelvins";
  };

  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/java.nix
    ./programs/rust.nix
    ./programs/clojure.nix
    ./programs/firefox.nix
    ./programs/alacritty.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Set the Nix packages for your environment
  home.packages = with pkgs; [
    tig
    emacs
    k9s
    zsh
    oh-my-zsh
    firefox
    brave
    calibre
    docker
    insomnia
    gimp
    steam
    spotify
    slack
    neofetch
    # GNOME packages
    feh
    pkgs.gnome.eog
    pkgs.gnome.nautilus
    gnomeExtensions.dash-to-dock
  ];

  home.file = {
    ".vimrc".source = ../../.vimrc;
    ".k9s/config.yml".source = ../../.k9s/config.yml;
    # EMACS
    ".emacs.d/init.el".source = ../../.emacs.d/init.el;
    ".emacs.d/ispell/dictionary".source = ../../.emacs.d/ispell/dictionary;
    ".emacs.d/flycheck/markdownlint.json".source = ../../.emacs.d/flycheck/markdownlint.json;
  };

  home.sessionVariables = {
    EDITOR = "vim";
    GIT_EDITOR = "vim";

    DRACULA_DISPLAY_GIT = 1;
    DRACULA_DISPLAY_TIME = 1;
    DRACULA_DISPLAY_CONTEXT = 1;
  };

  # Install vim-plug by downloading the plug.vim script
  home.file.".vim/autoload/plug.vim" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
      sha256 = "sha256-ILTIlfmNE4SCBGmAaMTdAxcw1OfJxLYw1ic7m5r83Ns=";
    };
  };

  fonts.packages = with pkgs; [
    nerdfonts
    fira-code
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
