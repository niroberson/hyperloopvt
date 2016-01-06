% Magnet Parameters
M = 4; % Number of Magnets in Wavelength
tau = 0.2; % Pole pitch (m)
p = pi/tau;
Br = 1.1; % Magnet remanence (T)
h = 0.015; % Heigh of permanent magnet (m)

% Track Parameters
l = 0.01; % Thickness of track (m)
gamma2 = 3.5*1e7; % Conductivity of aluminum (S/m)

% Air gap Parameters
d1 = 1; % Upper air gap (m)
d2 = 1; % Lower air gap (m)
u0 = 4*pi*1e-7; % permeability of free space
gamma1 = 3*1e-15; % Conductivity of air (S/m)
gamma3 = gamma1; % Conductivity of air (S/m)
epsilon = 8.8541878176*1e-12; % Permitivity of free space

C1 = 2;
C2 = C1;
C3 = C1;
C4 = C1;
C5 = C1;
C6 = C1;

v = 1;
lambda = 2*tau;
omega = 2*pi*v/lambda;
t = 1;

B0 = Br*(1-exp(-p*h))*sin(pi/M)/(pi/M);

Bsy = @(y,z) B0.*(exp(-p.*(y+d1)) - exp(-p.*(-y+d2+l))).*exp(1i*(p.*z + omega.*t));
Bsz = @(y,z) B0.*(exp(-p.*(y+d1)) + exp(-p.*(-y+d2+l))).*exp(1i*(p.*z-pi/2+omega.*t));

Bym = @(y) B0.*(exp(-p*(y+d1)) - exp(-p*(-y+d2+l)));
Bzm = @(y) B0.*(exp(-p*(y+d1)) + exp(-p*(-y+d2+l)));

k1 = sqrt(-1i*omega.*u0.*(gamma1 + 1i*omega.*epsilon)); % Propogation function 
k2 = sqrt(-1i*omega.*u0.*(gamma2 + 1i*omega.*epsilon));
k3 = sqrt(-1i*omega.*u0.*(gamma3 + 1i*omega.*epsilon));

R1 = sqrt(p^2 - k1.^2);
R2 = sqrt(p^2 - k2.^2);
R3 = sqrt(p^2 - k3.^2);

theta = @(y) u0*gamma*v*Bym(y)./(k2.^2);

A_1x = @(y) (C1*exp(-R1.*y) + C2*exp(R1.*y)).*exp(1i*p.*z + omega.*t);
A_2x = @(y) (C3*exp(-R2.*y) + C4*exp(R2.*y) + theta(y)).*exp(1i*p.*z + omega.*t);
A_3x = @(y) (C5*exp(-R3.*y) + C6*exp(R2.*y)).*exp(1i*p.*z + omega.*t);

By = @(y,z) Bsy(y,z) + 1i*p*A_2x;
Bz = @(y,z) Bsz(y,z); %- (-R2*C3.*exp(-R2.*y) + R2*C4.*exp(R2.*y) ...
     %+ (u0*gamma2.*v.*B0.*(-p.*exp(-p.*(y+d1)) + p.*exp(-p.*(-y+d2+l))))./(k2.^2))...
     %.*exp(1i.*p.*z + omega.*t);
 
Je = @(y,z) -gamma2*v.*(Bsy(y,z) + 1i*p*A_2x);

double_integrand = @(y,z) Je(y,z).*conj(Bz(y,z))
Calc1 = integral2(@(y,z)double_integrand(y,z),0,l,0,2)

