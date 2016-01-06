function [Force_y] = DoubleHalbachModel(v)
% Magnet Parameters
M = 4; % Number of Magnets in Wavelength
tau = 0.1; % Pole pitch (m)
p = pi/tau; 
Br = 1.277; % Magnet remanence (T)
h = 0.05; % Heigh of permanent magnet (m)

% Track Parameters
l = 0.003; % Thickness of track (m)
rho = 3.92*1e-8; % Resistivity of track (Ohm*m)
gamma_two = 1/rho; % Conductivity of aluminum (S/m)

% Air gap Parameters
d1 = 0.026; % Upper air gap (m)
d2 = 0.032; % Lower air gap (m)
u0 = 4*pi*1e-7; % permeability of free space
gamma_one = 3*1e-15; % Conductivity of air (S/m)
gamma_three = gamma_one; % Conductivity of air (S/m)
epsilon = 8.8541878176*1e-12; % Permitivity of free space

v = 1;

lambda = 2*tau;
omega = 2*pi*v/lambda;
t = 1;

B0 = Br*(1-exp(-p*h))*sin(pi/M)/(pi/M);

Bsy = @(y,z) B0.*(exp(-p.*(y+d1)) - exp(-p.*(-y+d2+l))).*exp(1i*(p.*z + omega.*t));
Bsz = @(y,z) B0.*(exp(-p.*(y+d1)) + exp(-p.*(-y+d2+l))).*exp(1i*(p.*z-pi/2+omega.*t));

Bym = @(y) B0.*(exp(-p*(y+d1)) - exp(-p*(-y+d2+l)));
Bzm = @(y) B0.*(exp(-p*(y+d1)) + exp(-p*(-y+d2+l)));

k1 = sqrt(-1i*omega.*u0.*(gamma_one + 1i*omega.*epsilon)); % Propogation function 
k2 = sqrt(-1i*omega.*u0.*(gamma_two + 1i*omega.*epsilon));
k3 = sqrt(-1i*omega.*u0.*(gamma_three + 1i*omega.*epsilon));

R1 = sqrt(p^2 - k1.^2);
R2 = sqrt(p^2 - k2.^2);
R3 = sqrt(p^2 - k3.^2);

a = exp(-R2*l);
b = exp(R2*l);
c = exp(-R3*l);

f = u0*gamma_two*v*B0/(k2^2);
A = f*(-p*exp(-p*d1) + p*exp(-p*(d2+l)));
B = f*(-p*exp(-p*(d1+l)) + p*exp(-p*d2));
C = f*(exp(-p*d1) - exp(-p*(d2+l)));
D = f*(exp(-p*(d1+l)) - exp(-p*d2));

C1 = 0;
C6 = 0;

C2 = (2*B*R2 - 2*D*R2*R3 + A*R2*a - A*R3*a + A*R2*b + A*R3*b - C*R2^2*a...
      + C*R2^2*b + C*R2*R3*a + C*R2*R3*b)/(R2^2*b - R2^2*a + R1*R2*a...
      - R1*R3*a + R2*R3*a + R1*R2*b + R1*R3*b + R2*R3*b);
  
C3 = -(B*R1 - B*R2 - D*R1*R3 + D*R2*R3 - A*R2*b - A*R3*b + C*R1*R2*b...
     + C*R1*R3*b)/(R2^2*b - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a...
     + R1*R2*b + R1*R3*b + R2*R3*b);
 
C4 = (B*R1 + B*R2 - D*R1*R3 - D*R2*R3 + A*R2*a - A*R3*a - C*R1*R2*a...
     + C*R1*R3*a)/(R2^2*b - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a...
     + R1*R2*b + R1*R3*b + R2*R3*b);

C5 = (B*R2*a - B*R1*a + B*R1*b + B*R2*b - D*R2^2*a + D*R2^2*b...
     + D*R1*R2*a + D*R1*R2*b + 2*A*R2*a*b - 2*C*R1*R2*a*b)/(c*(R2^2*b...
     - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a + R1*R2*b + R1*R3*b + R2*R3*b));

theta = @(y) u0*gamma_two*v*Bym(y)./(k2.^2);

A_1x = @(y,z) (C1*exp(-R1.*y) + C2*exp(R1.*y)).*exp(1i*p.*z + omega.*t);
A_2x = @(y,z) (C3*exp(-R2.*y) + C4*exp(R2.*y) + theta(y)).*exp(1i*p.*z + omega.*t);
A_3x = @(y,z) (C5*exp(-R3.*y) + C6*exp(R2.*y)).*exp(1i*p.*z + omega.*t);

By = @(y,z) Bsy(y,z) + 1i*p*A_2x(y,z);
Bz = @(y,z) Bsz(y,z) - (-R2*C3.*exp(-R2.*y) + R2*C4.*exp(R2.*y) ...
     + (u0*gamma_two.*v.*B0.*(-p.*exp(-p.*(y+d1)) + p.*exp(-p.*(-y+d2+l))))./(k2.^2))...
     .*exp(1i.*p.*z + omega.*t);
 
Je = @(y,z) -gamma_two*v*(Bsy(y,z) + 1i*p*A_2x(y,z));

double_integrand = @(y,z) Je(y,z).*conj(Bz(y,z));
Calc1 = integral2(@(y,z)double_integrand(y,z),0,l,0,2*tau);

Force_y = .5*real(Calc1);
