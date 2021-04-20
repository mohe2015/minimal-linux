{
  description = "dev flake";

  inputs =
    {
      nixpkgs.url = "git+file:///etc/nixos/nixpkgs";
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
      test = crossPkgs.mkShell {
        nativeBuildInputs = [ pkgs.gcc pkgs.pkg-config ];
        buildInputs = [ pkgs.gtk2 pkgs.gnome2.libglade ];
        #nativeBuildInputs = [ (crossPkgs.stdenv.mkDerivation { name = "env"; }) ];

        shellHook = ''
          cd linux
          make gconfig
        '';
      };
    };
  };
}
