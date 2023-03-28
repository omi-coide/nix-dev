{ inputs, system, ... }:
let
  mkShell = inputs.nixpkgs.legacyPackages.${system}.mkShell;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
let
  vue = with pkgs;[
    nodejs
  ];
in
mkShell {
  packages = vue;
}


