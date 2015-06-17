nodes explore_speed
  size 1
  noise 5 1e-1 0
  logistic 

# FIX see bumpers.arc for this hack
weights explore_speed-explore_speed
0

weights explore_speed-speed
5

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

