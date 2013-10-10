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
