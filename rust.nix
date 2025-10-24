{ pkgs, system, ... }:
pkgs.mkShell {
  packages = with pkgs;[ rustc rust-analyzer pkg-config cargo ];
  RUST_BACKTRACE = 1;
}

