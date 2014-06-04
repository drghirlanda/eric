#!/bin/bash

## this program monitors gpio pin $PIN, which receives the output of a
## voltage monitor. if the pin reads high (1), we send SIGUSR1 to eric
## (we got eric's pid as first argument) 

## check for gpio utility:
gpio >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "voltmon.sh: gpio utility not found"
    echo "voltmon.sh: voltage monitoring disabled"
    exit
fi

INTERVAL=60             # check every so many seconds
ERIC_PID=$1             # used to signal eric to exit
set -e                  # fatal errors 
PIN=11                  # voltage monitor gpio pin
gpio -g $PIN mode input # ensure correct mode on pin

while true; do
    VMON=$(gpio -g read $PIN)
    if [[ $VMON -eq 1 ]]; then
	echo "$(date): LOW BATTERY"
	echo "$(date): terminating eric (process $ERIC_PID)"
	sudo kill -10 $ERIC_PID
	while sudo kill -0 $ERIC_PID; do # eric still exists
	    echo "$(date): waiting for eric to terminate"
	    sleep 5
	done
	echo "$(date): poweroff"
	sudo poweroff
    fi
    sleep $INTERVAL # check every so often
done
