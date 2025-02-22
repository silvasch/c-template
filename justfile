binary_name := "generate-uuids"

libuuid := `pkg-config uuid --libs --cflags`

run *ARGS: build
    ./out/{{binary_name}} {{ARGS}}

build: configure
    mkdir -p out
    cc \
        -o out/{{binary_name}} \
        -I include `find build/ -type f -name "*.c"` \
        {{libuuid}}

configure:
    rm -rf build
    mkdir -p build
    cp -r src/* build/
    if [ -d "include" ] && [ "$(ls -A include)" ]; then \
        cp -r include/* build/; \
    fi

# check for memory leaks
# note that this will return a non-zero exitcode
# if the binary returns a non-zero exitcode, even
# if valgrind does not find any memory leaks.
memcheck: build
    valgrind --leak-check=full ./out/{{binary_name}}

generate-compile-commands:
    bear -- just build

clean:
    rm -rf build
    rm -rf out
    rm -rf result
    rm compile_commands.json
