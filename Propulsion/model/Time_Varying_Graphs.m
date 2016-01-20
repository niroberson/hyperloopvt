function isentropic_time(k, R, t)
%% Pressure in Tank over time 
% Citation: http://carbon.ucdenver.edu/~swelch/me5161/quasi_one_dimensional_flow_examples.pdf
% Citation: http://www.osti.gov/scitech/servlets/purl/786430-dbaImH/webviewable/
% Assume (a) Isentropic and (b) Isothermal to determine
% the decrease in tank pressure over time


% Initial Conditions
Pi = 3.1026e+7; % Pascals
Ti = 300; % K
Pamb = 140; % Pa
% Tank conditions
V = 0.06737;
% Isentropic ratio
gamma = k*(2/(k+1))^((k+1)/(2*(k-1)));

%% Choose Nozzle geometry based on initial conditions
At = (4.75/1000)^2*pi;
Me0 = 3.5;
[Fth0, mdott0, Pe0, Ae] = CGT(Pi, Ti, Me0, At);
rt = sqrt(At/pi);
re = sqrt(Ae/pi);
alpha = 15*pi/180;
L = re/tan(alpha) - rt/tan(alpha);

%% Time relationships
P0 = @(t)Pi./(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1));
T0 = @(t) Ti*(P0(t)/Pi).^((k-1)/k);
mdot = @(t) gamma*At*P0(t)./sqrt(k*R*T0(t));
Vt = @(t) sqrt(2*k/(k+1)*R.*T0(t));
Tt = @(t) T0(t).*(2/(k+1));
Pt = @(t) P0(t)*(2/(k+1))^(k/(k-1));
Pe = @(t) P0(t)./(1+(k-1)./2.*Me0.^2).^(k/(k-1));
Te = @(t) Tt(t)*(Pe(t)/Pt(t)).^((k-1)/k);
Ve = @(t) Vt(t).*sqrt((k+1)/(k-1)*(1 - (Pe(t)./P0(t)).^((k-1)/k)));
Fth = @(t) mdot(t).*Ve(t) + (Pe(t) - Pamb)*Ae;
Mprop = @(t) V*Pi^((k-1)/k)/(R*Ti)*P0(t)^(1/k);
%% Mass Flow in System Decay
figure
[ax, p1, p2] = plotyy(t, P0(t)/Pi, t, mdot(t));
xlabel(ax(1),'Time (s)')
ylabel(ax(1),' P0/Pi (Pa)')
ylabel(ax(2),'Mass Flow (kg/s)')
title('Pressure Ratio in Vessel and Mass Flow Decay')

%% Temperature Change and Thrust Decay
figure
[ax,p1,p2] = plotyy(t, Fth(t),t,T0(t));
xlabel(ax(1),'Time (s)')
ylabel(ax(1),'Thrust Force (N)')
ylabel(ax(2),'Temperature (K)')
title('Temperature Change in Pressure Vessel and Thrust Decay')
set(gca,'YMinorTick','on');

%% Final Velocity
VPusher = 97.7677;
t = 0:0.01:15;
v = integral(Fth, 0, 10)/500 + VPusher;
for i = 1:numel(t)
    v(i) = integral(Fth, 0, t(i))/500 + VPusher;
    d(i) = (v(i)/2)*t(i);
end
%% Velocity and Displacement
figure, hold on
[ax,p1,p2] = plotyy(t, v,t,d);
xlabel(ax(1),'Time (s)')
ylabel(ax(1),'Velocity (m/s)')
ylabel(ax(2),'Distance (m)')
title('Velocity and Displacement')
set(gca,'YMinorTick','on');
hold off