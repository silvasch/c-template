{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      flake-utils,
      nixpkgs,
      self,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        pname = "hello";
      in
      {
        devShell = pkgs.mkShell {
          packages = with pkgs; [
            just

            clang
            clang-tools

            bear
          ];

          shellHook = ''
            export CPATH="${pkgs.glibc.dev}/include:$(dirname $(dirname $(which clang)))/resource-root/include:$CPATH"
          '';
        };

        packages.${pname} = pkgs.stdenv.mkDerivation {
          inherit pname;
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = with pkgs; [
            just

            clang
          ];

          buildPhase = ''
            just build
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp out/${pname} $out/bin
          '';
        };
        packages.default = self.packages.${system}.${pname};
      }
    );
}
