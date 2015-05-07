#!/bin/bash
## script to control eric with the keyboard

DC_ENABLE=19
DC_FORWARD=23
DC_BACK=16
SERVO=21

CENTER=1500

#PIGS=echo
PIGS="sudo pigs"

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
    SPEED=$1
    if [ $SPEED -gt 0 ]; then
	if [ $SPEED -gt 255 ]; then
	    SPEED=255
	fi
	$PIGS pwm $DC_FORWARD $SPEED
	$PIGS pwm $DC_BACK 0
    else
	if [ $SPEED -le -255 ]; then
	    SPEED=-255
	fi
	$PIGS pwm $DC_BACK $[ -($SPEED) ]
	$PIGS pwm $DC_FORWARD 0
    fi
}

function set_position {
    POS=$1
    if [ $POS -gt 2500 ]; then
	POS=2500
    elif [ $POS -le 500 ]; then
	POS=500
    fi
    $PIGS servo $SERVO $POS
}

function reset_motors {
    SPEED=0
    POS=$CENTER
    $PIGS pwm $DC_FORWARD 0
    $PIGS pwm $DC_BACK 0
    $PIGS servo $SERVO $CENTER
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
	    set_speed $[ $SPEED + 32 ]
	    ;;
	"l")
	    set_speed $[ $SPEED - 32 ]
	    ;;
	"r")
	    reset_motors
	    ;;
	"a")
	    set_position $[ $POS - 50 ]
	    ;;
	"s")
	    set_position $[ $POS + 50 ]
	    ;;
	"h")
	    print_help
	    ;;
	*)
	    echo "unknown command: $KEY (press h for help)"
    esac
    echo "speed = $SPEED; position = $POS"
done
