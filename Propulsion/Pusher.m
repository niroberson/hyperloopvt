function [x, v] = Pusher(mass)
%  Acceleration provided by pusher
M = [250, 500, 750, 1000, 1500, 2000, 2500, 3000, 4000, 5000]; %kg
Ag = [2.4, 2, 1.7, 1.5, 1.2, 1, 0.9, 0.8, 0.6, 0.5]; %g

% Find our given acceleration
[~, idx] = min(abs(M-mass));
A_pod = 9.81* Ag(idx);

% Get the velocity of the pod over the length of the pusher
D_pusher = 243.84; %m (800')
Vf_pod = sqrt(2*A_pod*D_pusher);

x = 0:0.1:D_pusher;
v = x./D_pusher*Vf_pod;
end