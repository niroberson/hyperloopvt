function TransientCGT(Pi, Ti, At)
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
% Tank conditions
V = 0.06737;
% Isentropic ratio
gamma = k*(2/(k+1))^((k+1)/(2*(k-1)));

%% 

%% Time relationships
P0 = @(t)Pi./(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1));
T0 = @(t) Ti*(P0(t)/Pi).^((k-1)/k);
mdot = @(t) gamma*At*P0(t)./sqrt(k*R*T0(t));
Me = @(t)V*Pi^((k-1)/k)./(R*Ti)*P0(t).^(1/k);

figure(2,2)
t = 0:0.1:20;
plot(t, P0(t));

%% Thrust time dependency