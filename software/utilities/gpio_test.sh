#!/bin/bash

trap EXIT "stty echo"

## just echo commands if pigs is not available
if which pigs > /dev/null 2>&1; then
    PIGS="sudo pigs"
else
    PIGS=echo
fi

PINS="2 3 4 17 27 22 10 9 11 5 6 13 19 26 14 16 18 23 24 25 8 7 12 16 20 21"

cat<<EOF
This program tests the "numbered" GPIO pins on a Raspberry Pi 2 Model
B in layout order: 

$PINS  

Each PIN is turned and its state is read and displayed. To move on to
the next pin, press any key 
EOF

stty -echo
read -n 1

for pin in $PINS; do
    echo "writing 1 to GPIO $pin"
    $PIGS w $pin 1
    state=$($PIGS r $pin)
    echo "read '$state' from GPIO $pin, press any key to continue"
    read -n 1
    $PIGS w $pin 0
done

stty echo
