{
  description = "dev flake";

  inputs =
    {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
    };

  outputs = inputs@{ self, nixpkgs, ... }:
  {
    packages = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
      crossPkgs = import nixpkgs {
        system = "x86_64-linux";
        crossSystem = "aarch64-linux";
      };
    in {
      test = crossPkgs.stdenv.mkDerivation { name = "env"; };
    };
    devShell = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
      crossPkgs = import nixpkgs {
        system = "x86_64-linux";
        crossSystem = "aarch64-linux";
      };
    in {
      test = crossPkgs.mkShell.override {stdenv = pkgs.clang10Stdenv;} {
        nativeBuildInputs = [ crossPkgs.lld_10 /*crossPkgs.llvmPackages_10.bintools*/ pkgs.pkg-config pkgs.flex pkgs.bison pkgs.bc ];
        buildInputs = [ pkgs.gtk2 pkgs.gnome2.libglade pkgs.ncurses ];

        shellHook = ''
          cd linux
        '';
      };
    };
  };
}
