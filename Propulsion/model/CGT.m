function [Fth, mdott, Pe, Ae] = CGT(P0, T0, Me, At)
%% Stagnation Properties
% http://www.peacesoftware.de/einigewerte/calc_stickstoff.php5
rho0 = P0/(R*T0);

%% Throat Properties
% Tt = T0*(2/(k+1));
rhot = rho0*(2/(k+1))^(1/(k-1));
% Pt = P0*(2/(k+1))^(k/(k-1));
Vt = sqrt(2*k/(k+1)*R*T0); % = sqrt(k*R*Tt)
mdott = rhot*At*Vt; % kg/s

%% Exhaust Properties
Pe = P0/(1+(k-1)/2*Me^2)^(k/(k-1)); % Pa
Te = T0/(1+(k-1)/2*Me^2);

% Be sure the gas is not liquifying
if Te < 70
    disp('Temperature at exhaust lower than 70K')
end

rhoe = rho0*((Pe/P0)^(1/k));
Ve = Vt*sqrt((k+1)/(k-1)*(1 - (Pe/P0)^((k-1)/k)));
gam = sqrt(k)*(2/(k+1))^((k+1)/(2*(k-1)));
Ae = At*gam/sqrt((2*k/(k-1))*(Pe/P0)^(2/k)*(1-(Pe/P0)^((k-1)/k)));
mdote = rhoe*Ae*Ve;

%% Assumptions
if abs(mdote - mdott) >= 10^-2
    disp('Error! Difference in mass flow between throat and exhaust')
end

%% Force thrust
Fth = mdote*Ve + (Pe - Pamb)*Ae;

end
