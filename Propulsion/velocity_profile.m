%% Acceleration profile Constants
l_track = 1609.34; % 5280 ft or 1 mile
V0 = 0; % mps
mPod = 500; % kg

%% Pusher Acceleration
l_pusher= 243.84; % 800 ft
aPush = 2*9.8;
Vpush = sqrt(V0^2 + 2*aPush*l_pusher);

%% Propulsion
Fmax = 
l_prop = l_track - l_pusher - l_braking;

%% Drag during coast 
Fda = 15; % N
Fdm = 100; % N
Fd = Fda + Fdm

%% Braking
aB = -2*9.8; % Max acceleration of braking
Vf = 0;
xB =  