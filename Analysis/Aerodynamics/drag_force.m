clear, clc
% Calculate drag force
u = 0:1:250; % m/s
p = 0.14*1000; %Pa
T = 315.372; % (K) Equilibrium tube temperature % http://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/20150000699.pdf page 13
R = 287.058;  %individual gas constant (J/kg*K)
ro = p/(R*T); % kg/m^ 2
Cd = 0.5; % Random
w = 1219.20/1000; % m
h = 914.40/1000; % m
A = w*h; % m^2
Fd = 0.5*ro*u.^2*Cd*A; % N

% Propulsive force
d = 682.752; %m
m = 750; % kg
Fp = m/(2*d)*u;
F_net = Fp-Fd;

% Plot drag, propulsive, and net force
figure, hold on
plot(Fp, u, 'gr')
plot(Fd, u, 'r')
plot(F_net, u, 'm')
plot(Fp - max(Fd), u, 'bl')
xlabel('Force (N)')
ylabel('Velocity (m/s)')
legend('Thrust Force', 'Drag Force', 'Net Force', 'Constant Drag (max)', 'Location', 'best')
title('Effect of Velocity on Horizontal Forces')