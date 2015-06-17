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
  mint_nodes value, explore_dir, explore_speed, bumperFL;
  float old_value;

  signal( SIGUSR1, handler );

  mint_random_seed( time(0) );

  mint_image_init();
  mint_camera_init();
  mint_pi_init();

  file = fopen( "eric.arc", "r" );
  net = mint_network_load( file );
  fclose( file );

  /* mint_network_info( net, stdout ); */

  file = fopen( "eric.dot", "w" );
  mint_network_graph( net, file );
  fclose( file );

  value = mint_network_find_nodes( net, "value" );
  explore_dir = mint_network_find_nodes( net, "explore_dir" );
  explore_speed = mint_network_find_nodes( net, "explore_speed" );
  bumperFL = mint_network_find_nodes( net, "bumperFL" );

  old_value = -1;

  for( ;; ) {
    mint_network_operate( net );
    if( value[1][0] != old_value ) {
      printf( "%f\n", value[1][0] );
      old_value = value[1][0];
    }
    /* if( explore_dir ) { */
    /*   printf( "explore_dir: " ); */
    /*   mint_nodes_save_var( explore_dir, 1, stdout ); */
    /* } */
    /* if( explore_speed ) { */
    /*   printf( "explore_speed: " ); */
    /*   mint_nodes_save_var( explore_speed, 1, stdout ); */
    /* } */
    /* if( bumperFL ) { */
    /*   printf( "bumperFL:\n\t" ); */
    /*   mint_nodes_save_var( bumperFL, 0, stdout ); */
    /*   printf( "\t" ); */
    /*   mint_nodes_save_var( bumperFL, 1, stdout ); */
    /* } */
  }

  return 0;
}
