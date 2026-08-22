{ config, pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.git
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # Store management
    gc.automatic = true;
    gc.interval.Hour = 3;
    gc.options = "--delete-older-than 15d";
    optimise.automatic = true;
    optimise.interval.Hour = 4;
  };

  # Let nix-darwin manage the user so the login shell can be set declaratively.
  users.knownUsers = [ "pierrezemb" ];
  users.users.pierrezemb = {
    uid = 501;
    home = "/Users/pierrezemb";
    shell = pkgs.fish;
  };

  # Add shells installed by nix to /etc/shells file
  environment.shells = with pkgs; [
    bashInteractive
    fish
  ];

  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.babelfishPackage = pkgs.babelfish;

  programs.nix-index.enable = true;

  # Authenticate sudo with Touch ID
  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
