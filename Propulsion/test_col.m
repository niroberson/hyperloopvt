
clear all

option = 1; % calorically perfect gas

R = 297;
cv = 743;
cp = R + cv;

%set length
L = 3.0;
% number of cells (bound by 2 nodes)
ncell = 200;
nnode = ncell+1;

% grid spacing
dx = L/ncell;

% reservoir and exit conditions
To = 300;
Po = 3.1e+7;
rhoo = Po/(R*To);
Pe = 3.0842e+06;
ao = sound_speed(To,option);

% throat choked analytic soln
[presr,densr,tempr,arear] = isentrop(1.0);
rhoth = rhoo/densr;
tempth = To/tempr;
soundth = sqrt(cp*R*tempth/cv);
At = area(L/2);
massth = rhoth*At*soundth;

% analytic solution
for i = 1:nnode,
 x(i) = (i-1)*dx;
 if( x(i) < L/2 ) 
     mguess = 0.1;
 else
     mguess = 1.5;
%     mguess = 0.1;
 end
 mach = M_from_A(area(x(i)), mguess);
 [presr,densr,tempr,arear] = isentrop(mach);
 presa(i) = Po/presr;
 rhoa(i) = rhoo/densr;
 tempa(i) = To/tempr;
% rhoa(i) = presa(i)/(R*tempa(i));
 macha(i) = mach;
 mdota(i) = massth;
 aa(i) = sqrt(1.4*R*tempa(i));
 ua(i) = macha(i)*aa(i);
end


% set initial conditions at nodes
for i = 1:nnode
    pres(i) = Pe;
    temp(i) = To;
    u(i) = 0;
    rho(i) = pres(i)/(R*temp(i));
    a(i) = sound_speed(temp(i),option);
    mach(i) = u(i)/a(i);
    x(i) = (i-1)*dx; % x-coordinate of node i
    A(i) = area(x(i));
    dAdx(i) = darea(x(i));
    mdot(i) = rho(i)*u(i)*A(i);
    entropy(i) = S_givenPT(pres(i),Po,temp(i),To,option);
end

% courant = a*dt/dx < 1 everywhere for stability

dt = 0.25*dx/ao; % conservative time step based on stability --> courant = 0.1
nstep = 5000;   % number of time steps

% time loop

for n = 1:nstep
  if mod(n,100) == 0
      n
  end
% set old time pressure and velocity to new time values
  for i = 1:nnode
      presn(i) = pres(i);
      un(i) = u(i);
  end
  
  % loop through grid interior to find new pressure and velocity
  for i = 2:nnode-1
      
  % calculate + gradients
    if un(i) + a(i) > 0.0  
        dup = (un(i) - un(i-1))/dx;
        dPp = (presn(i) - presn(i-1))/dx;
    else
        dup = (un(i+1) - un(i))/dx;
        dPp = (presn(i+1) - presn(i))/dx;
    end
    
  % calculate - gradients
    if un(i) - a(i) > 0.0  
        dum = (un(i) - un(i-1))/dx;
        dPm = (presn(i) - presn(i-1))/dx;
    else
        dum = (un(i+1) - un(i))/dx;
        dPm = (presn(i+1) - presn(i))/dx;
    end
    
    ra = rho(i)*a(i);
    
  % get new velocity (equation 1.10)
    dudt = -.5*    ( (u(i)+a(i))*dup + (u(i)-a(i))*dum ) ...
           -.5/ra* ( (u(i)+a(i))*dPp - (u(i)-a(i))*dPm );
     
    u(i) = un(i) + dt*dudt;
  % get new Pressure (equation 1.10)
    dPdt =  -.5*ra* ( (u(i)+a(i))*dup - (u(i)-a(i))*dum ) ...
            -.5   * ( (u(i)+a(i))*dPp + (u(i)-a(i))*dPm ) ...
            - ra*u(i)*a(i)*dAdx(i)/A(i);
     
    pres(i) = presn(i) + dt*dPdt;
 
  end % end of interior loop
  
  % boundary conditions
  
  % left end 
    pres(1) = Po;
  % u-a characteristic equation (equation 1.9) 
    dum = (un(2) - un(1))/dx;
    dPm = (presn(2) - presn(1))/dx;
    ra = rho(1)*a(1);
    dudt = u(1)*a(1)*dAdx(1)/A(1)  ...
         + (u(1)-a(1))*dPm/ra ...
         - (u(1)-a(1))*dum;
    u(1) = un(1) + dt*dudt;
    
  % right end 
  % subsonic case
    if mach(nnode) < 1.0
      pres(nnode) = Pe;
  % u+a characteristic equation (equation 1.9) 
      dup = (un(nnode) - un(nnode-1))/dx;
      dPp = (presn(nnode) - presn(nnode-1))/dx;
      ra = rho(nnode)*a(nnode);
      dudt = - u(nnode)*a(nnode)*dAdx(nnode)/A(nnode)  ...
         - (u(nnode)+a(nnode))*dPp/ra ...
         - (u(nnode)+a(nnode))*dup;
      u(nnode) = un(nnode) + dt*dudt;
    else  % supersonic case - equations same as interior
  % calculate + gradients
      i = nnode;
      dup = (un(i) - un(i-1))/dx;
      dPp = (presn(i) - presn(i-1))/dx;    
  % calculate - gradients
      dum = (un(i) - un(i-1))/dx;
      dPm = (presn(i) - presn(i-1))/dx;
    
      ra = rho(i)*a(i);
    
  % get new velocity (equation 1.10)
      dudt = -.5*    ( (u(i)+a(i))*dup + (u(i)-a(i))*dum ) ...
             -.5/ra* ( (u(i)+a(i))*dPp - (u(i)-a(i))*dPm );
     
      u(i) = un(i) + dt*dudt;
  % get new Pressure (equation 1.10)
      dPdt =  -.5*ra* ( (u(i)+a(i))*dup - (u(i)-a(i))*dum ) ...
              -.5   * ( (u(i)+a(i))*dPp + (u(i)-a(i))*dPm ) ...
               - ra*u(i)*a(i)*dAdx(i)/A(i);
     
      pres(i) = presn(i) + dt*dPdt;
    end % exit boundary
    
    % get new sound speeds, mach #'s etc.
    
    for i = 1:nnode
      temp(i) = T_givenP(pres(i),Po,To,option);
      rho(i) = pres(i)/(R*temp(i));
      a(i) = sound_speed(temp(i),option);
      mach(i) = u(i)/a(i);
      mdot(i) = rho(i)*u(i)*A(i);
      entropy(i) = S_givenPT(pres(i),Po,temp(i),To,option);
   end

 
subplot(421)
plot(x,pres,'b',x,presa,'r');
title('P')

subplot(422)
plot(x,temp,'b',x,tempa,'r');
title('T')

subplot(423)
plot(x,rho,'b',x,rhoa,'r');
title('rho')

subplot(424)
plot(x,entropy);
title('s')

subplot(425)
plot(x,a,'b',x,aa,'r');
title('sound speed')

subplot(426)
plot(x,mach,'b',x,macha,'r');
title('M')

subplot(427)
plot(x,u,'b',x,ua,'r');
title('u')

subplot(428)
plot(x,mdot,'b',x,mdota,'r');
title('mdot')

drawnow

end % of time loop









