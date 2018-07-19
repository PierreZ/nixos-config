# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
			./xserver.nix
			./packages.nix
			./user-pierre.nix
			./zsh.nix
		];

	boot.kernelPackages = pkgs.linuxPackages_latest;

	nixpkgs.config.allowUnfree = true;

# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.initrd.luks.devices = [
	{
		name = "root";
		device = "/dev/nvme0n1p2";
		preLVM = true;
	}
	];

	networking.hostName = "nixos"; # Define your hostname.
		networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

# Select internationalisation properties.
		i18n = {
			consoleFont = "Lat2-Terminus16";
			consoleKeyMap = "fr";
			defaultLocale = "en_US.UTF-8";
		};

# Set your time zone.
	time.timeZone = "Europe/Paris";

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.bash.enableCompletion = true;
# programs.mtr.enable = true;
# programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

# List services that you want to enable:

# Enable the OpenSSH daemon.
	services.openssh.enable = true;

# Keybase
	services.keybase.enable = true;
	services.kbfs = {
		enable = true;
		mountPoint = "/keybase";
	};

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Enable CUPS to print documents.
# services.printing.enable = true;

# This value determines the NixOS release with which your system is to be
# compatible, in order to avoid breaking some software such as database
# servers. You should change this only after NixOS release notes say you
# should.
	system.nixos.stateVersion = "18.03"; # Did you read the comment?

}
