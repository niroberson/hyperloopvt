function [Pe, Te] = nozzle_diverging(P0, Pt, Tt, Me, k)
Pe = P0/(1+(k-1)/2*Me.^2)^(k/(k-1));
Te = Tt*(Pe/Pt)^((k-1)/k);
end