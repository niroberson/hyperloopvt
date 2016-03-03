function[I] = Impulse_optimization(r, Me)

t = 0:30;

%% Constants
Ti = 273.15; % K
Pvac = 861.84466;
t_stop = 10;

%% Big Tank
V = 0.1206907; % m3 Tank Volume
Pi = 2.3442e+7; % Pascals Tank Pressure
At = (r/1000)^2*pi; % 3/4 in pipe

%% Propellant - Nitrogen

T_min = 77;
k = 1.4;
R = 297;

%% Determine mass flow in system
gamma = k*(2/(k+1))^((k+1)/(2*(k-1)));
P0 = @(t)Pi./(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1));
T0 = @(t) Ti*(P0(t)/Pi).^((k-1)/k);
mdot = @(t) gamma*At*P0(t)./sqrt(k*R*T0(t));


%% Determine Me keeping Te(t_crit) above a minimun temperature
% Me = 2.5;
Tt = @(t) T0(t).*(2/(k+1));
Pt = @(t) P0(t)*(2/(k+1))^(k/(k-1));
Pe = @(t) P0(t)./(1+(k-1)./2.*Me.^2).^(k/(k-1));
Te = @(t) Tt(t)*(Pe(t)/Pt(t)).^((k-1)/k);

%% Determine t_crit (time it takes to reach T_min)

for tt = 1:1:10
    T_x = Tt(tt)*(Pe(tt)/Pt(tt)).^((k-1)/k);
   if  (T_x < T_min)
       t_crit = tt-1;
       break;
   end       
end


%% Determine exit area
Ae = At*gamma/sqrt((2*k/(k-1))*(Pe(0)/P0(0))^(2/k)*(1-(Pe(0)/P0(0))^((k-1)/k)));

%% Determine the thrust produced over time
Vt = @(t) sqrt(2*k/(k+1)*R.*T0(t));
Ve = @(t) Vt(t).*sqrt((k+1)/(k-1)*(1 - (Pe(t)./P0(t)).^((k-1)/k)));
Fth = @(t) Ve(t).*mdot(t) + (Pe(t) - Pvac)*Ae;

%% Find the toal impulse in the alloted time

% I = integral(Fth, 0, t_crit);

if t_crit
    I = integral(Fth, 0, t_crit);
else
    ME = MException('t_crit not under 10 s');
    throw(ME)
end


