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
y = -0.2:0.0001:0.4; 

%% Magnetic Fields
B0 = Br*(1-exp(-k*d)).*sin(pi/M)/(pi/M);
By = B0.*sin(k*y).*exp(-k*z);
Bz = B0.*cos(k*y).*exp(-k*z);

Bmag = B0*exp(-k*z) % (2D Approximation, no end effects)

plot(y, Bz, y, By, y, Bmag);
axis([0 0.5 -1 1]);
xlabel('y(m)');
ylabel('Components of B (T)');


%% Flux

u0 = 4*pi*1e-7;
M0 = Br/u0;

flux = (-M0/k)*(1-exp(-k*d)).*exp(k*z).*cos(k*y);
%plot(y,flux)


%% 3D Model

tau = 0.2; % Pole pitch
q = 2; % Number of magnets in pole pair
t1 = 0.2; % Magnet Thickness
d1 = 0.02; % Leviation gap
l1 = 0.5; % Length of array
w2 = 0.1; % Width of the array
z = 0;


B0 = Br*(1-exp(-pi*t1/tau))*sin(pi/q)/(pi/q);
psi = @(x, y, z, x0, z0) (z-z0)./sqrt((x-x0).^2 + y.^2 + (z-z0));
By_integrand = @(x, y, z, x0) B0*y/(2*pi).*(psi(x, y, z, x0, w2/2) - ...
    psi(x, y, z, x0, -w2/2)).*exp(1i.*x0.*pi/tau)./((x-x0).^2 + y.^2);

Coeff = B0*y/(2*pi);
i = 1;
for x = -1000:1:1000
    calc = integral(@(x0)By_integrand(x,-d1,z,x0),-l1/2,l1/2);
    %By_threeD(1,i) = calc*Coeff;
    i = i + 1;
end

