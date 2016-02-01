clear all;

%Given constants from document's experiment
num_poles = 4; %2p
p = num_poles/2; %unused
tau = 50e-3; %pole pitch
%g = 12.7e-3; %air gap length
g = 5e-3;
wp = 48e-3; %primary width
d = 20e-3; %magnet depth
lm = 25e-3; %magnet pole length
B_rem = 1.2; %Brem, magnetic remanence, in Tesla
w_p = 152.4e-3; %plate width
%plate_thickness = 9.5e-3;
plate_thickness = 0.0104648; %.412 inc
%plate_thickness = 0.0079502; %.313 inc
d_sc = plate_thickness/2;
s_p = 34.5e6; %plate conductivity


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu0 = 4*pi*1e-7; %magnetic permeability of freespace
lp = 1; %length of primary
k = pi/tau;
e = d + g; %gap or entrefer between iron regions

%----SET CONDUCTIVITY---
%see section 2.6

wsc = w_p; %width of secondary conductor
ep = pi*wp / (2*tau);
phi = pi*(wsc - wp) / (2*tau);
kn = 1 - tanh(ep) / (ep*(1 + tanh(ep)*tanh(phi))); 
%}
%kn = 1;
s = kn * s_p; %effective plate conductivity;

%------SET FRACTIONAL SPEED--------
u0 = 1 / (mu0 * s * d_sc);

u = 0:.2:110; %secondary speed
v = u ./ u0;

%----Final Force Calculations-----

% r = harmonic!
%r = 1; %the harmonic (can change in for loop) (r --> 1,3,5,7,9)
F_Brake = 0;
F_Brake_E = 0;

for r = 1:2:9

%-------SET Mpr---------
alpha = lm / tau;
M0 = B_rem / mu0;
Mpr = (4*M0/(r*pi)) * sin(r*pi*alpha/2);
   

%FINAL FORCE CALCULATIONS
%If these do not suffice, se equations 23 and 24 for actual integrals
num = lp*wp*mu0*Mpr^2*sinh(r*k*d)^2;
denom = ( sinh(r*k*e)^2 + v.^2*cosh(r*k*e)^2 ); 
Ftr = 0.5  * num * v ./ denom;
%Fnr = 0.25  * num * (1-v.^2) ./ denom;

% -- CALCULATE END CONDITIONS ---
B0 = -( mu0*Mpr*sinh(r*k*d)/(sinh(r*k*e)) ) * cos(r*alpha*pi/2);
Fte = (wp*e*B0^2/(2*mu0))*(1 - exp(-2.*v*lp / e));
Ftr_e = Ftr + Fte;
%------------------------------

%FOURIER SUMS
F_Brake = F_Brake + Ftr;
F_Brake_E = F_Brake_E + Ftr_e;

end

hold on;
plot(u, F_Brake./1000, 'k:');
plot(u, F_Brake_E./1000, 'k');

title('Braking Force vs Speed');
axis([0 105 0 7.5]);
xlabel('Speed, m/s');
ylabel('Braking Force, kN');

legend('Without End Effect', 'With End Effect');

%TO DO
%high values?
%primary end effects
%max force conditions
%Conductivity parameter?












