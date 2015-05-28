#include <mint.h>
#include <stdio.h>
#include <time.h>

int main( void ) {
  FILE *file;
  int i;
  struct mint_network *net;
  mint_nodes n;

  mint_random_seed( time(0) );

  file = fopen( "expldir.arc", "r" );
  net = mint_network_load( file );
  fclose( file );

  file = fopen( "expldir.dat", "w" );

  n = mint_network_get_nodes( net, 0 );

  for( i=0; i<1000; i++ ) {
    mint_network_operate( net );
    mint_nodes_save_var( n, 1, file );
  }

  fclose( file );
  return 0;
}
