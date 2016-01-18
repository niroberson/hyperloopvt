function Fth = CGT(P0, T0, Me, At)
%% Gas constans
k = 1.4;
R = 297;
Isp = 73;
g = 9.81;

%% Stagnation Properties
Z = 1.0899825392; % http://www.peacesoftware.de/einigewerte/calc_stickstoff.php5
% Needs to be a lookup or calculation
rho0 = P0/(Z*R*T0);

%% Throat Properties
Tt = T0*(2/(k+1));
rhot = rho0*(2/(k+1))^(1/(k-1));
Pt = P0*(2/(k+1))^(k/(k-1));
Vt = sqrt(2*k/(k+1)*R*T0); % = sqrt(k*R*Tt)
mdott = rhot*At*Vt; % kg/s

%% Exhaust Properties
Pe = P0/(1+(k-1)/2*Me^2)^(k/(k-1)); % Pa
Te = T0/(1+(k-1)/2*Me^2);
Z_e = 0.8637; % Needs to be a lookup or calculation
rhoe = rho0*((Pe/P0)^(1/k));
Ve = Vt*sqrt((k+1)/(k-1)*(1 - (Pe/P0)^((k-1)/k)));
gam = sqrt(k)*(2/(k+1))^((k+1)/(2*(k-1)));
Ae = At*gam/sqrt((2*k/(k-1))*(Pe/P0)^(2/k)*(1-(Pe/P0)^((k-1)/k)));
mdote = rhoe*Ae*Ve;
Fth = mdote*Ve;

end