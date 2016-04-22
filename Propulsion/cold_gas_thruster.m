function output = cold_gas_thruster(t_prop, dt, sitch)

%% Constants
config = config_info(sitch, 'air');
Ti = config.Ti;
Pi = config.Pi;
V = config.V;
At = config.At;
k = config.k;
R = config.R;
Me = config.Me;

%% Setup empty variable storage
P0 = []; T0 = []; Tt = []; Pt = []; Vt = []; Pe = []; Te = []; Ve = [];
mass_loss = [];

%% Get exit area
Ae = At/Me*(((k+1)/2)/(1 + (k-1)/2*Me^2))^(-(k+1)/(2*(k-1)));

%% Transient behavior
for t=0:dt:t_prop
    [P0(end+1), T0(end+1)] = tank(Ti, Pi, V, At, k, R, t);
    mass_loss(end+1) = P0(1)*V/(R*T0(1)) - P0(end)*V/(R*T0(end));
    [Tt(end+1), Pt(end+1), Vt(end+1)] = nozzle_converging(T0(end), P0(end), k, R);
    [Pe(end+1), Te(end+1), Ve(end+1)] = nozzle_diverging(T0(end), P0(end), Me, k, R);
end

%% Determine the thrust produced over time
mdot = Pe./(R*Te).*(Me.*sqrt(k*R.*Te))*Ae;
Fth = Ve.*mdot + (Pe - config.Pvac)*Ae;

%% Find the toal impulse in the alloted time
output.I = trapz(Fth);

%% Output conditions
output.T0 = T0;
output.P0 = P0;
output.Te = Te;
output.Pe = Pe;
output.mdot = mdot;
output.Fth = Fth;
output.Tt = Tt;
output.Pt = Pt;
output.mass_loss = mass_loss;
end