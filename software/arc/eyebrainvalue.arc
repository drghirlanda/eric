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



