# innate defense reflexes for eric

# front-left bumper sensor. projects to speed and direction nodes to
# back off and counter-steer when the bumper detects a collision.
nodes bumperFL
  size 1
  states 1
  gpiosensor 4 1 0 2 # node input +1 when pin 4 becomes active
  integrator 1 .1 0 1
  bounded 0 1 1

# FIX: hack to have bumper input reset, better way is needed
weights bumperFL-bumperFL
0

weights bumperFL-speed
-2

weights bumperFL-direction
-1.5

# front-right sensor. same logic as previous sensor
nodes bumperFR
  size 1
  states 1
  gpiosensor 17 1 0 2
  integrator 1 .1 0 1
  bounded 0 1 1

weights bumperFR-bumperFR
0

weights bumperFR-speed
-2

weights bumperFR-direction
1.5

