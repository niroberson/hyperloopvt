%% 3D Model

tau = .1; % Pole pitch
q = 2; % Number of magnets in pole pair
t1 = .1; % Magnet Thickness
d1 = .026; % Leviation gap
l1 = 0.4; % Length of array
w2 = 0.05; % Width of the array
Br = 1.1; % Remanence
z = 0; 
lev = -d1;


B0 = Br*(1-exp(-pi*t1/tau))*sin(pi/q)/(pi/q);
psi = @(x, y, z, x0, z0) (z-z0)./sqrt((x-x0).^2 + y.^2 + (z-z0));
By_integrand = @(x, y, z, x0) B0*y/(2*pi).*(psi(x, y, z, x0, w2/2) - ...
    psi(x, y, z, x0, -w2/2)).*exp(1i.*x0.*pi/tau)./((x-x0).^2 + y.^2);

Coeff = B0*lev/(2*pi);
i = 1;
for x = -1000:1:1000
    calc = integral(@(x0)By_integrand(x,-d1,z,x0),-l1/2,l1/2);
    By(1,i) = calc*Coeff;
    i = i + 1;
end
v = 1:1:2001;
plot(v,real(By))