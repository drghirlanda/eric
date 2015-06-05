nodes explore
  size 3
  states 1
  noise 1.25 .025 0
  integrator 10 0.1 0 1
  habituation 30 .1 2 1
  bounded 0 1 1

#weights brain-explore
#  normal 0 0.01 0.05
#  delta 1e-5 2

#weights value-explore
#  target 2
#  normalize 1

weights explore-explore
0 -5 .5
-5 0 .5
0 0 0

weights explore-direction
-20
20
0

weights explore-speed
0
0
15

