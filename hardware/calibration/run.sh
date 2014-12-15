#!/bin/sh
set -ex
## pin numbers:
ENABLE=27
OUTPUT=22
CONTROL=17

cat > calibration.h <<EOF
int enable_pin = ${ENABLE};
int output_pin = ${OUTPUT};
int control_pin = ${CONTROL};
EOF

cc -o calibration calibration.c -lrt -lpigpio
sudo ./calibration
