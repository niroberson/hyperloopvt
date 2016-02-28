function [Tt, Pt] = nozzle_converging(T0, P0, k)
Tt = T0*(2/(k+1));
Pt = P0*(2/(k+1))^(k/(k-1));
end
