function [Force_y, Force_z, LtD, LtW, numMagnets, weightEstimate_kg,...
          weightEstimate_lbs, length_feet, costEstimate, skinDepth]...
                                 = DoubleHalbachModel(v,M,tau,Br,h,width,...
                                                      P,l,rho_track,d1,d2,...
                                                      coeff,profile,Jc,Jm)
% Inputs:
%   v: velocity (m/s)
%   parameters: which values to use - '3D-Final', '3D'Initial', 'Fig4'
%               'Fig7', 'Custom', '3D-Experimental'...
%   profile: 'Single', 'Double', 'Brakes', 'Stability'
%   tau_factor: Adjust Force integral tau factor
%   M: number of magnets in one array
%   tau: pole pitch (m)
%   Br: Magnet remanence (T)
%   h: Magnet height (m)
%   l: track thickness (m)

%% Universal Constants 
u0 = 4*pi*1e-7; % permeability of free space
epsilon = 8.8541878176*1e-12; % Permitivity of free space

rho_air = 1.30*1e16; % resistivity of air 
gamma_one = 1/rho_air; % Conductivity of air (S/m)
gamma_two = 1/rho_track; % Conductivity of aluminum (S/m)
gamma_three = gamma_one; % Conductivity of air (S/m)

%% Variables
p = pi/tau; 
lambda = 2*tau; % Array wavelength(m)
omega = 2*pi*v/lambda;
sigma = 1/rho_track;
t = 0;

%% Skin Depth Calculation

skinDepth = sqrt(1/(pi*(v./lambda)*u0*sigma));

%% Weight and Cost Estimates

numMagnets = P*M*2*2;
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
 
elseif(strcmp(profile,'Stability'))
    Pavg = @(y) ((u0/4)*((Jc+Jm)/p)*((sinh(p*h))./cosh(p*(y+d1+h)))).^2;
    Bsy = @(y,z) B0.*Pavg(y).*exp(1i*(p.*z + omega.*t));
    Bsz = @(y,z) B0.*Pavg(y).*exp(1i*(p.*z-pi/2+omega.*t));
end

Bym = @(y) B0.*(exp(-p*(y+d1)) - exp(-p*(-y+d2+l)));

if(strcmp(profile,'Brakes'))
    Bym = @(y) B0.*(exp(-p*(y+d1)) + exp(-p*(-y+d2+l)));

elseif(strcmp(profile,'Single'))
    Bym = @(y) B0.*(exp(-p*(y+d1)));
    d2 = 0;

elseif(strcmp(profile,'Stability'))
    Bym = @(y) B0.*(Pavg(y));
    d2 = 0;
end

% Propogation functions for air (i=1,3) and track (i=2)
k1_square = -1i*omega*u0*(gamma_one + 1i*omega*epsilon);  
k2_square = -1i*omega*u0*(gamma_two + 1i*omega*(epsilon));
k3_square = -1i*omega*u0*(gamma_three + 1i*omega*epsilon);

R1 = sqrt(p^2 - k1_square);
R2 = sqrt(p^2 - k2_square);
R3 = sqrt(p^2 - k3_square);

a = exp(-R2*l);
b = exp(R2*l);
c = exp(-R3*l);
d = exp(R3*1);

f = u0*gamma_two*v*B0/(k2_square);
A = f*(-p*exp(-p*d1) + p*exp(-p*(d2+l)));
B = f*(-p*exp(-p*(d1+l)) + p*exp(-p*d2));
C = f*(exp(-p*d1) - exp(-p*(d2+l)));
D = f*(exp(-p*(d1+l)) - exp(-p*d2));

if(strcmp(profile,'Brakes'))
    A = f*(-p*exp(-p*d1) - p*exp(-p*(d2+l)));
    B = f*(-p*exp(-p*(d1+l)) - p*exp(-p*d2));
    C = f*(exp(-p*d1) + exp(-p*(d2+l)));
    D = f*(exp(-p*(d1+l)) + exp(-p*d2));

elseif(strcmp(profile,'Single'))
    A = f*(-p*exp(-p*d1));
    B = f*(-p*exp(-p*(d1+l)));
    C = f*(exp(-p*d1));
    D = f*(exp(-p*(d1+l)));

elseif(strcmp(profile,'Stability'))
    c = (u0/4)*((Jc+Jm)/p);
    d = sinh(p*h);
    A = f*2*(c^2)*(d^2)*p*tanh(p*(d1+h))*sech(p*(d1+h))*sech(p*(d1+h));
    B = f*2*(c^2)*(d^2)*p*tanh(p*(d1+h+l))*sech(p*(d1+h+l))*sech(p*(d1+h+l));
    C = ((u0/4)*((Jc+Jm)/p)*((sinh(p*h))./cosh(p*(d1+h)))).^2;
    D = ((u0/4)*((Jc+Jm)/p)*((sinh(p*h))./cosh(p*(l+d1+h)))).^2;
