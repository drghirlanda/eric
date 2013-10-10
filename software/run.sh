#!/bin/bash
set -ex

# build executable
SDL=$(sdl-config --libs)
SDL="$SDL -lSDL_image -lSDL_gfx -lSDL_ttf"
cc -g -O0 -o eric eric.c -lm -lmint-debug $SDL
ls -lh eric

# build architecture file
cat eyebrainvalue.arc > eric.arc
cat effectors.arc >> eric.arc
#cat reflex.arc >> eric.arc

# start
set +e
./eric

# cleanup in case of error
killall camshot
