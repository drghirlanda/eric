#!/bin/bash
## script to control eric with the keyboard

DC_ENABLE=16
DC_FORWARD=23
DC_BACK=19
SERVO=21

CENTER=1500

PIGS=echo
#PIGS="sudo pigs"

stty -echo;

function print_help() {
    cat<<EOF
controls:
a,s: left, right
k,l: faster, slower
q: exit
r: reset (stop and center)
h: help
EOF
}

function set_speed {
    if [ $1 > 0 ]; then
	$PIGS pwm $DC_FORWARD $1
	$PIGS pwm $DC_BACK 0
    else
	$PIGS pwm $DC_BACK $[ -$SPEED ]
	$PIGS pwn $DC_FORWARD 0
    fi
}

echo "press h for help"

## initialize motors (DC off, servo at nominal center position)
$PIGS write $DC_FORWARD 0
$PIGS write $DC_BACK 0
$PIGS write $DC_ENABLE 1
$PIGS servo $SERVO $CENTER

## current state
SPEED=0
POS=$CENTER

while true; do
    read -n 1 KEY;
    case $KEY in
	"q")
	    stty echo
	    exit
	    ;;
	"k")
	    SPEED=$[ $SPEED + 32 ]
	    set_speed $SPEED
	    ;;
	
	"l")
	    SPEED=$[ $SPEED - 32 ]
	    set_speed $SPEED
	    ;;
	"r")
	    $PIGS pwm $DC_FORWARD 0
	    $PIGS pwm $DC_BACK 0
	    $PIGS servo $SERVO $CENTER
	    ;;
	"a")
	    POS=$[ $POS - 50 ]
	    $PIGS servo $SERVO $POS
	    ;;
	"s")
	    POS=$[ $POS + 50 ]
	    $PIGS servo $SERVO $POS
	    ;;
	"h")
	    print_help
	    ;;
	*)
	    echo "unknown command: $KEY (press h for help)"
    esac
done
