#!/bin/bash
set -ex
SDL=$(sdl-config --libs)
SDL="$SDL -lSDL_image -lSDL_gfx -lSDL_ttf"
cc -g -O0 -o robot robot.c -lm -lmint-debug -pthread $SDL
ls -lh robot
./robot