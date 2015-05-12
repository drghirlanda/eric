#!/bin/bash

function elog {
    echo "$(date): $@"
}

set -ex # fatal errors

elog "STARTING eric"

# build eric (switch between debug and optimized code below)
SDL=$(sdl-config --libs)
SDL="$SDL -lSDL_image -lSDL_gfx -lSDL_ttf"
if [ $debug -eq 1 ]; then
    cc -g -O0 -o eric eric.c -lm -pthread -lrt -lmint-debug $SDL
else
    cc -O2 -o eric eric.c -lm -pthread -lrt -lmint $SDL
fi
ls -lh eric

# build architecture file (you can comment out some sections)
cat arc/brain.arc > eric.arc
#cat arc/eye.arc >> eric.arc
cat arc/motors.arc >> eric.arc
#cat arc/reflexes.arc >> eric.arc
cat arc/exploration.arc >> eric.arc

set +e # from now on, set errors to non-fatal

# while eric runs, we read 1 char at a time without waiting for \n, in
# case we want to send keypress events to eric
stty -icanon min 1

./eric &                 # start eric
ERIC_PID=$!              # save eric's PID
#./voltmon.sh $ERIC_PID & #  voltage monitor, see voltmon.sh 
VOLTMON_PID=$!           # save voltmon's PID
wait $ERIC_PID           # wait for eric (or until batteries run out)
ERIC_STATUS=$?           # did eric terminate successfully?
kill $VOLTMON_PID        # cancel voltmon.sh if eric exits on its own

stty cooked # restore normal terminal mode

# if eric did not terminate successfully we kill camshot manually,
# otherwise we cannot start eric again
if [ $ERIC_STATUS -ne 0 ]; then
    elog "eric TERMINATED abnormally"
    killall camshot
else
    elog "eric TERMINATED normally"
fi
