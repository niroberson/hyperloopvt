%% Gas constanst
clear, clc

k = 1.4;
R = 297;
Isp = 73;
g = 9.81;
Pamb = 140; % Pa

%% Nozzle Geometry
At = (4.7500/1000)^2*pi;
Me = 3.5;
%% Stagnation Properties
% Z = 1.0899825392; % http://www.peacesoftware.de/einigewerte/calc_stickstoff.php5
Z_e = 1;
% Needs to be a lookup or calculation
P0 = 24132000;
T0 = 300;
rho0 = P0/(Z_e*R*T0);

%% Throat Properties
Tt = T0*(2/(k+1));
rhot = rho0*(2/(k+1))^(1/(k-1));
Pt = P0*(2/(k+1))^(k/(k-1));
Vt = sqrt(2*k/(k+1)*R*T0); % = sqrt(k*R*Tt)
mdott = rhot*At*Vt; % kg/s

%% Exhaust Properties
Pe = P0/(1+(k-1)/2*Me^2)^(k/(k-1)); % Pa
Te = T0/(1+(k-1)/2*Me^2);

% Z_e = 0.8637; % Needs to be a lookup or calculation
Z_e = 1;
rhoe = rho0*((Pe/P0)^(1/k));
Ve = Vt*sqrt((k+1)/(k-1)*(1 - (Pe/P0)^((k-1)/k)));
gam = sqrt(k)*(2/(k+1))^((k+1)/(2*(k-1)));
Ae = At*gam/sqrt((2*k/(k-1))*(Pe/P0)^(2/k)*(1-(Pe/P0)^((k-1)/k)));
mdote = rhoe*Ae*Ve;

%% Force thrust
Fth = mdote*Ve + (Pe - Pamb)*Ae;
