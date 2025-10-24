{ pkgs, system }:
(pkgs.buildFHSUserEnv {
  name = "simple-x11-env";
  targetPkgs = pkgs: (with pkgs;
    [
      udev
      linuxPackages.kernel.dev
      linuxPackages.kernel
      linuxPackages.kernel.moduleBuildDependencies
      bc
      python27
    ]);
  runScript = "bash";
}).env
