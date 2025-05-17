{
  description = "A very basic flake";

  inputs = {
    nxmatic-flake-commons.url = "github:nxmatic/nix-flake-commons/develop";
    nixpkgs.follows = "nxmatic-flake-commons/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
  in {
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        incus-compose = pkgs.callPackage ./nix/package.nix {};
        default = self.packages.${system}.incus-compose;
      }
    );
  };
}
