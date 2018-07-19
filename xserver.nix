# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
# Graphics
	services.xserver.enable = true;
	services.xserver.desktopManager.gnome3.enable = true;
	services.xserver.layout = "fr";
	services.xserver.displayManager.gdm.enable = true;
  	services.gnome3.gnome-keyring.enable = true;
  	security.pam.services.gdm.enableGnomeKeyring = true;
# Driver
#nixpkgs.config.allowUnfree = true;
#services.xserver.videoDrivers = [ "nvidia" ];

# touchpads
	services.xserver.libinput.enable = true;

# Enable sound.
	sound.enable = true;
	hardware.pulseaudio.enable = true;

# Add fonts
	fonts = {
		enableFontDir = true;
		enableGhostscriptFonts = true;
		fonts = with pkgs; [
			powerline-fonts
				hack-font
				anonymousPro
				corefonts
				dejavu_fonts
				font-droid
				freefont_ttf
				google-fonts
				inconsolata
				liberation_ttf
				source-code-pro
				terminus_font
				ttf_bitstream_vera
				ubuntu_font_family
				emojione
				noto-fonts
		];
	};
}
