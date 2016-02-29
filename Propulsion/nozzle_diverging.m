function [Pe, Te, Ve] = nozzle_diverging(T0, P0, Me, k, R)
%% Model for the diverging section of the nozzle
[Tt, Pt, Vt] = nozzle_converging(T0, P0, k, R);
Pe = P0/(1+(k-1)/2*Me.^2)^(k/(k-1));
Te = Tt/(Pt/Pe)^((k-1)/k);
Ve = sqrt(2*k*R*Tt/(k-1)*(1 - 1/(1+ (k-1)/2*Me^2)));
end