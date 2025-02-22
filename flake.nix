{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
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
        pname = "generate-uuids";

        buildDependencies = with pkgs; [
          # build tools
          just
          clang
          pkg-config

          # libraries
          libuuid
        ];
        runtimeDependencies = [ ];
        shellTools = with pkgs; [
          # lsp
          clang-tools
          bear

          # memcheck
          valgrind
        ];
      in
      {
        devShell = pkgs.mkShell {
          packages = buildDependencies ++ runtimeDependencies ++ shellTools;

          # adds the paths to the folders containing the standard header files to CPATH.
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

          nativeBuildInputs = buildDependencies;
          buildInputs = runtimeDependencies;

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
    )
    // {
      templates.c = {
        path = ./.;
        description = "A template for a C project.";
      };

      templates.default = self.templates.c;
    };
}
