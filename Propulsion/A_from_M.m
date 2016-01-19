function arear = A_from_M(mach)

gamma = 1.4;

term = 1 + .5*(gamma-1)*mach^2;

arear = 2/( gamma+1)*term;
arear = arear^((gamma+1)/(gamma-1));
arear = arear/( mach^2);
arear = sqrt(arear);

return