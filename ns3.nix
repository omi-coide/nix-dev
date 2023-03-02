{ inputs, system, ... }:
let
  mkShell = inputs.nixpkgs.legacyPackages.${system}.mkShell;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
mkShell {
  packages = with pkgs;[ ns-3 pkg-config ];
  C_INCLUDE_PATH = "${pkgs.ns-3}/include/ns3.35";
  CPLUS_INCLUDE_PATH = "${pkgs.ns-3}/include/ns3.35";
  LD_LIBRARY_PATH = "${pkgs.ns-3}/lib"; # runtime search path
  LIBRARY_PATH = "${pkgs.ns-3}/lib"; # buildtime search path
}

