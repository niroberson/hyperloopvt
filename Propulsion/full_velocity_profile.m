function [gt, gv] = full_velocity_profile(mPod)
%% Constants
l_track = 1609.34; % 5280 ft or 1 mile
l_pusher= 243.84; % 800 ft
mPod = 270; % kg
dt = 0.1;

%% Set up global trackers
gt = 0;
gv = 0;
gx = 0;

%% Get propulsion forces
t_prop = 3;
Fth = propulsion(t_prop);
t_pusher = 0;
%% Run trajectory
i = 1;
for t=0:dt:25
    if gx(end) < l_pusher
        Factual = pusher(mPod);
        t_pusher = t;
    elseif t - t_pusher > t_prop
        Fbrakes = brake(gv(end));
        Factual = - magnetic_drag(gv(end)) - Fbrakes;
    else
        Factual = Fth(i) - magnetic_drag(gv(end));
        i = i+1;
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
subplot(2,1,1)
plot([gt(1) gt(end)], [mean(gv) mean(gv)])
legend({'Average Velocity'})
plot(gt, gv)
xlabel('Time (s)')
ylabel('Velocity (m/s)')

subplot(2,1,2)
plot(gx, gv)
xlabel('Position (m)')
ylabel('Velocity (m/s)')
end

%% Run Brakes
function Fpush = pusher(mPod)
%% Pusher Acceleration
% v = v0 + 1/2at^2
aPush = 2*9.8;
Fpush = aPush*mPod;
end

function Fth = propulsion(t_prop)
%% Nitrogen
configuration = 'converging-diverging';
[Fth, I, Ae] = cold_gas_thruster(configuration, t_prop);
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