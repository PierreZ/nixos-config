{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.aarch64-linux = {
      pi = nixos-generators.nixosGenerate {
        system = "aarch64-linux";
        modules = [ ./configuration.nix ];
        format = "sd-aarch64";
      };
    };
  };
}
