binary_name := "hello"

run: build
    ./out/{{binary_name}}

build: configure
    mkdir -p out
    gcc -o out/{{binary_name}} `find build/ -type f -name "*.c"`

configure:
    rm -rf build
    mkdir -p build
    cp -r src/* build/
    cp -r include/* build/
