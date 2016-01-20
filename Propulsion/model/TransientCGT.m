clear, clc
%% Pressure in Tank over time 
% Citation: http://carbon.ucdenver.edu/~swelch/me5161/quasi_one_dimensional_flow_examples.pdf
% Citation: http://www.osti.gov/scitech/servlets/purl/786430-dbaImH/webviewable/
% Assume (a) Isentropic and (b) Isothermal to determine
% the decrease in tank pressure over time

% Gas Constants
k = 1.4;
R = 297;
% Initial Conditions
Pi = 3.1026e+7; % Pascals
Ti = 300; % K
Pamb = 140; % Pa
% Tank conditions
V = 0.06737;
% Isentropic ratio
gamma = sqrt(k)*(2/(k+1))^((k+1)/(2*(k-1)));

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
%% Plots
t = 0:0.001:15;

%% Mass Flow in System Decay
figure
[ax, p1, p2] = plotyy(t, P0(t)/Pi, t, mdot(t));
xlabel(ax(1),'Time (s)')
ylabel(ax(1),' P0/Pi (Pa)')
ylabel(ax(2),'Mass Flow (kg/s)')
title('Parameter Decay in System')

%% Thrust and Velocity Plot
figure
plot(t, Fth(t))
xlabel('Time (s)')
ylabel('Thrust Force (N)')
title('Thrust Decay over Time')

%% Final Velocity
VPusher = 97.7677;
syms t
v = integral(Fth, 0, 10)/500 + VPusher;
% Determine distance