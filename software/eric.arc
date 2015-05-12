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
  dcmotor 16 19 23

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
  servomotor 21 800 1200 0

#weights brain-direction 
#  uniform -0.1 0.1 0.1 
#  delta 1e-5 3

#weights value-direction
#  target 2
#  normalize 1

nodes explore
  size 3
  states 1
  noise 0.1 .2 0
  habituation 50 1 2 0
  integrator 15 0.05 0 1
  logistic 0.001 1

#weights brain-explore
#  normal 0 0.01 0.05
#  delta 1e-5 2

#weights value-explore
#  target 2
#  normalize 1

weights explore-explore
0 -1.5 -1.5
-1.5 0 -1.5
-1.5 -1.5 0

weights explore-direction
-10 
10
0

weights explore-speed
0
0
1

