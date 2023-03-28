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
      linuxPackages.kernel.moduleBuildDependencies
      bc
    ]);
  runScript = "bash";
}).env
