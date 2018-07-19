{ config, lib, pkgs, ... }:

{
# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		wget
			vim
			firefox
			chromium
			zsh
			oh-my-zsh
			stow
			htop
			gnupg
			keepassx
			ripgrep
			exa
			fd
			git
			direnv
			autojump
			vim
			vlc
			wget
			which
			neovim
			zip
			unzip
			vscode
			keybase keybase-gui
			gnome3.gnome-tweak-tool
			numix-gtk-theme numix-cursor-theme numix-icon-theme-circle
			terminator
			cairo
			];
}
