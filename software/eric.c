#include "mint.h"
#include <stdio.h>
#include <signal.h>

struct mint_network *net;

void handler( int signum ) {
  FILE *file;

  file = fopen( "eric.out", "w" );
  mint_network_save( net, file );
  fclose( file );
  mint_network_del( net );
}

int main( void ) {
  FILE *file;
  int i;
  mint_nodes value;

  signal( SIGINT, handler );

  mint_image_init();
  mint_camera_init();

  file = fopen( "eric.arc", "r" );
  net = mint_network_load( file );
  fclose( file );

  file = fopen( "eric.dot", "w" );
  mint_network_graph( net, file );
  fclose( file );

  i = mint_network_nodes_find( net, "value" );
  mint_check( i >= 0, "cannot find nodes 'value'");
  value = mint_network_nodes( net, i );

  for( ;; ) {
    mint_network_operate( net );
    fprintf( stdout, "%f\n", value[1][0] );
    fflush( stdout );
  }

  file = fopen( "eric.out", "w" );
  mint_network_save( net, file );
  fclose( file );


  mint_network_del( net );

  return 0;
}
