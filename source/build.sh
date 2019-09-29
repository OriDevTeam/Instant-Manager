#!/bin/bash

#raini may want to kill me
pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

# check if args are provided
if [ $# ]; then
    echo "build -<b:p:c:a:h> | --<build:prepare:clean:all:help>
      -b, --build     Builds source(assuming its prepared)
      -p, --prepare   Prepares source for building
      -c, --clean     Cleans source <build> directory
      -a, --all       Does all of the above"
fi

dir="build"

# meh
DO_ALL=0
DO_CLEANUP=0
DO_PREPARE=0
DO_COMPILE=0

# loop through args and check what commands are used
for arg in "$@"
do
    case "$arg" in
        "-a" | "--all")
        DO_ALL=1
        ;;
        "-c" | "--clean")
        DO_CLEANUP=1
        ;;
        "-b" | "--build")
        DO_COMPILE=1
        ;;
        "-p" | "--prep")
        DO_PREPARE=1
        ;;
    esac
done

createDir() {
    # check if the dir already exists
    if [ -d "$1" ]; then
        return
    fi

    # create dir
    mkdir "$1"
}

# check if we have to do a cleanup
if [ $DO_ALL -eq 1 ] || [ $DO_CLEANUP -eq 1 ]; then
    # check if the build dir even exists
    if [ -d $dir ]; then
        # begone thot
        rm -rf $dir
    fi
fi

# check if we have to do a prepare
if [ $DO_ALL -eq 1 ] || [ $DO_PREPARE -eq 1 ]; then
    # create build dir if it doesnt exist
    createDir $dir

    # no idea
    pushd $dir
        cmake -G "Ninja" ..
    popd
fi

# check if we have to compile
if [ $DO_ALL -eq 1 ] || [ $DO_COMPILE -eq 1 ]; then
    # create build dir if it doesnt exist
    createDir $dir

    # build this mess
    pushd $dir
        cmake --build .
    popd
fi
