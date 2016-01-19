function [presr,densr,tempr,arear] = isentrop(mach)

% table A.1 --->  isentropic flow properties (gamma = 1.4)

%  presr = po/p
%  densr = rhoo/rho
%  tempr = To/T
%  arear = A/Astar


gamma = 1.4;

term = 1 + .5*(gamma-1)*mach^2;

presr = term^(gamma/(gamma-1));          % equation 3.30

densr = term^(1/(gamma-1));              % equation 3.31

tempr = term ;                           % equation 3.28     

arear = 2/( gamma+1)*term;
arear = arear^((gamma+1)/(gamma-1));   
arear = arear/( mach^2);
arear = sqrt(arear);                     % equation 5.20