% Find the temperature inside the tube
p_ambient = 101.325; % kPa
T_ambient = (70 - 32) + 491.67; % Rankine
p = 0.1; %kPa
% T = p * T_ambient / p_ambient; % Temperature inside the tube
T = 315.372; % (K) Equilibrium tube temperature % http://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/20150000699.pdf page 13

% Track Parameters:
L2 = 0.8;       % length of plate
t2 = 0.006;     % thickness of plate
w2 = 1.2;       % width of aluminum plate
sigma = 2.54*1e7; % conductivity of plate