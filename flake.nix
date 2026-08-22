{
  description = "Darwin system flake for Pierre's MacBook Air";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
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
      # $ sudo darwin-rebuild switch --flake .
      darwinConfigurations."MacBook-Air-de-Pierre" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/mba.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.pierrezemb = import ./home-manager/home.nix;
              extraSpecialArgs = { inherit inputs; };
            };

            # Pin each generation to the commit it was built from,
            # visible in `darwin-rebuild --list-generations`.
            system.configurationRevision = self.rev or self.dirtyRev or null;
          }
        ];
        specialArgs = { inherit inputs; };
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
    };
}
