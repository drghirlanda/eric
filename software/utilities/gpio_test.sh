#!/bin/bash

trap EXIT "stty echo"

## just echo commands if pigs is not available
if which pigs > /dev/null 2>&1; then
    PIGS="sudo pigs"
else
    PIGS=echo
fi

PINS="2 3 4 17 27 22 10 9 11 5 6 13 19 26 14 16 18 23 24 25 8 7 12 16 20 21"

function print_help {
cat<<EOF
This program tests the "numbered" GPIO pins on a Raspberry Pi 2 Model
B in an order that follows their physical layout: 

$PINS  

There are two modes of operation. With argument 'fast,' (default)
gpios are tested by writing to and reading back from them. The user is
alerted of mismatches. With argument 'slow,' the program pauses after
writing a 1 to each GPIO, giving the opportunity for a comprehensive
test using LEDs or similar. To move on to the next GPIO, press any
key.  

EOF
}

MODE=${1:-""}

case $MODE in
    "fast")
	echo "fast mode: probing all GPIOs without pausing"
	;;
    "slow")
	echo "slow mode: pausing after turning on each GPIO"
	echo "(press any key to proceed to next GPIO)"
	stty -echo
	read -n 1 
	stty echo
	;;
    *)
	print_help
	exit
	;;
esac

for pin in $PINS; do
    $PIGS w $pin 1
    state=$($PIGS r $pin)
    if [ $state -ne 1 ]; then
	echo "write/read MISMATCH on GPIO $pin: broken?"
    else
	echo "GPIO $pin seems OK"
    fi
    if [ $MODE == "slow" ]; then
	stty -echo
	read -n 1
	stty echo
    fi
    $PIGS w $pin 0
done
