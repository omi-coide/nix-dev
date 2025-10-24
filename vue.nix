{ pkgs, system, ... }:
let
  vue = with pkgs;[
    nodejs
  ];
in
pkgs.mkShell {
  packages = vue;
}


