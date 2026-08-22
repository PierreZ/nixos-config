# Nix flake config

Nix flake managing macOS via [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Usage

Apply the configuration (the flake attribute is picked automatically from the hostname):

```bash
sudo darwin-rebuild switch --flake .
```

Update inputs:

```bash
nix flake update
```

Format the Nix files:

```bash
nix fmt
```
