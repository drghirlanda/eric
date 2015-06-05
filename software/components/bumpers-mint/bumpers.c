#include <mint.h>
#include <stdio.h>
#include <time.h>

int main( void ) {
  FILE *file;
  int i;
  struct mint_network *net;
  mint_nodes n;

  mint_random_seed( time(0) );

  mint_pi_init();

  file = fopen( "bumpers.arc", "r" );
  net = mint_network_load( file );
  fclose( file );

  mint_network_save( net, stdout );

  n = mint_network_get_nodes( net, 0 );

  for( i=0; ; i++ ) {
    mint_network_operate( net );
    if( i%10 == 0 ) {
      printf( "in:    " );
      mint_nodes_save_var( n, 0, stdout );
      printf( "out:   " );
      mint_nodes_save_var( n, 1, stdout );
      printf( "state: " );
      mint_nodes_save_var( n, 2, stdout );
    }
  }
  
  mint_network_save( net, stdout );

  return 0;
}
