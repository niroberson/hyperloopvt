function [gt, gx, gv] = full_velocity_profile(dt, mPod)
%% Constants
l_track = 1609.34; % 5280 ft or 1 mile
l_pusher= 243.84; % 800 ft

%% Set up global trackers
gt = 0;
gv = 0;
gx = 0;

%% Get propulsion forces
t_prop = 10;
Fth = propulsion(t_prop, dt);

%% Run trajectory
i = 1;
t_pusher = 0;
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

end

%% Run Brakes
function Fpush = pusher(mPod)
%% Pusher Acceleration
% v = v0 + 1/2at^2
aPush = 2*9.8;
Fpush = aPush*mPod;
end

function Fth = propulsion(t_prop, dt)
%% Nitrogen
sitch = 'production';
output = cold_gas_thruster(t_prop, dt, sitch);
Fth = output.Fth;
end

function Force_z = brake(v)
    %% Calculate Eddy Brake Drag
%     parameters = 'Hyperloop-Brakes';
    
%     [vfinal,profile,M,tau,Br,h,width,l,rho_track,d1,d2,P,PodWeight]...
%           = ParameterSelect(parameters);
%     
%     [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
%           weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
%                                 = DoubleHalbachModel(parameters,v,d1,h);
    
    Force_z = 4000;
end

function Force_z = magnetic_drag(v)
    %% Calculate Levitation Drag
    parameters = 'Hyperloop-Stilts';
    
    [vfinal,profile,M,tau,Br,h,width,l,rho_track,d1,d2,P,PodWeight]...
          = ParameterSelect(parameters);
    
    [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
          weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModelNew(parameters,v,d1,h);
end