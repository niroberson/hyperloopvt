tube = load_spec('tube');
% Find the temperature inside the tube
p_ambient = 101.325; % kPa
T_ambient = (70 - 32) + 491.67; % Rankine

p = 0.1; %kPa
T = p * T_ambient / p_ambient; % Temperature inside the tube

% Calculate the viscocity 
C = 120; % Sutherlands constant
T0 = 524.07; % Rankine
mu0 = 0.01827; % Centipoise
a = 0.555*T0 + C;
b = 0.555*T + C;
mu = mu0 *(a/b)*(T/T0)^(3/2); % gram / (centimeter * second)
mu = mu / 0.00220462; % gram to lb
mu = mu * 0.0328084; % centimeter to ft

% Calculate the denisty of the air inside the tube
R = 10.73164; %(ft^3 * psia/ (Rankine * lb * mol)
p = 0.0145038; % psia
ro = p/(R*T); % lb * mol / ft^3

% Calculate reynolds numbers
v = 293.333; %ft/s % From 200 MPH
d = 4.5; %ft
Re = ro* v * d / mu; % Non-dimensional

