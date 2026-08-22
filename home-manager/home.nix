{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nixfmt
  ];

  programs.git = {
    enable = true;
    userName = "Pierre Zemb";
    userEmail = "contact@pierrezemb.fr";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  # Successor to autojump: `z <dir>` to jump, `zi` for interactive picking.
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "default";
      default_layout = "compact";
      pane_frames = false;
      simplified_ui = true;
      on_force_close = "quit";
      copy_command = "pbcopy";
      scrollback_editor = "nvim";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set smartindent
      set ignorecase
      set smartcase
      set hlsearch
      set incsearch
      set termguicolors
      set signcolumn=yes
      set clipboard+=unnamedplus
      set updatetime=50
      set scrolloff=8
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}
