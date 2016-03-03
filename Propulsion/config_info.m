function config = config_info(tank, propellant)
%% Initial conditions
Ti = 273.15; % K
Pvac = 861.84466;
%% Tank Choice
switch tank
    case 'big_tank'
        V = 0.1206907; % m3 Tank Volume
        Pi = 2.3442e+7; % Pascals Tank Pressure
        At = (8/1000)^2*pi; % 3/4 in pipe
    case 'small_tank'
        V = 0.0672689;
        Pi = 3.1026e+7;
        At = (4.6/1000)^2*pi;
    case 'full_scale'
        V = 0.36; % m3 Tank Volume
        Pi = 2.3442e+7; % Pascals Tank Pressure
        At = (10/1000)^2*pi; % 3/4 in pipe
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
config.Pvac = Pvac;

end
