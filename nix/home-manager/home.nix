{ inputs, config, pkgs, ... }:

{
  # Home metadata
  home = {
    username = "kelvins";
    homeDirectory = "/home/kelvins";
  };

  programs.git = {
    enable = true;
    userName = "Kelvin S. do Prado";
    userEmail = "kelvinpfw@gmail.com";
    extraConfig = {
      pull.rebase = false;
    };
  };

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
    terminator
    firefox
    calibre
    docker
    insomnia
    gimp
    steam
    spotify
    slack
    # GNOME packages
    pkgs.gnome.eog
    pkgs.gnome.nautilus
    gnomeExtensions.dash-to-dock
  ];

  home.file = {
    ".vimrc".source = ../../.vimrc;
    ".k9s/config.yml".source = ../../.k9s/config.yml;
    ".config/terminator/config".source = ../../.config/terminator/config;
    # EMACS
    ".emacs.d/init.el".source = ../../.emacs.d/init.el;
    ".emacs.d/ispell/dictionary".source = ../../.emacs.d/ispell/dictionary;
    ".emacs.d/flycheck/markdownlint.json".source = ../../.emacs.d/flycheck/markdownlint.json;
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
    history.size = 50000;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["git" "colored-man-pages"];
    };
  };

  programs.firefox = {
    enable = true;
    profiles.kelvins = {
      name = "kelvins";
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        metamask
        bitwarden
      ];
      settings = {
        "browser.startup.homepage" = "https://google.com";

        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;

        # Disable crappy home activity stream page
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;

        # Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
