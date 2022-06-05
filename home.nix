{ pkgs ? import <nixpkgs> { }, lib, ... }:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pierrez = {
    isNormalUser = true;
    description = "Pierre Zemb";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  # Configuration through home-manager
  home-manager.users.pierrez = { pkgs, ... }: {

    # Let Home Manager install and manage itself
    programs.home-manager.enable = true;

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
      shellAliases = {
        ls = "ls --color=auto -F";
        l = "exa --icons --git-ignore --git -F --extended";
        ll = "exa --icons --git-ignore --git -F --extended -l";
      };
    };


    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        # Some example extensions...
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
    ];


  };

}
