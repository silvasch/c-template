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

        # the name of your project.
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

          # adds the paths to the folders containing the standard headerfiles to CPATH.
          # this is not required to compile a c program, but it helps bear to generate
          # compile_commands.json.
          shellHook = ''
            export CPATH="${pkgs.glibc.dev}/include:$(dirname $(dirname $(which clang)))/resource-root/include:$CPATH"
          '';
        };

        packages.${pname} = pkgs.stdenv.mkDerivation {
          inherit pname;
          version = "0.1.0";

          src = ./.;

          # add your build dependencies here.
          nativeBuildInputs = with pkgs; [
            just

            clang
          ];

          # add your runtime dependencies here.
          buildInputs = [ ];

          buildPhase = ''
            just build
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp out/${pname} $out/bin
          '';
        };

        packages.default = self.packages.${system}.${pname};

        templates.default = {
          path = ./.;
          description = "A template for a C project using just as a build system.";
        };
      }
    );
}
