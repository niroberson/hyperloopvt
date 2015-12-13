function [x, v] = ColdGasThruster(mass_pod)
tube = load_spec('tube');
%% Pressurized tank specs
% TODO move this to specs file
V_vessel = 6.45624; %volume of pressure vessel in m^3
L = 1.27; %length of pressure vessel in m

%% Load nitrogen spec
nitrogen = load_spec('nitrogen');
R = nitrogen.R; %specific gas constant for Nitrogen in J/kg*K
gamma = nitrogen.gamma; %ratio of specific heats for Nitrogen (and air)
rho_N = 20.4427; %density of Nitrogen in pressure vessel fully compressed in kg/m^3
m_N = rho_N*V_vessel; %mass of Nitrogen in pressure vessel fully compressed in kg
T_c = 300; %temperature of Nitrogen in tank in K

%%
P_c = 18202159.3; %gauge pressure in Pa
P_e = tube.P; %nozzle exit/ ambient tube pressure in Pa
g = 9.81; %gravitational constant in m/s^2
J = F_T * t; %impulse in N*s
v_e = sqrt(((2*gamma*R*T_c)/(gamma-1))*((1-(P_e/P_c))^((gamma-1)/2))); %exit flow veclocity in m/s
A_e = F_T/P_e; %area of the diverging nozzle exit in m^2
a_tube = sqrt(gamma*287*355); %speed of sound in tube in m/s
M_e = v_e/a_tube; %mach number at exit
A_t = A_e/((1/M_e)*sqrt(((2/(gamma+1))*(1+((gamma-1)/2)*(M_e^2)))^((gamma+1)/(gamma-1)))); %area of the choke point in m/s
A_c = V_vessel/L; %area of the converging nozzle in m^2
m_dot = F_T/v_e; %mass flow rate in kg/s
t_e = m_N./m_dot; %time gas is expelled in s
end