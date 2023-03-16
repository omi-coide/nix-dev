{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ylynur = {
      url = "github:omi-coide/my-nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ylynur, ... } @ inputs:
    let
      system = "x86_64-linux";
    in
    (
      let
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        devShells = {
          rust = import ./rust.nix { inherit inputs system; };
          ns3 = import ./ns3.nix { inherit inputs system; NetAnim = ylynur.packages.${system}.NetAnim; };
          tex = import ./tex.nix { inherit inputs system; };
          vue = import ./vue.nix { inherit inputs system; };
        };
        initDevShell = pkgs.writeScriptBin "activate" ''
          #!/usr/bin/env bash

          path=$2
          str=$1
          devShells="${builtins.toString (builtins.attrNames devShells) }"
          if [ $# -ne 2 ]; then
            echo "Usage: activate <devShell> <path> "
            echo "available devShells: $devShells"
            exit 1
          fi

          if [ -f "$path/.envrc" ]; then
            echo "Error: The file $path/.envrc already exists."
            exit 1
          fi
          touch $path/.envrc
          echo "use flake github:omi-coide/nix-dev#$str" >> "$path/.envrc"

          echo "The file $path/.envrc has been created successfully!"

        '';
      in
      {
        self.packages.${system}.initDevShell = initDevShell;
        apps.${system}.default = {
          type = "app";
          program = "${initDevShell}/bin/activate";
        };
        formatter.${system} = pkgs.nixpkgs-fmt;
        devShells.${system} = devShells;
      }
    );
}

