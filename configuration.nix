# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
    zip
    unzip
    vscode
    keybase keybase-gui
    gnome3.gnome-tweak-tool
  ];

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

  # Graphics
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.layout = "fr";
  services.xserver.displayManager.gdm.enable = true;
  
  # Driver
  #nixpkgs.config.allowUnfree = true;
  #services.xserver.videoDrivers = [ "nvidia" ];

  # touchpads
  services.xserver.libinput.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

# Fonts

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
	  ];
  };
  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.vim.defaultEditor = true;

  programs.zsh.autosuggestions.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.theme = "agnoster";
  programs.zsh.ohMyZsh.plugins = [ "autojump" "direnv" "git" "gitignore" "git-extras" "systemd" "colorize" "colored-man-pages" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.pierre = {
    createHome = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
    isNormalUser = true;
    group = "users";
    home = "/home/pierre";
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.nixos.stateVersion = "18.03"; # Did you read the comment?

}
