%% Flow parameters
Pc = 6.895e+6; % Pascals Chamber Pressure
Pi = 3.1026e+7; % Pascals Tank Pressure
V = 0.06737; % m3 Tank Volume
Ti = 300; % K Tank gas temperature

%% Gas Parameters
k = 1.4;
R = 287;

%%
t = 0:30;
gas_propulsion(Pi, Ti, V, Pi, k, R, t)