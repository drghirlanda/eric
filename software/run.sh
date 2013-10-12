#!/bin/bash
set -ex

# build executable
SDL=$(sdl-config --libs)
SDL="$SDL -lSDL_image -lSDL_gfx -lSDL_ttf"
cc -g -O0 -o eric eric.c -lm -lmint-debug $SDL
ls -lh eric

# build architecture file
cat arc/eyebrainvalue.arc > eric.arc
cat arc/effectors.arc >> eric.arc
#cat arc/reflex.arc >> eric.arc
#cat arc/exploration.arc >> eric.arc

set +e
./eric

# cleanup in case of error
killall camshot
