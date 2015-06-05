network
clocked 10
nodes bumper
  size 1
  states 2
  gpiosensor 4 .1 0 2
  integrator 5 .2 0 1

weights bumper-bumper
0

nodes speed 
  size 1 
  states 2
  logistic 0.5 1 # output to 0 is motor's indifference point
  dcmotor 25 23 24 0.5 0

nodes direction 
  size 1 
  states 1 
  logistic 0.5 1 
  servomotor 21 930 2370 0

weights bumper-speed
-5

weights bumper-direction
-5





