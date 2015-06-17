network
  camera
  clocked 10 1
  threads 4 0 1
#  display
#  events

# brain:
nodes brain 
<<<<<<< HEAD
  size 100
  states 1 
  rows 10
=======
  size 49
  states 1 
  rows 7
>>>>>>> 2a2f9462f461f731f14b2d696442cfc3b7d203ff
  noise 0 .01 0 
  integrator 1 0.15 0 2
  logistic 0.05 1 2 1

weights brain-brain
  sparse
<<<<<<< HEAD
  normal -0.25 0.35 0.1
=======
  normal -0.25 0.3 0.15
>>>>>>> 2a2f9462f461f731f14b2d696442cfc3b7d203ff

# value system:
nodes value 
  size 1
#  key 49 1 0.99 0
#  key 50 1 0.01 0

