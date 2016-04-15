function [Fth, I, Ae, Te] = cold_gas_thruster(configuration, t_prop, config)
%% Constants
if nargin < 3
    config = config_info('big_tank', 'nitrogen');
end

Ti = config.Ti;
Pi = config.Pi;
V = config.V;
At = config.At;
k = config.k;
R = config.R;
Me = config.Me

%% Setup empty variable storage
P0 = []; T0 = []; Tt = []; Pt = []; Vt = []; Pe = []; Te = []; Ve = [];

%% Transient behavior
dt = 0.001;
for t=0:dt:t_prop
    [P0(end+1), T0(end+1)] = tank(Ti, Pi, V, At, k, R, t);
    if strcmp(configuration,'converging')
        [Te(end+1), Pe(end+1), Ve(end+1)] = nozzle_converging(T0(end), P0(end), k, R);
        Ae = At;
        Me = 1;
    elseif strcmp(configuration,'converging-diverging')
        [Tt(end+1), Pt(end+1), Vt(end+1)] = nozzle_converging(T0(end), P0(end), k, R);
        [Pe(end+1), Te(end+1), Ve(end+1)] = nozzle_diverging(T0(end), P0(end), Me, k, R);
        Ae = At/Me*(((k+1)/2)/(1 + (k-1)/2*Me^2))^(-(k+1)/(2*(k-1)));
    end
end

%% Determine the thrust produced over time
mdot = Pe./(R*Te).*(Me.*sqrt(k*R.*Te))*Ae;
Fth = Ve.*mdot + (Pe - config.Pvac)*Ae;

%% Find the toal impulse in the alloted time
I = trapz(Fth);
end