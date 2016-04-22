function config = config_info(sitch, propellant)
%% Tank Choice
V = 0.1206907; % m3 Tank Volume
Pi = 2.3442e+7; % Pascals Tank Pressure
At = (7.874/1000)^2*pi; % Nozzle area
Me = 2.1;

switch sitch
    case 'testing'
        %% Initial conditions
        Ti = 273.15; % K
        Pamb = 101352.9; % stp
    case 'production'
        %% Initial conditions
        Ti = 273.15; % K
        Pamb = 861.84466;
end

%% Propellant Choice
switch propellant
    case 'air'
        % Air
        T_min = 78.8;
        k = 1.4;
        R = 287;
    case 'nitrogen'
        % Nitrogen
        T_min = 77;
        k = 1.4;
        R = 297;
end
    
%% Construct config
config = struct();
config.k = k;
config.R = R;
config.T_min = T_min;
config.At = At;
config.V = V;
config.Pi = Pi;
config.Ti = Ti;
config.Pamb = Pamb;
config.Me = Me;

end
