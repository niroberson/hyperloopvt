function s = S_givenPT(P,Po,T,To,option)

R = 287;

if option == 1
%  calorically perfect gas
 % s - so = cp ln(T/To) - Rln(P/Po)
% s = so for isentropic flow

  cpo = 1003.5;
  s = cpo*log(T/To) - R*log(P/Po);
 
elseif option == 2

% for gas with temperature dependent specific heat

end