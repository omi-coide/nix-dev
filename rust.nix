{ inputs , system, ...}: 
let 
  mkShell = inputs.nixpkgs.legacyPackages.${system}.mkShell;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
  mkShell {
    buildInputs = with pkgs;[ rustc rust-analyzer pkg-config ];
  }

