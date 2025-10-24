{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";
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
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; config.cudaSupport = true; };
        devShells = {
          rust = import ./rust.nix { inherit inputs system; };
          ns3 = import ./ns3.nix {
            inherit inputs system;
            ns3 = pkgs.ns3.override { withExamples = true; modules = [ "all_modules" ]; };
            NetAnim = ylynur.packages.${system}.NetAnim;
          };
          tex = import ./tex.nix { inherit pkgs system; };
          vue = import ./vue.nix { inherit pkgs system; };
          fhs = import ./fhs.nix { inherit pkgs system; };
          mpi = import ./mpi.nix { inherit pkgs system; };
          cuda = import ./cuda.nix { inherit pkgs system; };
        };
        initDevShell = pkgs.writeScriptBin "activate" ''
          #!/usr/bin/env bash

          path=$2
          str=$1
          flag=0
          devShells="${builtins.toString (builtins.attrNames devShells) }"
          if [ $# -ne 2 ]; then
            flag=1
          fi
          for sh in $devShells
          do
            if [ $sh -ne $str ]; then
              flag=1
            fi
          done
          if [ $flag -eq 1 ]; then
            echo "Usage: activate <devShell> <path> "
            echo "available devShells: $devShells"
            exit 1
          fi

          if [ -d "$path" ]; then

            if [ -f "$path/.envrc" ]; then
              echo "Error: The file $path/.envrc already exists."
              exit 1
            fi
            echo "Error: The file $path already exists."
            touch $path/.envrc
            echo "use flake github:omi-coide/nix-dev#$str" >> "$path/.envrc"
            direnv allow
            echo "The file $path/.envrc has been created successfully!"
          else
            mkdir -p $path
            touch $path/.envrc
            echo "use flake github:omi-coide/nix-dev#$str" >> "$path/.envrc"
            direnv allow
            echo "The file $path/.envrc has been created successfully!"
          fi
          exit 0
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

