{ config, pkgs, ... }:

	{
		programs.zsh.enable = true;

		programs.vim.defaultEditor = true;

		programs.zsh.autosuggestions.enable = true;
		programs.zsh.enableCompletion = true;
		programs.zsh.syntaxHighlighting.enable = true;
		programs.zsh.ohMyZsh.enable = true;
		programs.zsh.ohMyZsh.theme = "agnoster";
		programs.zsh.ohMyZsh.plugins = [ "autojump" "direnv" "git" "gitignore" "git-extras" "systemd" "colorize" "colored-man-pages" ];
	}
