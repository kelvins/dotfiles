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
    git
    tig
    vim
    ack
    htop
    emacs
    zsh
    oh-my-zsh
    terminator
    firefox
    calibre
    k9s
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
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
    # EDITOR = "emacs";
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

  home.file.".config/terminator/config" = {
    text = ''
	[global_config]
	  title_hide_sizetext = True
	  title_transmit_fg_color = "#282a36"
	  title_transmit_bg_color = "#50fa7b"
	  title_receive_fg_color = "#282a36"
	  title_receive_bg_color = "#ff79c6"
	  title_inactive_fg_color = "#f8f8f2"
	  title_inactive_bg_color = "#44475a"
	  inactive_color_offset = 0.61
	  suppress_multiple_term_dialog = True
	[keybindings]
	[profiles]
	  [[default]]
	    background_color = "#282a36"
	    cursor_color = "#f8f8f2"
	    font = Ubuntu 12
	    foreground_color = "#f8f8f2"
	    palette = "#262626:#e356a7:#42e66c:#e4f34a:#9b6bdf:#e64747:#75d7ec:#efa554:#7a7a7a:#ff79c6:#50fa7b:#f1fa8c:#bd93f9:#ff5555:#8be9fd:#ffb86c"
	    background_image = None
	[layouts]
	  [[default]]
	    [[[child1]]]
	      parent = window0
	      type = Terminal
	    [[[window0]]]
	      parent = ""
	      type = Window
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
