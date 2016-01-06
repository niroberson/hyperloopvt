function Fth = ColdGasThruster(gas_spec)
% Isp : Specific Impulse
% Rsp (J/(kg*K)) : Specific Gas constant
% Tc (K) : Chamber Temperature
% m_dot (kg/s) : Mass flow
% Ue (m/s) : Exhaust velocity
% Pe (Pa) : Exit pressure
% Pa (Pa) : Ambient pressure
% Pc (Pa) : Chamber Pressure
% Ae (m) : Exit Area (x-section)
% gamma : Ratio of specific heats

%% Load nitrogen spec
nitrogen = load_spec('nitrogen');
R = nitrogen.R; %specific gas constant for Nitrogen in J/kg*K
gamma = nitrogen.gamma; %ratio of specific heats for Nitrogen (and air)
density = 20.4427; %density of Nitrogen in pressure vessel fully compressed in kg/m^3
m_N = rho_N*V_vessel; %mass of Nitrogen in pressure vessel fully compressed in kg
T_c = 300; %temperature of Nitrogen in tank in K
c_star = 434.4*0.8; % m/s cstar at room temperature of nitrogen

%% Rocket propulsion equations
g = 9.81;

% fth = m_dot*u_exhuast + (P_exit - P_ambient) * A_exit;
% u_eq = u_exhuats + (P_exit - P_ambient)/m_dot*A_exit;
% Fth = m_dot*u_eq;
% Isp = u_eq/g;
% Fth = m_dot*Isp*g;
% lambda = (1+cos(alpha))/2 % alpha: half-angle of cone 15 degrees
% Fth = lambda*m_dot*Isp*g;

% Isp = 1 / g * sqrt( 2 * gamma / (gamma - 1) * Rsp * Tc * (1 - (P_exit / P_chamber)^((gamma - 1) / gamma)));
%

%% Thermodynamic equations
% Ideal gas law with compressibility
% P = Z*density*Rsp*T;



%% Calulate the Thrust Force of the CGT
P_c = 18202159.3; %gauge pressure in Pa
P_e = 150; % Pa nozzle exit 
P_ambient = tube.p; %ambient tube pressure in Pa
v_e = sqrt(((2*gamma*R*T_c)/(gamma-1))*((1-(P_e/P_c))^((gamma-1)/2))); %exit flow veclocity in m/s
a_tube = sqrt(gamma*287*355); %speed of sound in tube in m/s
M_e = v_e/a_tube; %mach number at exit
A_e = (0.0042/2).^2 * pi; %Area of diverging nozzle exit
A_t = A_e/((1/M_e)*sqrt(((2/(gamma+1))*(1+((gamma-1)/2)*(M_e^2)))^((gamma+1)/(gamma-1)))); %area of the choke point in m/s
m_dot = P_c*A_t/c_star;
A_c = V_vessel/L; %area of the converging nozzle in m^2
% t_e = m_N/m_dot; %time gas is expelled in s
Fth = m_dot*v_e + A_e*(P_e - P_ambient);
end