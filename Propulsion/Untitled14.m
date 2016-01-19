clear all
clf

R = 2.; % arbitrary selection - if R is too large there will
       % be multiple reflections
H = 1.0;
D = H+R;
half = 0.5;
Mdesign = 2.0;

v = [0 7  0  1];
axis(v);
axis('equal')
hold

% plot circular contour (expansion section)

for k = 1:45
  thcc(k) = k*pi/180;
  xcp(k) = R*sin(thcc(k));
  ycp(k) = D-R*cos(thcc(k));
end
plot(xcp,ycp,'r')

% assume one reflection in expansion section
% this constrains code to short expansion sections due to the
% lack of multiple reflections

tha = 5e-004;
dtha = .01; % dtha controls accuracy
Mterm = 0.0;
nexp = 1;
% first wave "originating" on circular contour at point a in figure 11.13
% first C- characteristic experiences no intersections with C+
% characteristics
%
% th = th(nexp,nref)
% pr = pr(nexp,nref)
% etc...
%
% after flow is expanded to meet exit Mach criteria there will be
% nexp expansion waves and nref reflected waves.
% First reflected wave uses second index = 2
% Contour uses first index = nexp+1
%
th(1,1) = tha ;
x(1,1) = R*sin(th(1,1));
y(1,1) = D - R*cos(th(1,1));
% expansion countour is a Prandtl-Meyer expansion - use eqn 4.45
% where M1 = 1 all along expansion contour
pr(1,1) = th(1,1);
M(1,1) = inv_p_m(pr(1,1),1.1);
mu(1,1) = asin(1.0/M(1,1));
% point of intersection along symmetry axis - point 1 in figure 11.12
dydx = tan(th(1,1)-mu(1,1));
y(1,2) = 0.0;
x(1,2) = (y(1,2) - y(1,1))/dydx + x(1,1) ;
Km(1) = th(1,1) + pr(1,1);
th(1,2) = 0.0;
pr(1,2) = Km(1);
Kp(2) = - pr(1,2);
M(1,2) = inv_p_m(pr(1,2),1.1);
mu(1,2) = asin(1.0/M(1,2));

plot(  x(1,:) , y(1,:) )
pause

  while Mterm < Mdesign,
    
  nexp  = nexp + 1;
  
% wave "originating" on circular contour at point a in figure 11.13
% keep originating waves until centerline Mach number is the design
% Mach number

  th(nexp,1) = tha + (nexp-1)*dtha;
  x(nexp,1) = R*sin(th(nexp,1));
  y(nexp,1) = D - R*cos(th(nexp,1));

  % expansion countour is a Prandtl-Meyer expansion - use eqn 4.45
  % where M1 = 1
  pr(nexp,1) = th(nexp,1);

  M(nexp,1) = inv_p_m(pr(nexp,1),1.1);
  mu(nexp,1) = asin(1.0/M(nexp,1)); 
  Km(nexp) = th(nexp,1) + pr(nexp,1);
  
  % there will be nref intersections with reflected waves before 
  % reaching centerline

  for nref = 2:nexp+1
    
    if nref == nexp+1 % centerline
       th(nexp,nref) = 0.0;
       pr(nexp,nref) = Km(nexp);
       M(nexp,nref) = inv_p_m(pr(nexp,nref),1.1);
       mu(nexp,nref) = asin(1.0/M(nexp,nref)); 
       Kp(nref) = - pr(nexp,nref);
       y(nexp,nref) = 0.0;
       yq = y(nexp,nref-1);
       xq = x(nexp,nref-1);
       mm = tan(th(nexp,nref-1)-mu(nexp,nref-1));
       x(nexp,nref) = -yq/mm + xq;
       Mterm =  M(nexp,nref);
    else
       th(nexp,nref) = 0.5*(Km(nexp) + Kp(nref));
       pr(nexp,nref) = 0.5*(Km(nexp) - Kp(nref));
       M(nexp,nref) = inv_p_m(pr(nexp,nref),1.1);
       mu(nexp,nref) = asin(1.0/M(nexp,nref)); 
       mm = tan(th(nexp,nref-1)-mu(nexp,nref-1));
       mp = tan(th(nexp-1,nref)+mu(nexp-1,nref));
       yq = y(nexp,nref-1);
       xq = x(nexp,nref-1);
       yr = y(nexp-1,nref);
       xr = x(nexp-1,nref);
       den = mm - mp;
       xp = yr - yq - mp*xr + mm*xq;
       xp = xp/den;
       yp = yq + mm*(xp-xq);
       y(nexp,nref) = yp;
       x(nexp,nref) = xp;
    end
       plot(x,y,'+')
  end
  end
%
% Mdesign met at centerline - now find contour shape
%
% slope from final C+ characteristic is known
% assume straight line segment from previous contour point 
% use theta from 'simple region' solution, i.e. theta is constant 
% along waves refledted from centerline after clearing final
% expansion wave

  for n = 2:nref
      mc = tan(th(nexp,n)); % simple region, all variables constant
      if n == 2
         yc = y(nexp,1);
         xc = x(nexp,1);
      else
         yc = y(nexp+1,n-1);
         xc = x(nexp+1,n-1);
      end
      mp = tan(th(nexp,n) + mu(nexp,n));
      yq = y(nexp,n);
      xq = x(nexp,n);
      yp = yq + mp*(xc - xq - yc/mc);
      den = mc - mp;
      xp = yq-yc +mc*xc-mp*xq;
      xp = xp/den;
      yp = yc + mc*(xp-xc);
      y(nexp+1,n) = yp;
      x(nexp+1,n) = xp;
      plot(xp,yp,'+k')
  end
   
  
  
Ae_Ai_2D = y(nexp+1,nref)/y(1,1)
Ae_At = A_from_M(M(nexp,nref));
Ai_At = A_from_M(1.0);
Ae_Ai_Q1D = Ae_At/Ai_At

figure
v = [0 7  0  1];
axis(v);
axis('equal')
hold
for n = 1:nexp
  plot(x(n,:),y(n,:));
end


for n = 2:nref
  plot(x(:,n),y(:,n));
end


x_contour(1) = x(nexp,1);
y_contour(1) = y(nexp,1);

for n = 2:nref
  x_contour(n) = x(nexp+1,n);
  y_contour(n) = y(nexp+1,n);
end
plot(x_contour,y_contour,'r')


