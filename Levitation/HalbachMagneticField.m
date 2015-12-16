%% Coordinates:
%----->y
%|
%|
%|
%V z
% x into the page

%% Magnet Parameters
t = 0.012; % Thickness of one magnet (m)
M = 8;  % Number of magnets in wavelength
numArrays = 9; % Number of arrays
length = numArrays*M*t; % Length of array (m)
lambda = length/numArrays; % Wavelength of array (m) (where it repeats)
k = 2*pi/lambda;
Br = 1.38; % Remanence (Tesla)
d = 0.025; % Height of magnet (m)
z = 0.006; % Levitation gap (m)
y = -0.2:0.0001:1.2; 

%% Magnetic Fields
B0 = Br*(1-exp(-k*d)).*sin(pi/M)/(pi/M);
By = B0.*sin(k*y).*exp(-k*z);
Bz = B0.*cos(k*y).*exp(-k*z);

Bmag = B0*exp(-k*z); % (2D Approximation, no end effects)

plot(y, Bz, y, By, y, Bmag);
axis([0 0.1 -1 1]);
xlabel('y(m)');
ylabel('Components of B (T)');

%% Flux

u0 = 4*pi*1e-7;
M0 = Br/u0;

flux = (-M0/k)*(1-exp(-k*d)).*exp(k*z).*cos(k*y);
%plot(y,flux)
