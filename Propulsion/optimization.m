function [V, Pi, At, T_min, k, R] = optimization(tank, propellant)
    %% Tank Choice
    switch tank
        case 'big_tank'
            V = 0.1206907; % m3 Tank Volume
            Pi = 2.3442e+7; % Pascals Tank Pressure
            At = (9.4/1000)^2*pi; % 3/4 in pipe
        case 'small_tank'
            V = 0.0672689;
            Pi = 3.1026e+7;
            At = (4.6/1000)^2*pi;
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
end
