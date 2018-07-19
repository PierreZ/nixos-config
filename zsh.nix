{ config, pkgs, ... }:

	{
		programs.zsh.enable = true;

		programs.vim.defaultEditor = true;

		programs.zsh.autosuggestions.enable = true;
		programs.zsh.enableCompletion = true;
		programs.zsh.syntaxHighlighting.enable = true;
		programs.zsh.ohMyZsh.enable = true;
		programs.zsh.ohMyZsh.plugins = [ "autojump" "direnv" "git" "gitignore" "git-extras" "systemd" "colorize" "colored-man-pages" ];
		programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
    # Customize your oh-my-zsh options here
    ZSH_THEME="spaceship"
    source $ZSH/oh-my-zsh.sh
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
