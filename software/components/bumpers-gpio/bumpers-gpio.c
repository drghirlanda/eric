#include <pigpio.h>
#include <stdio.h>
#include <time.h>

void callback( int gpio, int level, uint32_t tick ) {
  printf( "%u: gpio %d at level %d\n", tick, gpio, level );
  fflush( stdout );
}

int main( void ) {
  gpioInitialise();
  gpioSetAlertFunc( 4, callback );
  sleep( 10 );
  gpioTerminate();
  return 0;
}
