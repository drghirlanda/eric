#!/bin/bash

set -ex

NAME=bumpers

# build
SDL=$(sdl-config --libs)
SDL="$SDL -lSDL_image -lSDL_gfx -lSDL_ttf"
cc -g -O0 -o $NAME $NAME.c -lm -pthread -lrt -lmint-debug  -lpigpio $SDL
ls -lh $NAME

./$NAME

