{ config, pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.git
      pkgs.fish
      pkgs.zsh
    ];

    nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
    # Store management
    gc.automatic = true;
    gc.interval.Hour = 3;
    gc.options = "--delete-older-than 15d";
    optimise.automatic = true;
    optimise.interval.Hour = 4;
  };

  # Add shells installed by nix to /etc/shells file
  environment.shells = with pkgs; [
    bashInteractive
    fish
  ];

  # Make Fish the default shell
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.babelfishPackage = pkgs.babelfish;
  environment.variables.SHELL = "${pkgs.fish}/bin/fish";


  programs.nix-index.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
