network
  camera 32 24
  clocked 10 1
#  threads 4 0 1
#  display
#  events

# brain:
nodes brain 
  size 49
  states 1 
  rows 7
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

