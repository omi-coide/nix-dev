{ inputs, system, ... }:
let
  mkShell = inputs.nixpkgs.legacyPackages.${system}.mkShell;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
let
  vue = with pkgs;[
    nodejs
    # 除此之外还需要Windows 字体
  ];
in
mkShell {
  packages = vue;
}


