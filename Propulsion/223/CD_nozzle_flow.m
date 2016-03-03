clear all;
clc;

t = 0:30;


Ti = 273.15; % K
Pvac = 861.84466;
t_stop = 10;

%% Big Tank
V = 0.1206907; % m3 Tank Volume
Pi = 2.3442e+7; % Pascals Tank Pressure
At = (5.0/1000)^2*pi; % 3/4 in pipe
            
%% Propellant - Nitrogen

T_min = 77;
k = 1.4;
R = 297;

%% Determine mass flow in system
gamma = k*(2/(k+1))^((k+1)/(2*(k-1)));
P0 = @(t)Pi./(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1));
T0 = @(t) Ti*(P0(t)/Pi).^((k-1)/k);
mdot = @(t) gamma*At*P0(t)./sqrt(k*R*T0(t));

%% Find t where P0/Pi < 0.1, 0.05, 0.01
t_crit = 0;
while P0(t_crit)/Pi > 0.01 && t_crit<t_stop
    t_crit = t_crit + 0.01;
end

%% Determine Me keeping Te(t_crit) above a minimun temperature
Me = 2.5;
Tt = @(t) T0(t).*(2/(k+1));
Pt = @(t) P0(t)*(2/(k+1))^(k/(k-1));
Pe = @(t) P0(t)./(1+(k-1)./2.*Me.^2).^(k/(k-1));
Te = @(t) Tt(t)*(Pe(t)/Pt(t)).^((k-1)/k);

while Te(t_crit) > T_min % Liquifaction point of gas
    Me = Me + 0.01;
    Pe = @(t) P0(t)./(1+(k-1)./2.*Me.^2).^(k/(k-1));
    Te = @(t) Tt(t)*(Pe(t)/Pt(t)).^((k-1)/k);
end

%% Determine exit area
Ae = At*gamma/sqrt((2*k/(k-1))*(Pe(0)/P0(0))^(2/k)*(1-(Pe(0)/P0(0))^((k-1)/k)));

%% Determine the thrust produced over time
Vt = @(t) sqrt(2*k/(k+1)*R.*T0(t));
Ve = @(t) Vt(t).*sqrt((k+1)/(k-1)*(1 - (Pe(t)./P0(t)).^((k-1)/k)));
Fth = @(t) Ve(t).*mdot(t) + (Pe(t) - Pvac)*Ae;

%% Find the toal impulse in the alloted time
I = integral(Fth, 0, t_stop);

