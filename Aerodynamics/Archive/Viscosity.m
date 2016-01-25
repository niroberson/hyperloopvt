function mu = Viscosity(density)
% Calculate the viscocity 
C = 120; % Sutherlands constant
T0 = 524.07; % Rankine
mu0 = 0.01827; % Centipoise
a = 0.555*T0 + C;
b = 0.555*T + C;
mu = mu0 *(a/b)*(T/T0)^(3/2); % gram / (centimeter * second)
mu = mu / 0.00220462; % gram to lb
mu = mu * 0.0328084; % centimeter to ft
end