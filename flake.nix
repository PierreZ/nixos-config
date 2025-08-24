{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      nixpkgs,
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#MacBook-Air-de-Pierre
      darwinConfigurations."MacBook-Air-de-Pierre" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/mba.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.pierrezemb = import ./home-manager/home.nix;
            };
            users.users.pierrezemb.home = "/Users/pierrezemb";
          }
        ];
        specialArgs = { inherit inputs; };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."MacBook-Air-de-Pierre".pkgs;
    };
}
