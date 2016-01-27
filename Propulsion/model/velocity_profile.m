%% Acceleration profile Constants
l_track = 1609.34; % 5280 ft or 1 mile
V0 = 0; % mps
mPod = 500; % kg

%% Pusher Acceleration
% v = v0 + 1/2at^2
l_pusher= 243.84; % 800 ft
xpush = 0:l_pusher;
aPush = 2*9.8;
Vpush = sqrt(V0^2 + 2*aPush.*xpush);

%% Propulsion
Fth = 3500;
lprop = 200; % m
xprop = l_pusher:(l_pusher + lprop);
aProp = (Fth - (Fmd + Fd))/mPod;
Vprop = sqrt(Vpush(end)^2 + 2*aProp.*(xprop - l_pusher));

%% Coast
xcoast = xprop(end):l_track;
aCoast = - (Fmd + Fd)/mPod;
VCoast = sqrt(Vprop(end)^2 + 2*aCoast.*(xcoast - lprop - l_pusher));

%% Additional Braking


%% Plot full profile
figure, hold on
plot([xpush xprop xcoast], [Vpush Vprop VCoast])
