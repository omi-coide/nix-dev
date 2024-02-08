{ inputs, system, ... }:
let
  mkShell = inputs.nixpkgs.legacyPackages.${system}.mkShell;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
mkShell {
  packages = with pkgs;[ neovim satysfi ];
  RUST_BACKTRACE = 1;
}

