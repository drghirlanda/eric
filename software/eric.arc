network
#  camera
  clocked 10 1
  threads 4 1 1
#  display
#  events

# brain:
nodes brain 
  size 400 
  states 1 
  rows 20
  noise 0 .01 0 
  integrator 1 0.15 0 2
  logistic 0.05 1 2 1

weights brain-brain
  sparse
  normal -0.25 0.35 0.15

# value system:
nodes value 
  size 1
#  key 49 1 0.99 0
#  key 50 1 0.01 0

# effector system for eric: one dcmotor to control forward/backward
#  movement and one servomotor to steer, both connected to the brain
#  by plastic connections

nodes speed 
  size 1 
  states 2
  logistic 0.5 1 # output to 0 is motor's indifference point
  dcmotor 25 23 24 0.5 0

#weights brain-speed 
#  uniform 0.01 0.1 0.1
#  delta 1e-5 3

#weights value-speed
#  target 3
#  normalize 1

nodes direction 
  size 1 
  states 1 
  logistic 0.5 1 
  servomotor 21 930 2370 0

#weights brain-direction 
#  uniform -0.1 0.1 0.1 
#  delta 1e-5 3

#weights value-direction
#  target 2
#  normalize 1

# innate defense reflexes for eric

# front-left bumper sensor. projects to speed and direction nodes to
# back off and counter-steer when the bumper detects a collision
nodes bumperFL
  size 1
  states 1
  gpiosensor 4 1 0 # node input +1 when pin 2 becomes active
  integrator 1 .1 0 2 # fast reaction, slowish decay
  logistic .001 10 2 1 # low 0 value, high gain

weights bumperFL-speed
-10

weights bumperFL-direction
-10

# front-right sensor. same logic as previous sensor
nodes bumperFR
  size 1
  states 1
  gpiosensor 17 1 0
  integrator 1 .1 0 2
  logistic .001 10 2 1

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
  logistic .001 10 2 1

weights bumperR-direction
-10

# left sensor
nodes bumperL
  size 1
  states 1
#  gpiosensor 11 1 0
  integrator 1 .1 0 2
  logistic .001 10 2 1

weights bumperL-direction
10


# back sensor
nodes bumperB
  size 1
  states 1
# gpiosensor 11 1 0
  integrator 1 .1 0 2
  logistic 0.001 10 2 1

weights bumperB-speed
10
