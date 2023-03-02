{ inputs, system, ... }:
let
  mkShell = inputs.nixpkgs.legacyPackages.${system}.mkShell;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
mkShell {
  packages = with pkgs;[ ns-3 ];
  C_INCLUDE_PATH = "${pkgs.ns-3}/include/ns3.35/ns3";
  CPLUS_INCLUDE_PATH = "${pkgs.ns-3}/include/ns3.35/ns3";
  LD_LIBRARY_PATH = "${pkgs.ns-3}/lib";
}

