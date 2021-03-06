#!/bin/bash

set -e

NAME=expldir

# build
SDL=$(sdl-config --libs)
SDL="$SDL -lSDL_image -lSDL_gfx -lSDL_ttf"
cc -g -O0 -o $NAME $NAME.c -lm -pthread -lrt -lmint-debug $SDL
ls -lh $NAME

./$NAME &

gnuplot -persist<<EOF
plot "$NAME.dat" u 0:1 w l, "" u 0:2 w l, "" u 3 w l
EOF
