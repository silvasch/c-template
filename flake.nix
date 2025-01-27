{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      flake-utils,
      nixpkgs,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
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
      }
    );
}
