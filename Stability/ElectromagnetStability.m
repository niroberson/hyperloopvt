clear all;
close all;

Hc = 11.2*1e3; % Coercive Force of Magnet
Br = 1.48; % Remanence of magnet (T)
u0 = 4*pi*1e-7; % permeability of free space
h = 0.2; % Height of magnets (m)
tau = 0.1; % Pole pitch (m)
beta = pi/tau; % Wave number
n = 100; % Number of turns
i_c = 50; % Current into the EM's
p = pi/tau;
M = 4;

%g = 0:0.001:0.2;
g = 0.015;
x = 0:0.01:0.2
%Jc = n*i_c; % Electromagnet current density
Jc = 30*1e6; % Ampere-Turns 
%Jc = 0;
Jm = h*Hc; % Current density of Magnet

Pavg = ((u0/4)*((Jc+Jm)/beta)*((sinh(beta*h))./cosh(beta*(g+h)))).^2;

B0 = Br*(1-exp(-p*g))*sin(pi/M)/(pi/M);

By = B0*sin(beta*x)*Pavg;

plot(x,By)
%plot(g,Pavg)