{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ylynur = {
      url = "github:omi-coide/my-nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ylynur, ... } @ inputs:
    let
      system = "x86_64-linux";
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      rust = import ./rust.nix { inherit inputs system; };
      ns3 = import ./ns3.nix { inherit inputs system; NetAnim = ylynur.packages.${system}.NetAnim; };
      tex = import ./tex.nix { inherit inputs system; };
      vue = import ./vue.nix { inherit inputs system; };
    };
}