end
    
% Coefficients
C1 = 0;
C6 = 0;

% Coeff set new.
% 
% R1 = R2
% C2 =(A + C*R2)/(R1 + R2);
% 
% C3 = (B*(R1 + R2) - A*b*(R2 + R3) + D*R1*R3 + D*R2*R3 + C*R1*R2*b...
%       + C*R1*R3*b)/((R1 + R2)*(a*(R2 - R3) - b*(R2 + R3)));
% 
% C4 = (B*(R1 + R2) - a*(R2 - R3)*(A - C*R1) + D*R3*(R1 + R2))/((R1 + R2)...
%       *(a*(R2 - R3) - b*(R2 + R3)));
% 
% C5 = (a*(R2*(D*(R1 + R2) - 2*A*b + 2*C*R1*b) + B*(R1 + R2))...
%       + b*(R1 + R2)*(B - D*R2))/(c*(R1 + R2)*(a*(R2 - R3) - b*(R2 + R3)));

% Latest/Best
if(strcmp(coeff,'Set2'))
C2 = (-A*b*(R1 + R2) + a*(R1 - R2)*(A - C*R2)...
     - R2*(-2*B - 2*D*R1 + b*C*(R1 + R2)))/(a*(R1 - R2)^2 - b*(R1 + R2)^2);

C3 = (B*(-R1 + R2) - A*b*(R1 + R2) + R1*(D*(-R1 + R2) + b*C*(R1 + R2)))/...
     (a*(R1 - R2)^2 - b*(R1 + R2)^2);
 
C4 = (a*(A - C*R1)*(R1 - R2) + (B + D*R1)*(R1 + R2))/...
     (a*(R1 - R2)^2 - b*(R1 + R2)^2);
 
C5 = (b*(R1 + R2)*(B - D*R2) + a*(B*(-R1 + R2)...
     + R2*(-2*A*b + 2*b*C*R1 - D*R1 + D*R2)))/(c*(a*(R1 - R2)^2 ...
     - b*(R1 + R2)^2));
end 

theta = @(y) u0*gamma_two*v*Bym(y)./(k2_square);
A_2x = @(y,z) (C3*exp(-R2.*y) + C4*exp(R2.*y) + theta(y)).*exp(1i*p.*z + omega.*t);

By = @(y,z) Bsy(y,z) + 1i*p*A_2x(y,z);
Bz = @(y,z) Bsz(y,z) - (-R2*C3*exp(-R2.*y) + R2*C4.*exp(R2.*y) ...
     +(f*(-p*exp(-p*(y+d1))+p*exp(-p*(-y+d2+l))))).*exp(1i.*p.*z + omega.*t);

if(strcmp(profile,'Brakes'))
   Bz = @(y,z) Bsz(y,z) - (-R2*C3*exp(-R2.*y) + R2*C4.*exp(R2.*y) ...
        +(f*(-p*exp(-p*(y+d1))-p*exp(-p*(-y+d2+l))))).*exp(1i.*p.*z + omega.*t); 

elseif(strcmp(profile,'Single'))
    Bz = @(y,z) Bsz(y,z) - (-R2*C3.*exp(-R2.*y) + R2*C4.*exp(R2.*y) ...
                + (u0*gamma_two.*v.*B0.*(-p.*exp(-p.*(y+d1))))./(k2_square))...
                .*exp(1i.*p.*z + omega.*t);

elseif(strcmp(profile,'Stability'))
    Bz = @(y,z) Bsz(y,z) - (-R2*C3.*exp(-R2.*y) + R2*C4.*exp(R2.*y) ...
                + (f.*2*(c^2)*(d^2)*p*tanh(p*(d1+h+y)).*sech(p*(d1+h+y)).*sech(p*(d1+h+y))))...
                .*exp(1i.*p.*z + omega.*t);
end

% Eddy current 
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

%% Scrap
%A_1x = @(y,z) (C1*exp(-R1.*y) + C2*exp(R1.*y)).*exp(1i*p.*z + omega.*t);
%A_3x = @(y,z) (C5*exp(-R3.*y) + C6*exp(R2.*y)).*exp(1i*p.*z + omega.*t);
%Bzm = @(y) B0.*(exp(-p*(y+d1)) + exp(-p*(-y+d2+l)));

