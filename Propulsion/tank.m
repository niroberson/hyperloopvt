function [P0, T0] = tank(Ti, Pi, V, At, k, R, t)
%% An isentropic model of the changing conditions inside of the tank
gamma = k*(2/(k+1))^((k+1)/(2*(k-1)));
P0 = Pi.*(1/(1+(k-1)/(2*k)*(k*R*Ti)^(1/2)*gamma*(At/V)*t).^(2*k/(k-1)));
T0 = Ti*(P0(t)/Pi).^((k-1)/k);
end