{ config, pkgs, ... }: {

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "22.05";

  # Session configuration
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.vim.enable = true;

  programs.jq.enable = true;

  programs.dircolors.enable = true;

  programs.bash.enable = true;

  programs.autojump = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.eza.enable = true;
  programs.eza.enableAliases = true;

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "python"
        "docker"
        "kubectl"
        "rust"
        "node"
        "minikube"
        "golang"
        "sudo"
        "yarn"
        "vim-interaction"
      ];
    };
  };


  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jnoortheen.nix-ide
    ];
  };

  programs.git = {
    enable = true;
    userName = "Pierre Zemb";
    userEmail = "contact@pierrezemb.fr";
  };

  # Local programs
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  home.packages = [
    pkgs.httpie
    pkgs.keepassxc
    pkgs.keybase-gui
    pkgs.hugo
    pkgs.inkscape
    pkgs.zoom-us
    pkgs.gimp
    pkgs.zellij
    pkgs.libsForQt5.okular
    pkgs._1password-gui
    pkgs.gnome.gpaste
    pkgs.kafkactl
    pkgs.jetbrains.idea-community
    pkgs.alacritty
    pkgs.google-chrome
    pkgs.jetbrains.rust-rover
  ];

  programs.tmux.enable = true;
  programs.tmux.extraConfig =
    ''
      new-session
      set -g mouse on
    '';

  dconf.settings = {
    "org/gnome/Germinal" = {
      forecolor = "white";
    };
  };
  programs.bat.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.95;
        startup_mode = "Maximized";
      };
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [
          "-l"
          "-c"
          "zellij attach -c xps"
        ];
      };
      colors = {
        primary = {
          background = "0x292C3E";
          foreground = "0xEBEBEB";
        };
        cursor = {
          text = "0x0d0d0d";
          cursor = "0xEBEBEB";
        };

        normal = {
          black = "0x0d0d0d";
          red = "0xFF301B";
          green = "0xA0E521";
          yellow = "0xFFC620";
          blue = "0x1BA6FA";
          magneta = "0x8763B8";
          cyan = "0x21DEEF";
          white = "0xEBEBEB";
        };

        bright = {
          black = "0x6D7070";
          red = "0xFF4352";
          green = "0xB8E466";
          yellow = "0xFFD750";
          blue = "0x1BA6FA";
          magneta = "0xA578EA";
          cyan = "0x73FBF1";
          white = "0xFEFEF8";
        };

        dim = {
          black = "0x9E9F9F";
          red = "0x864343";
          green = "0x777c44";
          yellow = "0x9e824c";
          blue = "0x556a7d";
          magenta = "0x75617b";
          cyan = "0x5b7d78";
          white = "0x828482";
        };
      };
      env.TERM = "xterm-256color"; # ssh'ing into old servers with TERM=alacritty is sad
    };
  };


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number relativenumber
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };


}
