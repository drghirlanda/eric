network
  camera
  clocked 10 1
  threads 4 1 1
#  events

# brain:
nodes brain 
  size 100
  states 1 
  rows 10
  noise 0 .01 0 
  integrator 1 0.15 0 2
  logistic 0.05 1 2 1

weights brain-brain
  sparse
  normal -0.25 0.35 0.1

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

nodes explore_speed
  size 1
  noise 5 1e-1 0
  logistic 

# FIX see bumpers.arc for this hack
weights explore_speed-explore_speed
0

#weights explore_speed-speed
#5

nodes explore_dir
  size 2
  states 1
  noise 2 .2 0
  integrator 10 0.1 0 1
  habituation 40 .1 2 1
  bounded 0 1 1

weights explore_dir-explore_dir
0 -1.5
-1.5 0

weights explore_dir-direction
-2
2

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

