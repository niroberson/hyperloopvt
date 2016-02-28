function [Tt, Pt, Vt] = nozzle_converging(T0, P0, k, R)
%% Model of the converging section of the nozzle
Tt = T0*(2/(k+1));
Pt = P0*(2/(k+1))^(k/(k-1));
Vt = sqrt(2*k/(k+1)*R.*T0);
end
