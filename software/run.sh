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
cat arc/exploration.arc >> eric.arc

set +e # non-fatal errors to kill camshot

# while eric runs, we read 1 char at a time without waiting for
# \n. this is handy to send keypress events to eric
stty -icanon min 1

./eric

# if eric crashes, we need to kill camshot manually
if [ $? -ne 0 ]; then
    killall camshot
fi
    
stty cooked # reset

