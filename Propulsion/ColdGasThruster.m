clear, clc
%% Gas constans
k = 1.4;
R = 297;
Isp = 73;
g = 9.81;

%% Stagnation Properties
P0 = 2.4132e+7; % Pa
T0 = 300; % K
Z = 1.0899825392; % http://www.peacesoftware.de/einigewerte/calc_stickstoff.php5
rho0 = P0/(Z*R*T0);
c0 = 449.02992528; % Speed of sound

%% Throat Properties
Tt = T0*(2/(k+1));
rhot = rho0*(2/(k+1))^(1/(k-1));
Pt = P0*(2/(k+1))^(k/(k-1));
Vt = sqrt(2*k/(k+1)*R*T0); % = sqrt(k*R*Tt)
At = (0.006 / 2)^2*pi; % m2
mdott = rhot*At*Vt; % kg/s

%% Exhaust Properties
Me = 2;
Pe = P0/(1+(k-1)/2*Me^2)^(k/(k-1)); % Pa
Te = T0/(1+(k-1)/2*Me^2);
Z_e = 0.8637;
rhoe = rho0*((Pe/P0)^(1/k));
Ve = Vt*sqrt((k+1)/(k-1)*(1 - (Pe/P0)^((k-1)/k)));
gam = sqrt(k)*(2/(k+1))^((k+1)/(2*(k-1)));
Ae = At*gam/sqrt((2*k/(k-1))*(Pe/P0)^(2/k)*(1-(Pe/P0)^((k-1)/k)));
mdote = rhoe*Ae*Ve;
Fth = mdote*Ve

%% Chamber Properties
Ac = (0.01905/2)^2*pi;
Vc = mdott/(rho0*Ac);
mdotc = rho0*Vc*Ac;

%% Get Nozzle Geometry from areas
re = sqrt(Ae/pi);
rt = sqrt(At/pi);
alpha = 15*pi/180;
L_noz = re/sin(alpha) - rt/sin(alpha);

%% Gas Depletion time
% Volume_Tank = 
% mdotc

%% Force needed from propulsion
l_track = 1609.34; % 5280 ft
l_pusher= 243.84; % 800 ft
l_braking = 609.6; % 2000 ft
l_prop = l_track - l_pusher - l_braking;
m_pod = 500;
v0 = 90;
vf = 100;
a = (vf^2 - v0^2)/(2*l_prop);
Fd = 130; % N
F_needed = m_pod*a + Fd;
t = sqrt(2*(vf - v0)/a);
a_actual = (Fth-Fd)/m_pod;
Vf_actual = sqrt((a_actual*2*l_prop)+(90^2));