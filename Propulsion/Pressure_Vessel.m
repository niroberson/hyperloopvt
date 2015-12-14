%% Goal of this analysis, output a pressure and velocity of flow given thickness of tank
E = 200e3; %modulus of elasticity for structural A-36 steel in mPascals
t = 0.0254*[0.25 0.5 0.75 1 1.25 1.5 1.75 2] ;%assumed thickness in m
D_0 = 0.3048; %outer diameter in m
D = D_0 - (2.*t); %inner diameter in m
L_TT = 2.4384; %cylinder length in m
L = L_TT + ((1/3)*D); %total length in m for hemi head
L_D0 = L/D_0; %L/D_0 ratio
D0_t = D_0./t; %D_0/t ratio
A = [0.005 0.018 0.05 0.1 0.1 0.18 0.26 0.31]; %A factor
B = [51 106 120 122 122 122 122 122]; %B factor for chart equation
Pa_1 = (2*A*E)./(3*D0_t) %P_a values for A values (focus on last two values in vector)
Pa_2 = (4*B)./(3*D0_t) %P_a values from chart