network
camera

# artificial retina
nodes eyeR size 768 rows 24 red
nodes eyeG size 768 rows 24 green
nodes eyeB size 768 rows 24 blue

# value system
nodes value size 1 sigmoid 0.01 1.5

# brain
nodes brain 
  size 49 
  states 1 
  rows 7 
  integrator 10 0.1 0 2
  sigmoid 0.01 1 2 1

# control of forward/backward movement
nodes speed 
size 1 states 1 sigmoid 0.5 1 
#dcmotor 25 23 24

# control of direction
nodes direction 
size 1 states 1 sigmoid 0.5 1 
#servomotor 17 750 2250 0 27 22

# connections from eye to brain
weights eyeR-brain normal 0 0.1 0.1 delta 0.1
#weights eyeG-brain normal 0 0.1 0.1 delta 0.1
#weights eyeB-brain normal 0 0.1 0.1 delta 0.1

# brain to motors
weights brain-speed uniform 0.2 0.2 delta 0.1
weights brain-direction uniform 0.2 0.2 delta 0.1

# connections involving value system
weights eyeR-value normalize 10
#weights eyeG-value normalize -5
#weights eyeB-value normalize -5
weights value-brain target 2 normalize 1
#weights value-speed target 2 normalize 1
#weights value-direction target 2 normalize 1

# innate defense reflexes
nodes bumper_fl
  size 1
  states 1
  gpiosensor 11 1 0 # pin, increment, state (input)
  integrator 1 .1 0 2 # fast reaction, slowish decay
  sigmoid .001 10 2 1 # mapping of state

## the two following weights force reverse + countersteering when the
## front-left bumper is activated

weights bumper_fl-speed
-10

weights bumper_fl-direction
-10


