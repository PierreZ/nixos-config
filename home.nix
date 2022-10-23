{ config, pkgs, ... }: {

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "22.05";

  # Session configuration
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.vim.enable = true;

  programs.jq.enable = true;

  programs.dircolors.enable = true;

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

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

  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
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
    pkgs.zotero
    pkgs.inkscape
    pkgs.zoom-us
    pkgs.gimp
    pkgs.libsForQt5.okular
    pkgs._1password-gui
    pkgs.gnome.gpaste
    pkgs.kafkactl
    pkgs.jetbrains.idea-community
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


}
