function [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
          weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                = DoubleHalbachModelNew(parameters,v,d1,h)

%% Select Parameters
[vfinal,profile,M,tau,Br,h,width,l,rho_track,d1_old,d2,P,PodWeight]...
          = ParameterSelect(parameters);

%% Universal Constants 
u0 = 4*pi*1e-7; % permeability of free space
epsilon = 8.8541878176*1e-12; % Permitivity of free space

rho_air = 3.30*1e16; % resistivity of air (was 1.30)
gamma_one = 1/rho_air; % Conductivity of air (S/m)
gamma_two = 1/rho_track; % Conductivity of aluminum (S/m)
gamma_three = gamma_one; % Conductivity of air (S/m)

%% Variables
p = pi/tau; 
lambda = 2*tau; % Array wavelength(m)
omega = 2*pi.*v./lambda;
sigma = 1/rho_track;
t = 0;

%% Skin Depth Calculation
skinDepth = sqrt(1./(pi*(v./lambda)*u0*sigma));

%% Weight and Cost Estimates
numMagnets = P*M*2;
length = tau*2*P; % Pole pair * length of array
length_feet = 3.28084*length;
if(strcmp(profile,'Single'))
    numMagnets = P*M;
end

volumeOneMagnet = h*width*(tau/2);
volumeOneArray = volumeOneMagnet*M;
volumeTotal = volumeOneArray*P; % (m^2)

densityNdFeB = 7500; % Neodymium density (kg/m^2)

weightEstimate_kg = densityNdFeB*volumeTotal*2; % (kg)
weightEstimate_lbs = densityNdFeB*volumeTotal*2.20462*2; % (lbs)
if(strcmp(profile,'Single'))
    weightEstimate_kg = weightEstimate_kg/2;
    weightEstimate_lbs = weightEstimate_lbs/2;
end

NdFeB_PerPound = 325;
costEstimate = weightEstimate_kg*NdFeB_PerPound; % USD

weight = 9.80665*weightEstimate_kg; % (N)

%% Magnetic field components Bsy + Bsz
B0 = Br*(1-exp(-p*h))*sin(pi/M)/(pi/M);

Bsy = @(y,z) B0.*(exp(-p.*(y+d1)) - exp(-p.*(-y+d2+l))).*exp(1i*(p.*z + omega.*t));
Bsz = @(y,z) B0.*(exp(-p.*(y+d1)) + exp(-p.*(-y+d2+l))).*exp(1i*(p.*z-pi/2+omega.*t));

if(strcmp(profile,'Brakes'))
    Bsy = @(y,z) B0.*(exp(-p.*(y+d1)) + exp(-p.*(-y+d2+l))).*exp(1i*(p.*z + omega.*t));
    Bsz = @(y,z) B0.*(exp(-p.*(y+d1)) - exp(-p.*(-y+d2+l))).*exp(1i*(p.*z-pi/2+omega.*t));

elseif(strcmp(profile,'Single'))
    Bsy = @(y,z) B0.*(exp(-p.*(y+d1))).*exp(1i*(p.*z + omega.*t));
    Bsz = @(y,z) B0.*(exp(-p.*(y+d1))).*exp(1i*(p.*z-pi/2+omega.*t));
    
end

Bym = @(y) B0.*(exp(-p*(y+d1)) - exp(-p*(-y+d2+l)));
Bym_prime = @(y) B0.*(-p.*exp(-p*(y+d1)) + p.*exp(-p*(-y+d2+l)));

if(strcmp(profile,'Brakes'))
    Bym = @(y) B0.*(exp(-p*(y+d1)) + exp(-p*(-y+d2+l)));
    Bym_prime = @(y) B0.*(-p.*exp(-p*(y+d1)) - p.*exp(-p*(-y+d2+l)));

elseif(strcmp(profile,'Single'))
    Bym = @(y) B0.*(exp(-p*(y+d1)));
    Bym_prime = @(y) B0.*(-p.*exp(-p*(y+d1)));
    d2 = 0;
    
end


%%  Propogation functions for air (i=1,3) and track (i=2)
k1_square = -1i.*omega.*u0.*(gamma_one + 1i.*omega.*epsilon);  
k2_square = -1i.*omega.*u0.*(gamma_two + 1i.*omega.*(epsilon));
k3_square = -1i.*omega.*u0.*(gamma_three + 1i.*omega.*epsilon);

R1 = sqrt(p^2 - k1_square);
R2 = sqrt(p^2 - k2_square);
R3 = sqrt(p^2 - k3_square);

%% Theta/A_2x
theta = @(y) u0*gamma_two*v*Bym(y)./(k2_square);
theta_prime = @(y) u0*gamma_two*v*Bym_prime(y)./(k2_square);

%% Coefficients
a = exp(-R2*l);
b = exp(R2*l);
c = exp(-R3*l);
    
A = theta(0);
B = theta(l);
C = theta_prime(0);
D = theta_prime(l);

C3 = -(D*R1 - D*R2 + B*R1*R3 - B*R2*R3 - C*R2*b - C*R3*b + A*R1*R2*b...
     + A*R1*R3*b)/(R2^2*b - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a + R1*R2*b...
     + R1*R3*b + R2*R3*b);

C4 = (D*R1 + D*R2 + B*R1*R3 + B*R2*R3 + C*R2*a - C*R3*a - A*R1*R2*a...
     + A*R1*R3*a)/(R2^2*b - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a...
     + R1*R2*b + R1*R3*b + R2*R3*b);

%C3 = -(exp((3*R2)/1000)*(D*R1 - D*R2 - C*R2*exp((3*R2)/1000) - C*R3*exp((3*R2)/1000) + B*R1*R3 - B*R2*R3 + A*R1*R2*exp((3*R2)/1000) + A*R1*R3*exp((3*R2)/1000)))/(R1*R2 - R1*R3 + R2*R3 + R2^2*exp((3*R2)/500) - R2^2 + R1*R2*exp((3*R2)/500) + R1*R3*exp((3*R2)/500) + R2*R3*exp((3*R2)/500));
%C4 = (C*R2 - C*R3 + D*R1*exp((3*R2)/1000) + D*R2*exp((3*R2)/1000) - A*R1*R2 + A*R1*R3 + B*R1*R3*exp((3*R2)/1000) + B*R2*R3*exp((3*R2)/1000))/(R1*R2 - R1*R3 + R2*R3 + R2^2*exp((3*R2)/500) - R2^2 + R1*R2*exp((3*R2)/500) + R1*R3*exp((3*R2)/500) + R2*R3*exp((3*R2)/500));

%% By and Bz

A_2x = @(y,z) (C3*exp(-R2.*y) + C4*exp(R2.*y) + theta(y)).*exp(1i*p.*z + omega.*t);
By = @(y,z) Bsy(y,z) + 1i*p*A_2x(y,z);
Bz = @(y,z) Bsz(y,z) - (-R2*C3*exp(-R2*y) + R2*C4*exp(R2*y) + theta_prime(y)).*exp(1i*p.*z + omega.*t);

%% Eddy current 
Je = @(y,z) -gamma_two*v*(Bsy(y,z) + 1i*p*A_2x(y,z));

%% Force / Lift-Drag Calculations
% Force Calculations

double_integrand = @(y,z) Je(y,z).*conj(Bz(y,z));
q = integral2(@(y,z)double_integrand(y,z),0,l,0,2*tau);

Force_y = -.5*real(q)*width*P;

double_integrand = @(y,z) Je(y,z).*conj(By(y,z));
q = integral2(@(y,z)double_integrand(y,z),0,l,0,2*tau);

Force_z = -.5*real(q)*width*P;

% Lift/Drag ratio
LtD = Force_y/(Force_z);
LtW = Force_y/weight;






