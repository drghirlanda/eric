/* calibrate eric's servomotor to center correctly */

#include <pigpio.h>
#include <stdio.h>
#include <stdlib.h>

int enable_pin = 27;
int output_pin = 22;
int control_pin = 17;

int main( void ) {
  int i, c;
  int rot_max, rot_min, position;
  
  rot_max = 0;
  rot_min = 0;

  gpioInitialise();

  i = gpioSetMode( control_pin, PI_OUTPUT );
  if( i !=0 ) {
    printf("cannot set control pin mode to output" );
    exit( EXIT_FAILURE );
  }

  i = gpioSetMode( enable_pin, PI_OUTPUT );
  if( i !=0 ) {
    printf("cannot set enable pin mode to output" );
    exit( EXIT_FAILURE );
  }

  i = gpioSetMode( output_pin, PI_OUTPUT );
  if( i !=0 ) {
    printf("cannot set output pin mode to output" );
    exit( EXIT_FAILURE );
  }

  i = gpioWrite( enable_pin, 1 );
  if( i != 0 ) {
    printf("cannot set enable pin" ); 
    exit( EXIT_FAILURE );
  }


  i = gpioWrite( output_pin, 1 );
  if( i != 0 ) {
    printf("cannot output enable pin" ); 
    exit( EXIT_FAILURE );
  }

  position = 1500;

  i = gpioServo( control_pin, position );
  if( i != 0 ) {
    printf("cannot write to control pin" ); 
    exit( EXIT_FAILURE );
  }

  do {
    c = getc( stdin );
    switch( c ) {
    case 'a':
      position -= 10; break;
    case 's': 
      position += 10; break;
    case 'm':
      rot_min = position; break;
    case 'M':
      rot_max = position; break;
    case 'q':
      exit( EXIT_SUCCESS );
    }

    printf( "rot_min = %d\nrot_max = %d\nposition = %d\n\n", 
	    rot_min, rot_max, position );

    gpioServo( control_pin, position );

  } while( 1 );

  return 0;
}

