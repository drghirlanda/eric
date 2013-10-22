#include <mint.h>
#include <stdio.h>
#include <time.h>

struct mint_network *net;


int main( void ) {
  FILE *file;
  int i, c;
  mint_nodes value;
  float old_value;

  mint_random_seed( time(0) );

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

  old_value = -1;

  for( ;; ) {
    mint_network_operate( net );
    if( value[1][0] != old_value ) {
      printf( "%f\n", value[1][0] );
      old_value = value[1][0];
    }
  }

  file = fopen( "eric.out", "w" );
  mint_network_save( net, file );
  fclose( file );


  mint_network_del( net );

  return 0;
}
