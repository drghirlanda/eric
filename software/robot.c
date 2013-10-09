#include "mint.h"
#include <stdio.h>

int main( void ) {
  struct mint_network *net;
  FILE *file;
  int i;
  mint_nodes value;

  mint_image_init();
  mint_camera_init();

  file = fopen( "robot.arc", "r" );
  net = mint_network_load( file );
  fclose( file );

  file = fopen( "robot.dot", "w" );
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

  mint_network_del( net );

  return 0;
}
