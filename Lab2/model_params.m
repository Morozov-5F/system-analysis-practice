Ts = 0.002;
Ns = 5000; 
Am = 1; 
NP = 0.001; 
R = 2; 
mr = 10;
carrier_frequency = 700;
for i=1:10, 
    to=round(rand * 100); 
    sim('model', Ts * Ns); 
    sum(simout) 
end;