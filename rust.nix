{ inputs, system, ... }:
let
  mkShell = inputs.nixpkgs.legacyPackages.${system}.mkShell;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
mkShell {
  packages = with pkgs;[ rustc rust-analyzer pkg-config cargo ];
  RUST_BACKTRACE = 1;
}

