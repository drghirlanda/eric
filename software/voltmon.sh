#!/bin/bash

## this program monitors gpio pin $PIN, which receives the output of a
## voltage monitor. if the pin reads high (1), we send SIGUSR1 to eric
## (we got eric's pid as first argument) 

set -e # fatal errors 

PIN=11 # voltage monitor gpio pin

ERIC_PID=$1

while true; do
    VMON=$(gpio -g read $PIN)
    if [[ $VMON -eq 1 ]]; then
	echo "$(date): LOW BATTERY"
	echo "$(date): terminating eric (process $ERIC_PID)"
	kill -10 $ERIC_PID
	while kill -0 $ERIC_PID; do # eric still exists
	    echo "$(date): waiting for eric to terminate"
	    sleep 5
	done
	echo "$(date): poweroff"
	sudo poweroff
    fi
    sleep 60 # check once per minute
done