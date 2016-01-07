%% EMS Stability

%% Electromagnet Force Model

u0 = 4*pi*1e-7; % permeability of free space
N = 400; % Number of turns
A = 0.003; % Pole area (m^2)
I = 5.3; % Coil current (A)
z = 0.01; % Gap (m)

%I = 0:1:150; % Coil current (A)
%N = 0:1:1000; % Turns
F_em = ((u0*(N.^2)*A)*(I./z).^2)/4 % Electromagnetic force (N)

%plot(I,F_em/1000)
%xlabel('Coil Current (A)');
plot(N,F_em/1000);
xlabel('Coil Turns (N)');
ylabel('Electromagnetic Force (kN)');
title('Electromagnetic Force vs. Coil Current')

%%

% Demo electromagnet specs:
% Rated 48 N force

%% Halbach force model (Study of stability paper)

% Magnet Params
lambda = 0.2; % Wavelength (m)
B0 = 0.9411; % Remanence
k = 2*pi/lambda; % Wave number
h = 0.018; % Levitation gap (m)
w = 0.12; % Magnet width (m) 

% Track Params
L = 6.4*1e-6; % Track inductance single winding (H)
d = 0.01; % Track thickness (m)
R1 = 2*1e-4; % Track resistance single winding (ohms)

v = 0:1:10; % Velocity (m/s)
omega = k.*v;

c = (lambda*(B0^2)*(w^2))/(2*k*L*d);
d = 1./(1 + (R1./(omega.*L)).^2);
F_halbach = c*d*exp(-2*k*h);

plot(v,F_halbach)


