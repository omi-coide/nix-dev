{ inputs, system }:
let
pkgs = inputs.nixpkgs.legacyPackages.${system};
in
(pkgs.buildFHSUserEnv {
  name = "simple-x11-env";
  targetPkgs = pkgs: (with pkgs;
    [ udev
      alsa-lib
    ]) ++ (with pkgs.xorg;
    [ libX11
      libXcursor
      libXrandr
    ]);
  multiPkgs = pkgs: (with pkgs;
    [ udev
      alsa-lib
    ]);
  runScript = "bash";
}).env