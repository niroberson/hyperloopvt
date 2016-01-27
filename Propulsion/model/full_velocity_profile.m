function full_velocity_profile()
%% Constants
l_track = 1609.34; % 5280 ft or 1 mile
mPod = 500; % kg
dt = 0.001;

%% Set up global trackers
gt = [];
gv = [];
gx = [];

%% Experience pusher
[xpush, tpush, Vpush] = pusher();
gt = tpush;
gx = xpush;
gv = Vpush;

%% Run propulsion
for t=0:dt:15
    Fth = propulsion(t);
    Factual = Fth - magnetic_drag(gv(end));
    at = Factual/mPod;
    vNext = gv(end) + 0.5*at*dt^2;
    dx = (vNext^2 - gv(end)^2)/(2*at);
    
    % Track timestep
    gt(end+1) = gt(end) + dt;
    gx(end+1) = gx(end) + dx;
    gv(end+1) = vNext;  
end

%% Run Coast
for t = 0:dt:15
   Factual = -magnetic_drag(gv(end));
   at = Factual/mPod;
   vNext = gx(end) + 0.5*at*dt^2;
   dx = (vNext^2 - gv(end)^2)/(2*at);
   
% Track timestep
   gt(end+1) = gt(end) + dt;
   gx(end+1) = gx(end) + dx;
   gv(end+1) = vNext;
end

%% Run brakes
for t = 0:dt:15
   Fbrakes = brake(gv(end));
   Factual = -mangetic_drag(gv(end))-Fbrakes;
   at = Factual/mPod;
   vNext = gx(end) + 0.5*at*dt^2;
   dx = (vNext^2 - gv(end)^2)/(2*at);
   
   % Track timestep
   gt(end+1) = gt(end) + dt;
   gx(end+1) = gx(end) + dx;
   gv(end+1) = vNext;
end

figure,plot(gt, gv)

end

%% Run Brakes
function [xpush, tpush, Vpush] = pusher()
%% Pusher Acceleration
% v = v0 + 1/2at^2
l_pusher= 243.84; % 800 ft
xpush = 0:l_pusher;
aPush = 2*9.8;
Vpush = sqrt(2*aPush.*xpush);
tpush = sqrt(Vpush(end)*2./aPush);
end

function Fth = propulsion(tprop)
%% Nitrogen
k = 1.4;
R = 297;
Fth = isentropic_time(k, R, tprop);
end

function Force_z = brake(v)
    %% Calculate Eddy Brake Drag
    profile = 'Brakes';
    
    width = .045; % Width (m)
    tau = width/1.5; % Pole pitch (m)
    h = 0.0635; % Heigh of permanent magnet (m)
    P = 24;

    % Track Parameters
    l = 0.0079502; % Thickness of track (m)
    rho_track = 3.99*1e-8; % Resistivity of track (Ohm*m)
    
    % Air gap Parameters
    d1 = 0.010; % Upper air gap (m)
    d2 = 0.010; % Lower air gap (m)
    
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
     weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                            = DoubleHalbachModel(v,M,tau,Br,h,width,...
                                                 P,l,rho_track,d1,d2,...
                                                 coeff,profile,Jc,Jm);
end

function Force_z = magnetic_drag(v)
%%
width = 0.100; % Width of magnet (m)
tau = width/1.5; % Pole pitch (m)
h = tau*.4; % Height of permanent magnet (m)
P = 5; % Number of arrays to simulate

% Track Parameters
l = 0.0127; % Thickness of track (m)
rho_track = 2.8*1e-8; % Resistivity of track (Ohm*m)
sigma = 1/rho_track;

% Global Magnet Parameters
M = 4; % Number of Magnets in Wavelength
Br = 1.48; % Magnet remanence (T)
Jc = 0;
Jm = 0;    

% Air gap Parameters
d1 = 0.020; 
d2 = 0;         % Lower air gap (m)    
coeff = 'Set2';
profile = 'Single';

[Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
     weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                            = DoubleHalbachModel(v,M,tau,Br,h,width,...
                                                 P,l,rho_track,d1,d2,...
                                                 coeff,profile,Jc,Jm);
end