%% Braking characteristic for eddy current brakes
function [f_b] = EddyBrakes(F_bmax,vpk,velocity)
% Computes braking force of eddy brakes with known F_bmax and vpk
%
% Inputs:
%   F_bmax: Max braking force for magnet eddy brakes (N)
%   vpk: Peak velocity at which F_bmax occurs (m/s)
%   v: velocity to sweep through (m/s)
%
% Outputs:
%   f_b: Braking force with respect to velocity (N)
%

v = 0:1:velocity;      % (m/s)

f_b = 2*F_bmax*((v*vpk)./(v.^2 + vpk.^2));

%% Plotting

plot(v,f_b)
xlabel('Velocity (m/s)');
ylabel('Force (N)');
title('Eddy Current Braking Profile');
