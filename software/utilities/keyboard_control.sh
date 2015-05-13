#!/bin/bash
## script to control eric with the keyboard

DC_FORWARD=23
DC_BACK=24
DC_ENABLE=25
SERVO=21
SERVO_STEP=10
CENTER=1500

## just echo commands if pigs is not available
if which pigs > /dev/null 2>&1; then
    PIGS="sudo pigs"
else
    PIGS=echo
fi

stty -echo;

function print_help() {
    cat<<EOF
Eric's keyboard control utility:

* Run eric as a remote-controlled car
* Calibrate the servo motor
* Controls:
  a/s: turn left/right
  k/l: go faster/slower
  +/-: increase/decrease servo motor step
  q:   exit
  r:   reset (stop and position servo motor to 1500)
  h:   this help

Press k to get going!

EOF
}

function set_speed {
    if [ $1 -gt 0 ]; then
	$PIGS pwm $DC_FORWARD $1
	$PIGS pwm $DC_BACK 0
    else
	$PIGS pwm $DC_BACK $[ -$SPEED ]
	$PIGS pwn $DC_FORWARD 0
    fi
}

function adjust_servo_step {
    SERVO_STEP=$[ $SERVO_STEP + $1 ]
    if [ $SERVO_STEP -gt 100 ]; then
	SERVO_STEP=100
    elif [ $SERVO_STEP -le 1 ]; then
	SERVO_STEP=1
    fi
}

function print_info {
    echo
    echo "servo motor: pos=$POS, step=$SERVO_STEP"
    echo "dc motor:    speed=$SPEED"
}

clear
print_help

## initialize state and motors (dc=off, servo=nominal center)
SPEED=0
POS=$CENTER
$PIGS write $DC_FORWARD 0
$PIGS write $DC_BACK 0
$PIGS write $DC_ENABLE 1
$PIGS servo $SERVO $CENTER

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
	    POS=$[ $POS - $SERVO_STEP ]
	    $PIGS servo $SERVO $POS
	    ;;
	"s")
	    POS=$[ $POS + $SERVO_STEP ]
	    $PIGS servo $SERVO $POS
	    ;;
	"+")
	    adjust_servo_step 1
	    ;;
	"-")
	    adjust_servo_step -1
	    ;;
	"h")
	    print_help
	    ;;
	*)
	    echo "unknown command: $KEY (press h for help)"
    esac
    print_info
done
