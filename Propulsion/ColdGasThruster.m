P_c = 18202159.3; %gauge pressure in Pa
P_e = 120; %nozzle exit/ ambient tube pressure in Pa
R = 296.8; %specific gas constant for Nitrogen in J/kg*K
V = 6.45624; %volume of pressure vessel in m^3
L = 1.27; %length of pressure vessel in m
gamma = 1.4; %ratio of specific heats for Nitrogen (and air)
rho_N = 20.4427; %density of Nitrogen in pressure vessel fully compressed in kg/m^3
m_N = rho_N*V; %mass of Nitrogen in pressure vessel fully compressed in kg
g = 9.81; %gravitational constant in m/s^2
T_c = 300; %temperature of Nitrogen in tank in K
v_f = linspace(101,200,99); %velocity vector in m/s
a_pod = ((v_f.^2)-(100^2))/2000; %acceleration in m/s^2
m_pod = 500; %mass of pod in kg
F_T = a_pod * m_pod; %force of thrust in N
t = (v_f - 100)/a_pod; %time interval of acceleration after pusher in s
J = F_T * t; %impulse in N*s
v_e = sqrt(((2*gamma*R*T_c)/(gamma-1))*((1-(P_e/P_c))^((gamma-1)/2))); %exit veclocity in m/s
A_e = F_T/P_e; %area of the diverging nozzle exit in m^2
a_tube = sqrt(gamma*287*355); %speed of sound in tube in m/s
M_e = v_e/a_tube; %mach number at exit
A_t = A_e/((1/M_e)*sqrt(((2/(gamma+1))*(1+((gamma-1)/2)*(M_e^2)))^((gamma+1)/(gamma-1)))); %area of the choke point in m/s
A_c = V/L; %area of the converging nozzle in m^2
m_dot = F_T/v_e; %mass flow rate in kg/s
t_e = m_N./m_dot; %time gas is expelled in s
fprintf('The exit velocity is %f m/s\n',v_e);
fprintf('The Mach number of the exit gas stream is %f',M_e);
figure, hold on
title('Velocity Increase Versus Cross- Sectional Area')
xlabel('Velocity of Pod (m/s)')
ylabel('Area (m^2)')
plot(v_f,A_t,'g')
plot(v_f,A_e,'r')
plot([v_f(1),v_f(end)],[A_c,A_c],'b')
legend('area of choke point','area of diverging segment','area of converging segment')
hold off
figure, hold on
title('Velocity Increase Versus Time of Gas Expulsion')
xlabel('Velocity of Pod (m/s)')
ylabel('Time of Gas Expulsion (s)')
plot(v_f,t_e)
hold off
figure, hold on
title('Velocity Increase of Pod Versus Thrust')
xlabel('Velocity of Pod (m/s)')
ylabel('Force of Thrust (N)')
plot(v_f,F_T)
hold off