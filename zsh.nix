{ config, pkgs, ... }:

	{
		programs.zsh.enable = true;

		programs.vim.defaultEditor = true;

		programs.zsh.autosuggestions.enable = true;
		programs.zsh.enableCompletion = true;
		programs.zsh.syntaxHighlighting.enable = true;
		programs.zsh.ohMyZsh.enable = true;
		programs.zsh.ohMyZsh.plugins = [ "autojump" "direnv" "git" "gitignore" "git-extras" "systemd" "colorize" "colored-man-pages" "rust" "zsh-autosuggestions" ];
		programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
    # Customize your oh-my-zsh options here
    ZSH_THEME="spaceship"
    source $ZSH/oh-my-zsh.sh
    SPACESHIP_PROMPT_ORDER=(
      time          # Time stampts section
      user          # Username section
      dir           # Current directory section
      host          # Hostname section
      git           # Git section (git_branch + git_status)
      hg            # Mercurial section (hg_branch  + hg_status)
      package       # Package version
      node          # Node.js section
      ruby          # Ruby section
      elixir        # Elixir section
      xcode         # Xcode section
      swift         # Swift section
      golang        # Go section
      php           # PHP section
      rust          # Rust section
      haskell       # Haskell Stack section
      julia         # Julia section
      docker        # Docker section
      aws           # Amazon Web Services section
      venv          # virtualenv section
      conda         # conda virtualenv section
      pyenv         # Pyenv section
      dotnet        # .NET section
      ember         # Ember.js section
      kubecontext   # Kubectl context section
      exec_time     # Execution time
      line_sep      # Line break
      battery       # Battery level and status
      vi_mode       # Vi-mode indicator
      jobs          # Background jobs indicator
      exit_code     # Exit code section
      char          # Prompt character
    );
    SPACESHIP_EXIT_CODE_SHOW=true;
    eval "$(direnv hook zsh)"
  '';
    nixpkgs.config = {

    packageOverrides = pkgs: {
      oh-my-zsh =
        let
          spaceshiptheme = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/a9819c528904000f5d246d3ed3c7514a30cf495a/spaceship.zsh";
            sha256 = "d469b6843a09152c56ecb01fd589adf194ba1edda58f7f0887b387ea06561408";
          };
        in
          pkgs.lib.overrideDerivation pkgs.oh-my-zsh (attrs: {
            # Install spaceship theme
            installPhase = [
              attrs.installPhase
                ''outdir=$out/share/oh-my-zsh
                  chmod -R +w $outdir
                  mkdir -p $outdir/custom/themes
                  cp -v ${spaceshiptheme} $outdir/custom/themes/spaceship.zsh-theme
                  mkdir -p $outdir/custom/plugins/nix
                  cp -R ${pkgs.nix-zsh-completions}/share/zsh/site-functions/* $outdir/custom/plugins/nix/
                ''
            ];
          });
    };

};

	}
