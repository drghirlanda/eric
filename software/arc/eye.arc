# artificial retina:
nodes eye
  size 768
  states 1
  rows 24
  color 1 1 1 1

weights eye-brain 
  sparse
  normal .1 0.15 0.05

weights eye-speed
  sparse
  uniform 0 1 0.1
