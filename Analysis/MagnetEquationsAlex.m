clear all

% Magnet Parameters (m):
tau = 0.1;    % pole pitch
l1 = 0.4;     % length of array
tau_m = 0.05; %length of signle magnet
t1 = 0.1;     % magnet thickness
w1 = .05;      % width of single magnet
Br = 1.28;    % magnet remanence
q = 2;        % number of magnets in one pole pair

% Track Parameters:
l2 = 0.8;       % length of plate
t2 = 0.006;     % thickness of plate
w2 = 1.2;       % width of aluminum plate
sigma = 2.54E7; % conductivity of plate

% Air-gap Parameters:
d1 = 0.026;        % upper air gap
d2 = 0.032;        % lower air gap
mew_0 = 4*pi*1E-7; % permeability of free space
 
v_y = 0;
v_z = 0;
v_x = 10;

xi_m = @(m) 2*pi*m./l2;
k_n = @(n) 2*pi*n./w2;
k_mn = @(m,n) sqrt((xi_m(m)).^2 + (k_n(n)).^2);

B0 = Br*(1-exp(-pi*t1/tau))*sin(pi/q)/(pi/q);
trident = @(x, y, z, x0, z0) (z-z0)./sqrt((x-x0).^2 + y.^2 + (z-z0));
By_integrand = @(x, y, z, x0) B0*y/(2*pi).*(trident(x, y, z, x0, w2/2) - trident(x, y, z, x0, -w2/2)).*exp(1i.*x0.*pi/tau)./((x-x0).^2 + y.^2);

C1_mn_s_integrand = @(x0,x,z,m,n) By_integrand(x,-d1,z,x0).*exp(-1i.*(xi_m(m).*x + k_n(n).*z));
C1_mn_s_int = @(m,n) integral3(@(x0,x,z)C1_mn_s_integrand(x0,x,z,m,n),-l2/2, l2/2, -l2/2, l2/2, -w2/2, w2/2,'Method','iterated',...
                               'AbsTol',1e-8,'RelTol',1e-10);
C1_mn_s = @(m,n) C1_mn_s_int(m,n).*(1/(l2*w2));

C3_mn_s_integrand = @(x0,x,z,m,n) By_integrand(x,d2,z,x0).*exp(-1i.*(xi_m(m).*x + k_n(n).*z));
C3_mn_s_int = @(m,n) integral3(@(x0,x,z)C3_mn_s_integrand(x0,x,z,m,n),-l2/2, l2/2, -l2/2, l2/2, -w2/2, w2/2,'Method','iterated',...
                               'AbsTol',1e-6,'RelTol',1e-10);
C3_mn_s = @(m,n) C3_mn_s_int(m,n).*(1/(l2*w2));

lambda =  -0.5*v_y*mew_0*sigma;
gamma_mn = @(m,n) sqrt(k_mn(m,n)^2 - 1i*mew_0*sigma*(xi_m(m).*v_x + k_n(n).*v_z));
beta_mn = @(m,n) sqrt(lambda.^2 + gamma_mn(m,n).^2);

U_mn = @(m,n) (lambda.^2 - (beta_mn(m,n) + k_mn(m,n)).^2).*exp(2*beta_mn(m,n)*t2) - (lambda.^2 - (beta_mn(m,n) - k_mn(m,n)).^2);
R1_mn = @(m,n) (lambda + beta_mn(m,n) - k_mn(m,n)).*(lambda - beta_mn(m,n) - k_mn(m,n)).*(1 - exp(2*beta_mn(m,n).*t2))./U_mn(m,n);
R3_mn = @(m,n) (lambda + beta_mn(m,n) + k_mn(m,n)).*(lambda - beta_mn(m,n) + k_mn(m,n)).*(1 - exp(2*beta_mn(m,n).*t2))./U_mn(m,n);
T_mn = @(m,n,y) -4*beta_mn(m,n).*k_mn(m,n).*exp(beta_mn(m,n).*t2).*exp(lambda.*(t2 + 2*y))./U_mn(m,n);

C1_mn_r = @(m,n)R1_mn(m,n).*C1_mn_s(m,n) + T_mn(m,n,-d1).*C3_mn_s(m,n);
C3_mn_r = @(m,n)R3_mn(m,n).*C3_mn_s(m,n) + T_mn(m,n,d2).*C1_mn_s(m,n);

f_mn_plus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n) + conj(C3_mn_s(m,n)).*C3_mn_r(m,n);
f_mn_minus = @(m,n) conj(C1_mn_s(m,n)).*C1_mn_r(m,n) - conj(C3_mn_s(m,n)).*C3_mn_r(m,n);

S1 = 0;
S2 = 0;

for m = -10:1:10
    for n = -10:1:10
        p = real(f_mn_minus(m,n))
        S1 = S1 + p;
    end
    S2 = S2 + S1;
end



