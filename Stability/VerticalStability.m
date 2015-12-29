%% Vertical Stability Paper

lambda = 0.1; % Wavelength (m)
k = 2*pi/lambda; % Wavenumber
Br = 1.45; % Remanence (T)
N = 8; % Number of magnets in array
d = 0.03; % Levitation gap (m)

ur = 200000; % Relative permeability (iron) 
u0 = 4*pi*1e-7; % Prermeability of free space 
Ie = 5; % Coil current (A)
Ne = 100; % Number of coil turns
Bre = ur*u0*Ne*Ie;

g = 9.81;
omega = sqrt(2*k*g) % Eigenfrequency of vertical oscillations (s^-1)

%% Magnetic field of Halbach array
B0 = Br*(1-exp(-k*d))*sin(pi/N)/(pi/N)

%% Magnetic Field of Electromagnet in Halbach array formation
B0e = Bre*(1-exp(-k*d))*sin(pi/N)/(pi/N)