% Coefficients Set1
% Results dont look good with these. Keeping them here just incase...
% C2 = (2*B*R2 - 2*D*R2*R3 + A*R2*a - A*R3*a + A*R2*b + A*R3*b - C*R2^2*a...
%      + C*R2^2*b + C*R2*R3*a + C*R2*R3*b)/(R2^2*b - R2^2*a + R1*R2*a...
%      - R1*R3*a + R2*R3*a + R1*R2*b + R1*R3*b + R2*R3*b);
%   
% C3 = -(B*R1 - B*R2 - D*R1*R3 + D*R2*R3 - A*R2*b - A*R3*b + C*R1*R2*b...
%      + C*R1*R3*b)/(R2^2*b - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a...
%      + R1*R2*b + R1*R3*b + R2*R3*b);
%  
% C4 = (B*R1 + B*R2 - D*R1*R3 - D*R2*R3 + A*R2*a - A*R3*a - C*R1*R2*a...
%      + C*R1*R3*a)/(R2^2*b - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a...
%      + R1*R2*b + R1*R3*b + R2*R3*b);
% 
% C5 = (B*R2*a - B*R1*a + B*R1*b + B*R2*b - D*R2^2*a + D*R2^2*b...
%      + D*R1*R2*a + D*R1*R2*b + 2*A*R2*a*b - 2*C*R1*R2*a*b)/(c*(R2^2*b...
%      - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a + R1*R2*b + R1*R3*b + R2*R3*b));

% Bz2
% Bz = @(y,z) Bsz(y,z) - (-R2*C3*exp(-R2.*y) + R2*C4.*exp(R2.*y) ...
%      + (u0*gamma_two.*v.*B0.*(-p.*exp(-p.*(y+d1)) + p.*exp(-p.*(-y+d2+l))))./(k2_square))...
%.*exp(1i.*p.*z + omega.*t);

%%%%%%
% C2 = (C*R2^2*b*d - C*R2^2*a*d - 2*B*R2*d - 2*D*R2*R3*c - A*R3*a*c...
%      + A*R2*a*d + A*R3*b*c + A*R2*b*d + C*R2*R3*a*c...
%      + C*R2*R3*b*c)/(R2^2*b*d - R2^2*a*d - R1*R3*a*c + R2*R3*a*c...
%      + R1*R2*a*d + R1*R3*b*c + R2*R3*b*c + R1*R2*b*d);
%  
% C3 = (B*R1*d - B*R2*d + D*R1*R3*c - D*R2*R3*c + A*R3*b*c + A*R2*b*d...
%       - C*R1*R3*b*c - C*R1*R2*b*d)/(R2^2*b*d - R2^2*a*d - R1*R3*a*c...
%       + R2*R3*a*c + R1*R2*a*d + R1*R3*b*c + R2*R3*b*c + R1*R2*b*d);
%   
% C4 = -(B*R1*d + B*R2*d + D*R1*R3*c + D*R2*R3*c + A*R3*a*c - A*R2*a*d...
%      - C*R1*R3*a*c + C*R1*R2*a*d)/(R2^2*b*d - R2^2*a*d - R1*R3*a*c...
%      + R2*R3*a*c + R1*R2*a*d + R1*R3*b*c + R2*R3*b*c + R1*R2*b*d);
%  
% C5 = (B*R1*a - B*R2*a - B*R1*b - B*R2*b - D*R2^2*a + D*R2^2*b...
%       + D*R1*R2*a + D*R1*R2*b + 2*A*R2*a*b - 2*C*R1*R2*a*b)/(R2^2*b*d...
%       - R2^2*a*d - R1*R3*a*c + R2*R3*a*c + R1*R2*a*d + R1*R3*b*c...
%       + R2*R3*b*c + R1*R2*b*d);

% Coefficients Set2
% if(strcmp(coeff,'Set2'))
% C2 = (A*R2*a - 2*D*R2*R3 - 2*B*R2 - A*R3*a + A*R2*b + A*R3*b - C*R2^2*a...
%      + C*R2^2*b + C*R2*R3*a + C*R2*R3*b)/(R2^2*b - R2^2*a + R1*R2*a...
%      - R1*R3*a + R2*R3*a + R1*R2*b + R1*R3*b + R2*R3*b);
% 
% C3 = (B*R1 - B*R2 + D*R1*R3 - D*R2*R3 + A*R2*b + A*R3*b - C*R1*R2*b...
%       - C*R1*R3*b)/(R2^2*b - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a...
%       + R1*R2*b + R1*R3*b + R2*R3*b);
% 
% C4 = -(B*R1 + B*R2 + D*R1*R3 + D*R2*R3 - A*R2*a + A*R3*a + C*R1*R2*a...
%      - C*R1*R3*a)/(R2^2*b - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a...
%      + R1*R2*b + R1*R3*b + R2*R3*b);
%  
% C5 = (B*R1*a - B*R2*a - B*R1*b - B*R2*b - D*R2^2*a + D*R2^2*b...
%      + D*R1*R2*a + D*R1*R2*b + 2*A*R2*a*b - 2*C*R1*R2*a*b)/(c*(R2^2*b...
%      - R2^2*a + R1*R2*a - R1*R3*a + R2*R3*a + R1*R2*b + R1*R3*b + R2*R3*b));
% end
