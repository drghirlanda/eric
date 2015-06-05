#!/bin/sh
set -ex
cc -o bumpers-gpio bumpers-gpio.c -lpigpio -pthread -lrt
sudo ./bumpers-gpio