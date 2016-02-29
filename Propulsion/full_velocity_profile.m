function full_velocity_profile()
%% Constants
l_track = 1609.34; % 5280 ft or 1 mile
mPod = 500; % kg
dt = 0.01;

%% Set up global trackers
gt = [];
gv = [];
gx = [];

%% Experience pusher
[xpush, tpush, Vpush] = pusher();
gt = tpush;
gx = xpush;
gv = Vpush;

%% Get propulsion forces
t_prop = 10;
Fth = propulsion(t_prop);

%% Run trajectory
for t=0:dt:20
    if t > 8.5
        Fbrakes = brake(gv(end));
        Factual = Fth(t) - magnetic_drag(gv(end)) - Fbrakes;
    else
        Factual = Fth(t) - magnetic_drag(gv(end));
    end
    
    at = Factual/mPod;
    vNext = gv(end) + at*dt;
    dx = gv(end)*dt + 0.5*at*dt^2;
    
    % Track timestep
    gt(end+1) = gt(end) + dt;
    gx(end+1) = gx(end) + dx;
    gv(end+1) = vNext;  
end

figure, hold on
plot([gt(1) gt(end)], [mean(gv) mean(gv)])
legend({'Average Velocity'})
plot(gt, gv)
xlabel('Time (s)')
ylabel('Velocity (m/s)')

figure,plot(gx, gv)
xlabel('Position (m)')
ylabel('Velocity (m/s)')
end

%% Run Brakes
function [xpush, tpush, Vpush] = pusher()
%% Pusher Acceleration
% v = v0 + 1/2at^2
l_pusher= 243.84; % 800 ft
xpush = 0:l_pusher;
aPush = 2*9.8;
Vpush = sqrt(2*aPush.*xpush);
tpush = sqrt(Vpush.*2/aPush);
end

function Fth = propulsion(t_prop)
%% Nitrogen
configuration = 'converging';
[Fth, I, Ae] = cold_gas_thruster(configuration, t_prop)
end

function Force_z = brake(v)
    %% Calculate Eddy Brake Drag
    parameters = 'Hyperloop-Brakes';
    
    [vfinal,profile,M,tau,Br,h,width,l,rho_track,d1,d2,P,PodWeight]...
          = ParameterSelect(parameters);
    
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
          weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModel(parameters,v,d1,h);
    
end

function Force_z = magnetic_drag(v)
    %% Calculate Levitation Drag
    parameters = 'Hyperloop-Stilts';
    
    [vfinal,profile,M,tau,Br,h,width,l,rho_track,d1,d2,P,PodWeight]...
          = ParameterSelect(parameters);
    
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
          weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModel(parameters,v,d1,h);
end