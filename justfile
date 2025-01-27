binary_name := "hello"

run *ARGS: build
    ./out/{{binary_name}} {{ARGS}}

build: configure
    mkdir -p out
    cc -o out/{{binary_name}} -I include `find build/ -type f -name "*.c"`

configure:
    rm -rf build
    mkdir -p build
    cp -r src/* build/
    cp -r include/* build/

generate-compile-commands:
    bear -- just build

clean:
    rm -rf build
    rm -rf out
