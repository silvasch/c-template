# C Template

A template for a C project that uses just as the build system, compatible with NixOS.

## Building And Running

To build the project, use `just build`. This will put your resulting executable
in `out/hello`. If you want to change the name of the binary, edit the `binary_name`
variable in the `justfile`.

You can also directly build *and* run the project using `just run`.

## Generating compile_commands.json

The `justfile` also contains a recipe for generating `compile_commands.json`
called `generate-compile-commands`. Run this before editing your project
to get LSP completions from `clang`.
