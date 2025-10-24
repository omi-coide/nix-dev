{ pkgs, system, ... }:
pkgs.mkShell {
  packages = with pkgs;[ neovim satysfi ];
  RUST_BACKTRACE = 1;
}

