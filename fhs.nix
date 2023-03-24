{ inputs, system }:
let
pkgs = inputs.nixpkgs.legacyPackages.${system};
in
(pkgs.buildFHSUserEnv {
  name = "simple-x11-env";
  targetPkgs = pkgs: (with pkgs;
    [ udev
      linuxPackages.kernel.dev
      linuxPackages.kernel
      alsa-lib
    ]);
  multiPkgs = pkgs: (with pkgs;
    [ udev
      alsa-lib
      linuxPackages.kernel.dev
      linuxPackages.kernel
    ]);
  runScript = "bash";
}).env
