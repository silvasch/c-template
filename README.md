# C Template

A template for a C project that uses `just` as the build system, compatible with NixOS.

## Building and Running

To build the project, use `just build`. This will put your resulting executable
in `out/hello`.

You can also directly build *and* run the project using `just run`.

## Building and Running Using Nix

This project also includes a `flake.nix` that provides a package to build and run
your program using `nix build` and `nix run`.

## Changing the Name of Your Project

To change the name of your project, you'll have to modify the `binary_name` variable
in `justfile` and the `pname` variable in `flake.nix`.

## Generating compile_commands.json

The `justfile` also contains a recipe for generating `compile_commands.json`
called `generate-compile-commands`. Run this before editing your project
to get LSP completions from `clang`.
