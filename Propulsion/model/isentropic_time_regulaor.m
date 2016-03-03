function Fthp = isentropic_time_regulator(Pi, Ti, V, Pr, k, R, t)
%% Pressure in Tank over time 
% Citation: http://carbon.ucdenver.edu/~swelch/me5161/quasi_one_dimensional_flow_examples.pdf
% Citation: http://www.osti.gov/scitech/servlets/purl/786430-dbaImH/webviewable/
% Assume (a) Isentropic and (b) Isothermal to determine
% the decrease in tank pressure over time
% Initial Conditions
Pamb = 140; % Pa
% Tank conditions
% Isentropic ratio

% %% Flow parameters
% V = 0.06737; % m3 Tank Volume
% Ti = 300; % K Tank gas temperature
% 
% Pc = 1000*6894.76;
% Pi = 3400*6894.76;
% Pr = 1500*6894.76;
% 
% 
% %% Gas Parameters
% k = 1.4;
% R = 297;
% 
% %%
% t = 0:30;

gamma = k*(2/(k+1))^((k+1)/(2*(k-1)));

%% Time relationships
P0 = @(t)Pi./(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1));
T0 = @(t) Ti*(P0(t)/Pi).^((k-1)/k);
mdot = @(t) gamma*At*Pr./sqrt(k*R*T0(t));
Vt = @(t) sqrt(2*k/(k+1)*R.*T0(t));
Tt = @(t) T0(t).*(2/(k+1));
Pt = @(t) Pr*(2/(k+1))^(k/(k-1));
Pe = @(t) P0(t)./(1+(k-1)./2.*Me0.^2).^(k/(k-1)); %% why P0(t)?
Te = @(t) Tt(t)*(Pe(t)/Pt(t)).^((k-1)/k);
Ve = @(t) Vt(t).*sqrt((k+1)/(k-1)*(1 - (Pe(t)./P0(t)).^((k-1)/k)));
Fth = @(t) mdot(t).*Ve(t) + (Pe(t) - Pamb)*Ae;
Mprop = @(t) V*Pi.^((k-1)/k)./(R*Ti)*P0(t).^(1/k);






%% Choose Nozzle geometry based on initial conditions
Ae = At*gamma/sqrt((2*k/(k-1))*(Pe(0)/P0(0))^(2/k)*(1-(Pe/P0)^((k-1)/k)));
At = (4.5/1000)^2*pi;
re = sqrt(Ae/pi);
rt = sqrt(At/pi);
re = sqrt(Ae/pi);
alpha = 15*pi/180;
beta = 60*pi/180;
Ld = re/tan(alpha);
Lc = rt/tan(beta);

Me0 = 5;

%% Mass Flow in System Decay
figure
[ax, p1, p2] = plotyy(t, Fth(t), t,  Mprop(t)/Mprop(0));
xlabel(ax(1),'Time (s)')
ylabel(ax(1),'Fth (N)')
ylabel(ax(2), 'M(t)/Mi')
title(' Thrust and Fuel Gauge')

%% Pressure and temperature at exit
figure, hold on
[ax,p1,p2] = plotyy(t, Pe(t),t,Te(t));
% [ax,p1,p2] = plotyy(t, Pt(t),t,Tt(t));
xlabel(ax(1),'Time (s)')
ylabel(ax(1),'Pressure (Pa)')
ylabel(ax(2),'Temperature (K)')                                                                                                               
title('Pressure and Temperature at Nozzle Exit')
set(gca,'YMinorTick','on');

% Final Velocity
VPusher = 97.7677;
for i = 1:numel(t)
    v(i) = integral(Fth, 0, t(i))/250 + VPusher;
    d(i) = (v(i)/2)*t(i);
end

% Velocity and Displacement
figure, hold on
[ax,p1,p2] = plotyy(t, v,t,d);
xlabel(ax(1),'Time (s)')
ylabel(ax(1),'Velocity (m/s)')
ylabel(ax(2),'Distance (m)')
title('Velocity and Displacement')
set(gca,'YMinorTick','on');
hold off

%% Calculate total impulse
I = sum(Fth(t))/numel(t)*t(end);
Isp = Fth0/(mdott0*9.8);

Fthp = Fth(t);

