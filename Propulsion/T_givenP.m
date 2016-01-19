function T = T_givenP(P,Po,To,option)

R = 287;
if option == 1
% calorically perfect gas
% s - so = cp ln(T/To) - Rln(P/Po)
% s = so for isentropic flow

cpo = 1003.5;
T = To*(P/Po)^(R/cpo);

elseif option == 2


end
