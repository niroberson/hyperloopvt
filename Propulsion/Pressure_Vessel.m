%% Pressure in Tank over time 
% Citation: http://carbon.ucdenver.edu/~swelch/me5161/quasi_one_dimensional_flow_examples.pdf
% Assume (a) Isentropic and (b) Isothermal to determine
% the decrease in tank pressure over time

%% Gas constants
k = 1.4;
R = 297;


%% Tank setup


%% Isentropic
t = @(pf, pi, Ti) -2*V*((pf/pi)^((1-k)/(2*k)) - 1)/((1-k)*R*sqrt(Ti)*A*sqrt(k/R*(2/(k+1))^((k+1)*(k-1))));

%% Isothermal
t =@(pf, pi) -V/(A*sqrt(k*R*T(2/(k+1))^((k+1)*(k-1))))*ln(pf/pi);