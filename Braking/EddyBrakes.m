%% Braking characteristic for eddy current brakes
% F_bmax = Max braking force for magnet eddy brakes
% vpk = Peak velocity at which F_bmax occurs
% v = Velocity sweep

F_bmax = 10*1e3; % (N)
vpk = 5;         % (m/s)
v = 0:1:20;      % (m/s)

f_b = 2*F_bmax*((v*vpk)./(v.^2 + vpk.^2));

plot(v,f_b)
xlabel('Velocity (m/s)');
ylabel('Force (N)');