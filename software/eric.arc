network
  camera
  clocked 100
  threads 8 1 1
  display

# artificial retina:
nodes eye
  size 768
  states 1
  rows 24
  red .3 green .3 blue .3

# value system:
nodes value 
  size 1 

# brain:
nodes brain 
  size 400 
  states 1 
  rows 20
  noise 0 .01 0 
  integrator 2.5 0.2 0 2
  sigmoid 0.05 1 2 1

weights brain-brain
  sparse
  normal -0.125 0.35 0.15

weights eye-brain 
  sparse
  normal .1 0.15 0.05



# effector system for eric: one dcmotor to control forward/backward
#  movement and one servomotor to steer, both connected to the brain
#  by plastic connections

nodes speed 
  size 1 
  states 2
  noise 0.1 0.2 0 
  sigmoid 0.5 1 # output to 0 is motor's indifference point
#  dcmotor 25 23 24

weights brain-speed 
  uniform 0.01 0.01 0.1
  delta 0.01 3

weights value-speed
  target 3
  normalize 1

#nodes direction 
#  size 1 
#  states 1 
#  sigmoid 0.5 1 
#  servomotor 17 1200 1800 0 27 22

#weights brain-direction 
#  uniform 0.2 0.2 
#  delta 0.1