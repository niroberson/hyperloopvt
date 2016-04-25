function ro = Density(pressure)
% Calculate the denisty of the air inside the tube
R = 10.73164; %(ft^3 * psia/ (Rankine * lb * mol)
p = 0.0145038; % psia
T = 540;
ro = p/(R*T); % lb * mol / ft^3
end