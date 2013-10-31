#!/bin/sh
set -ex
cc -o calibration calibration.c -lrt -lpigpio
sudo ./calibration