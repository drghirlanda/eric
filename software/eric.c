#include <mint.h>
#include <stdio.h>
#include <time.h>
#include <signal.h>

struct mint_network *net;

/* this handler saves the network when SIGUSR1 is received */

void handler( int signum ) {
  FILE *file;

  fprintf( stderr, "caught signal %d:\n", signum );
  fprintf( stderr, "saving eric to 'eric-trained.arc'\n" );

  file = fopen( "eric-trained.arc", "w" );
  mint_network_save( net, file );
  fclose( file );

  mint_network_del( net );

  fprintf( stderr, "exiting eric\n" );

  exit( EXIT_SUCCESS );
}

int main( void ) {
  FILE *file;
  int i, c;
  mint_nodes value, explore, bumperFL;
  float old_value;

  signal( SIGUSR1, handler );

  mint_random_seed( time(0) );

  mint_image_init();
  mint_camera_init();

#ifdef MINT_PI
  mint_pi_init();
#endif

  file = fopen( "eric.arc", "r" );
  net = mint_network_load( file );
  fclose( file );

  file = fopen( "eric.dot", "w" );
  mint_network_graph( net, file );
  fclose( file );

  value = mint_network_find_nodes( net, "value" );
  explore = mint_network_find_nodes( net, "explore" );
  bumperFL = mint_network_find_nodes( net, "bumperFL" );

  old_value = -1;

  for( ;; ) {
    mint_network_operate( net );
    if( value[1][0] != old_value ) {
      printf( "%f\n", value[1][0] );
      old_value = value[1][0];
    }
    if( explore ) {
      printf( "explore: " );
      mint_nodes_save_var( explore, 1, stdout );
    }
    if( bumperFL ) {
      printf( "bumperFL: " );
      mint_nodes_save_var( bumperFL, 1, stdout );
    }
  }

  return 0;
}
