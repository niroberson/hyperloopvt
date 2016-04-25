function [gt, gx, gv] = full_velocity_profile(dt, mPod, l_track)
%% Constants
l_track = 1609.34; % 5280 ft or 1 mile
l_pusher= 243.84; % 800 ft

%% Set up global trackers
gt = 0;
gv = 0;
gx = 0;

%% Get propulsion forces
t_prop = 6;
[Fth, mass_loss] = propulsion(t_prop, dt);

%% Run trajectory
i = 1;
t_pusher = 0;
mPodt = [];
for t=0:dt:20
    if gx(end) < l_pusher
        t_pusher = t;
        at = pusher(mPod)/mPod;
    elseif t - t_pusher > t_prop
        aBrakes = brake(gx(end), gv(end), l_track);
        Factual = - magnetic_drag(gv(end)) - aBrakes*mPodt(end);
        at = Factual/mPodt(end);
    else
        Factual = Fth(i) - magnetic_drag(gv(end));
        mPodt(end+1) = mPod - mass_loss(i);
        at = Factual/mPodt(end);
        i = i+1;
    end
    
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

function [Fth, mass_loss] = propulsion(t_prop, dt)
%% Nitrogen
sitch = 'production';
output = cold_gas_thruster(t_prop, dt, sitch);
Fth = output.Fth;
mass_loss = output.mass_loss;
end

function aBrakes = brake(x, v, l_track)
    aBrakes = v^2/(2*(l_track - x));
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