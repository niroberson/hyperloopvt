function Re = ReynoldsNumber()
tube = load_spec('tube');
pod = load_spec('pod');

% Find the temperature inside the tube
p_tube = tube.p; % kPa
T_tube = tube.T; % Rankine

% Calculate the ambient density of air
R = 10.73164; %(ft^3 * psia/ (Rankine * lb * mol)
mu = 1.983e-5;
ro = p_tube/(R*T_tube); % kg*m&2/s^2

% Calculate reynolds numbers
v = 90; % m/s
d = 4.5; % m
Re = ro* v * d / mu; % Non-dimensional
end

