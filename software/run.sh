#!/bin/bash

function elog {
    echo "$(date): $@"
}

set -ex # fatal errors

elog "STARTING eric"

# leave out pi-specific things if not running on a pi:
if which pigs > /dev/null; then
    PIGPIO="-lpigpio"
    RUNFILE=/var/run/pigpio.pid
    if [ -e $RUNFILE ]; then
	echo "Stopping pigpiod (will be restarted when eric exits)"
	set +e # next errors not fatal
	kill $(cat $RUNFILE)
	/bin/rm $RUNFILE
	set -e
	START_PIGPIOD=1
    fi
else
    PIGPIO=""
    START_PIGPIOD=0
fi

# set up SDL library flags
SDL=$(sdl-config --libs)
SDL="$SDL -lSDL_image -lSDL_gfx -lSDL_ttf"

# set up debug vs. production
if [ $debug -eq 1 ]; then
    FLAGS="-g -O0"
    MINT="-lmint-debug"
else
    FLAGS="-O2"
    MINT="-lmint"
fi

# build eric
cc $FLAGS -o eric eric.c -lm -pthread -lrt $MINT $PIGPIO $SDL
ls -lh eric

# build architecture file (you can comment out some sections)
cat arc/brain.arc > eric.arc
#cat arc/eye.arc >> eric.arc
cat arc/motors.arc >> eric.arc
cat arc/bumpers.arc >> eric.arc
#cat arc/exploration.arc >> eric.arc

set +e # from now on, set errors to non-fatal

# while eric runs, we read 1 char at a time without waiting for \n, in
# case we want to send keypress events to eric
stty -icanon min 1

./eric &                 # start eric
ERIC_PID=$!              # save eric's PID
#./voltmon.sh $ERIC_PID & #  voltage monitor, see voltmon.sh 
#VOLTMON_PID=$!           # save voltmon's PID
wait $ERIC_PID           # wait for eric (or until batteries run out)
ERIC_STATUS=$?           # did eric terminate successfully?
#kill $VOLTMON_PID        # cancel voltmon.sh if eric exits on its own

stty cooked # restore normal terminal mode

# if eric did not terminate successfully we kill camshot manually,
# otherwise we cannot start eric again
if [ $ERIC_STATUS -ne 0 ]; then
    elog "eric TERMINATED abnormally"
    killall camshot
else
    elog "eric TERMINATED normally"
fi

if [ $START_PIGPIOD -eq 1 ]; then
    pigpiod
fi
