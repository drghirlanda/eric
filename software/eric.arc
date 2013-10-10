network
camera
clocked 24
threads 8 1 1
display

# artificial retina:
nodes eyeR 
  size 768 
  rows 24 
  red
nodes eyeG 
  size 768 
  rows 24 
  green
nodes eyeB 
  size 768 
  rows 24 
  blue

# value system:
nodes value 
  size 1 
  red -.5 0 green -0.5 0 blue 1 0
  sigmoid 0.01 1.5

# brain:
nodes brain 
  size 49 
  states 1 
  rows 7 
  integrator 10 0.1 0 2
  sigmoid 0.01 1 2 1

weights brain-brain
  normal 0 0.1 0.1

# connections from eye to brain:
weights eyeR-brain 
  sparse
  normal 0 0.01 0.1 
  delta 0.0001
weights eyeG-brain 
  sparse
  normal 0 0.01 0.1 
  delta 0.0001
weights eyeB-brain
  sparse
  normal 0 0.01 0.1
  delta 0.0001

# value-brain
weights value-brain 
  target 2 # used by delta rule
  normalize 1




# effector system for eric: one dcmotor to control forward/backward
#  movement and one servomotor to steer, both connected to the brain
#  by plastic connections

nodes speed 
  size 1 
  states 1 
  sigmoid 0.5 1 # output to 0 is motor's indifference point
#  dcmotor 25 23 24

weights brain-speed 
  uniform 0.2 0.2 
  delta 0.1

nodes direction 
  size 1 
  states 1 
  sigmoid 0.5 1 
#  servomotor 17 1200 1800 0 27 22

weights brain-direction 
  uniform 0.2 0.2 
  delta 0.1
