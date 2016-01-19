function beta = beta_calc( M1, theta, bguess )

% secant method to get mach # given area ratio

bo = bguess;
db = 1/1000.;
delb = 1.0;

while abs(delb) > .0001,
  br = bo+db; 
  bl = bo-db;
  dfdb = ( theta_calc(M1, br) - theta_calc(M1, bl) )/(2*db);
  delb = -(theta_calc(M1, bo)-theta)/dfdb;
  bo = bo + delb;
end
 
beta = bo;