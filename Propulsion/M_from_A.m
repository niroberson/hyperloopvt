function mach = M_from_A(arear, mguess)

% secant method to get mach # given area ratio

mo = mguess;
delm = 1.0;

while abs(delm) > .0001,
  dm = mo*1.0e-3;
  mr = mo+dm; 
  ml = mo-dm;
  dadm = ( A_from_M(mr) -A_from_M(ml) )/(2*dm);
  delm = -(A_from_M(mo)-arear)/dadm;
  mo = mo + delm;
end
 
mach = mo;
  