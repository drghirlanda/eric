VCrit = 6;         # voltage at which regulator fails (V)
VI = 8.5;          # voltage with full battery (V)
VIT = VCrit + 0.5; # voltage at which to shut down (V)
Is = 25e-9;        # comparator leakage current (A)
IR1 = 1e-4;        # wasted current (A)
VREF = 0.405       # comparator reference voltage

R2 = VI / ( IR1 * VIT / VREF - Is )
R1 = R2 * ( VIT / VREF - 1 )
accuracy = R1 * Is / VIT;
