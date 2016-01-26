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

%% Drag
Fmd = 1000;
Fd = 6.5;

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

%% Braking
% aB = -2*9.8; % Max acceleration of braking
% Vf = 0;
% % Plot braking distance needed to brake at this acceleration as a function
% % of mass velocity
% Vmax = 90:200;
% x = -Vmax.^2/(2*aB);
% figure, hold on
% plot(Vmax, x)
% l_brake_max = l_track-l_pusher;
% xlabel('Vmax (m/s)')
% ylabel('Distance needed for braking (m)')
% % Plot distance available for propulsion as velocity increases
% xProp = l_brake_max - x;
% plot(Vmax, xProp)
% % plot([Vmax(1) Vmax(end)], [l_brake_max l_brake_max], 'r--')
% legend({'Braking Distance', 'Propulsion Distance'})
% 
% % Propulsion Needed Accelleration
% aprop = (Vmax.^2 - Vpush^2)./(2*xProp);
% Fth = mPod*aprop;
% figure, plot(Vmax, Fth)
% xlabel('Vmax (m/s)')
% ylabel('Force of Thrust Needed (N)')
% 
% % Time of Force allowed
