{
  description = "My NixOS Flake!";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-24.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      kelvins = lib.nixosSystem {
        inherit system;
        modules = [ ./nixos/configuration.nix ];
      };
    };
    homeConfigurations = {
      kelvins = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
