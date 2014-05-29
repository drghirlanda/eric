#!/bin/sh 

## this script performs a battery test - run under 'sudo'

function pin {
    if [ $2 eq "on" ]; then
	gpio -g write $1 1
    else
	gpio -g write $1 0
    fi
}

echo "battery test starting at $(date)"

echo "putting wifi in power saving mode"
iwconfig wlan0 power saving 3

echo "enabling output pins for dcmotor and servomotor"
for PIN in 17 22 23 24 25 27; do
    gpio -g mode $PIN output
done

echo "enabling dcmotor and servomotor"
for PIN in 22 25 27; do
    pin $PIN on
done

echo "enable voltage monitor"
gpio -g 11 mode input

while true; do
    ## timestamp
    date
    ## turn on power motor for 5s
    pin 23 on
    sleep 5
    pin 23 off

    ## use some wifi
    ping -c 5 -W 10 www.google.com

    ## read voltage monitor
    VMON=$(gpio -g read 11)
    if [[ $VMON -eq 1 ]]; then
	echo "LOW VOLTAGE"
    fi
done

