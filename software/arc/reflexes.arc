# innate defense reflexes for eric

# front-left bumper sensor. projects to speed and direction nodes to
# back off and counter-steer when the bumper detects a collision
nodes bumperFL
  size 1
  states 1
#  gpiosensor 2 1 0 # node input +1 when pin 2 becomes active
  integrator 1 .1 0 2 # fast reaction, slowish decay
  sigmoid .001 10 2 1 # low 0 value, high gain

weights bumperFL-speed
-10

weights bumperFL-direction
-10

# front-right sensor. same logic as previous sensor
nodes bumperFR
  size 1
  states 1
#  gpiosensor 3 1 0
  integrator 1 .1 0 2
  sigmoid .001 10 2 1

weights bumperFR-speed
-10

weights bumperFR-direction
10

# right sensor
nodes bumperR
  size 1
  states 1
#  gpiosensor 11 1 0
  integrator 1 .1 0 2
  sigmoid .001 10 2 1

weights bumperR-direction
-10

# left sensor
nodes bumperL
  size 1
  states 1
#  gpiosensor 11 1 0
  integrator 1 .1 0 2
  sigmoid .001 10 2 1

weights bumperL-direction
10


# back sensor
nodes bumperB
  size 1
  states 1
# gpiosensor 11 1 0
  integrator 1 .1 0 2
  sigmoid 0.001 10 2 1

weights bumperB-speed
10
  