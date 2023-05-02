{ inputs, system, ns3, NetAnim, ... }:
let
  mkShell = inputs.nixpkgs.legacyPackages.${system}.mkShell;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
mkShell {
  packages = with pkgs;[ ns-3 pkg-config NetAnim ];
  C_INCLUDE_PATH = "${pkgs.ns-3}/include/ns3.35";
  CPLUS_INCLUDE_PATH = "${pkgs.ns-3}/include/ns3.35";
  LD_LIBRARY_PATH = "${pkgs.ns-3}/lib"; # runtime search path
  LIBRARY_PATH = "${pkgs.ns-3}/lib"; # buildtime search path
  PKG_CONFIG_PATH = "${pkgs.ns-3}/lib/pkgconfig"; # pkgconfig search path
}
